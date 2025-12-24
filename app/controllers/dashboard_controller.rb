class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_club_or_board
  before_action :setup_ransack

  protected

  def check_if_club_or_board
    if user_signed_in? and !current_user.club? and !current_user.board?
      redirect_to root_path, alert: "Acesso Interdito! Àrea reservada a clubes e membros da direção"
    end
  end

  def setup_ransack
    @selected_team = params[:team]

    @q = PlayerTeam.ransack(params[:q])

    @q_players = PlayerTeam.where(club_team_id: @selected_team).joins(:player_profile).ransack(params[:q])
    @player_results = @q_players.result(distinct: true)
    @num_player_results = @player_results.count

    @q_coaches = CoachTeam.where(club_team_id: @selected_team).joins(:coach_profile).ransack(params[:q])
    @coach_results = @q_coaches.result(distinct: true)
    @num_coach_results = @coach_results.count

  end

end
