  class ClubInvitationPlayersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_invitation, only: [:accept, :reject, :destroy]

    def create
      club = if current_user.club?
        current_user.club_profile
      elsif current_user.board?
        current_user.board_profile.club_profile
      else
        return redirect_back fallback_location: root_path, alert: "Sem permissão."
      end

      @player = PlayerProfile.find(params[:player_profile_id])

      @invitation = ClubInvitationPlayer.new(
        club_profile: club,
        player_profile: @player
      )

      if @invitation.save
        redirect_back fallback_location: root_path, notice: "Convite enviado!"
      else
        redirect_back fallback_location: root_path, alert: @invitation.errors.full_messages.to_sentence
      end
    end

    def accept
      unless current_user.player? && @invitation.player_profile == current_user.player_profile
        return redirect_back fallback_location: root_path, alert: "Sem permissão."
      end

      if @invitation.update(status: :accepted)
        redirect_back fallback_location: root_path, notice: "Aceitaste o convite de #{@invitation.club_profile.name}!"
      else
        redirect_back fallback_location: root_path, alert: "Erro ao aceitar convite."
      end
    end

    def reject
      unless current_user.player? && @invitation.player_profile == current_user.player_profile
        return redirect_back fallback_location: root_path, alert: "Sem permissão."
      end

      if @invitation.update(status: :rejected)
        redirect_back fallback_location: root_path, notice: "Convite rejeitado."
      else
        redirect_back fallback_location: root_path, alert: "Erro ao rejeitar convite."
      end
    end

    def destroy
      authorized = (current_user.club? && @invitation.club_profile == current_user.club_profile) ||
                  (current_user.board? && @invitation.club_profile == current_user.board_profile.club_profile)

      unless authorized
        return redirect_back fallback_location: root_path, alert: "Sem permissão."
      end

      @invitation.destroy
      redirect_back fallback_location: root_path, notice: "Convite cancelado."
    end

    private

    def set_invitation
      @invitation = ClubInvitationPlayer.find(params[:id])
    end
  end