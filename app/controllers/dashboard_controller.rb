class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_club_or_board
  before_action :club_teams, only: [:club_teams]
  before_action :setup_search_teams, only: [:club_teams]

  protected

  def check_if_club_or_board
    if user_signed_in? and !current_user.club? and !current_user.board?
      redirect_to root_path, alert: "Acesso Interdito! Àrea reservada a clubes e membros da direção"
    end
  end

  def club_teams
    selected_sport = params[:sport] || 'football'
    sport_id = selected_sport == 'football' ? 2 : 3
    
    if current_user.club?
      teams = current_user.club_profile.club_teams.where(sport_id: sport_id)
    else
      teams = current_user.board_profile.club_profile.club_teams.where(sport_id: sport_id)
    end

    if params[:team].blank? || !teams.exists?(params[:team])
      if teams.any?
        redirect_to club_teams_dashboard_path(sport: selected_sport, team: teams.first.id)
        return
      end
    end
  end

  def setup_search_teams
    @selected_team = params[:team]

    @query = params[:query]

    if @query.present?
      @player_results = PlayerProfile.search_by_name(@query).joins(:player_teams).where(player_teams: { club_team_id: @selected_team })
      @coach_results = CoachProfile.search_by_name(@query).joins(:coach_teams).where(coach_teams: { club_team_id: @selected_team })
    else
      @player_results = PlayerProfile.joins(:player_teams).where(player_teams: { club_team_id: @selected_team })
      @coach_results = CoachProfile.joins(:coach_teams).where(coach_teams: { club_team_id: @selected_team })
    end
  end



end
