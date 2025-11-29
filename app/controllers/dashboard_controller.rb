class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_club

  private

    def check_if_club
      return if current_user.club?

      if current_user.board?
        club_id = params[:club_id]
        board = current_user.board_profile
        redirect_to root_path, alert: "Acesso Negado! Não faz parte da direção deste clube" unless board.club_profile_id == club_id.to_i
        return
      end

      redirect_to root_path, alert: "Acesso Negado! Necessita de uma conta de clube ou conta de direção do clube para entrar"
    end

end
