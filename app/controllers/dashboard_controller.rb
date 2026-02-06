class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_club_or_board
  before_action :club_teams, only: [:club_teams]
  before_action :setup_search_teams, only: [:club_teams]
  before_action :setup_search_board, only: [:club_board]
  before_action :sport, only: [:club_infrastructures]
  before_action :infrastructures, only: [:club_infrastructures]

  protected

  def infrastructures
    @selected_ct = params[:ct].present? ? params[:ct].to_i : nil
    @selected_sport = params[:sport]
    @selected_pitch = params[:pitch].present? ? params[:pitch].to_i : nil
    @selected_locker_room = params[:locker_room].present? ? params[:locker_room].to_i : nil
    club_id = current_user.club? ? current_user.club_profile.id : current_user.board_profile.club_profile.id
    sport_id = @selected_sport == 'football' ? 2 : 3
    club_ct_query = ClubTrainingCenter.where(club_profile_id: club_id, sport_id: sport_id)
    @club_ct_results = club_ct_query.page(params[:club_ct_page]).per(4)
    if @selected_ct
      club_pitches_query = ClubPitch.where(club_profile_id: club_id, sport_id: sport_id, club_training_center_id: @selected_ct)
      club_locker_rooms_query = ClubLockerRoom.where(club_profile_id: club_id, sport_id: sport_id, club_training_center_id: @selected_ct)
    else
      club_pitches_query = ClubPitch.where(club_profile_id: club_id, sport_id: sport_id, club_training_center_id: nil)
      club_locker_rooms_query = ClubLockerRoom.where(club_profile_id: club_id, sport_id: sport_id, club_training_center_id: nil)
    end
    @club_pitches_results = club_pitches_query.page(params[:club_pitches_page]).per(4)
    @club_locker_rooms_results = club_locker_rooms_query.page(params[:club_locker_rooms_page]).per(4)
    @base_num_club_ct = ClubTrainingCenter.where(club_profile_id: club_id, sport_id: sport_id).count


    if @selected_pitch
      @selected_team = params[:team]
      @start_date = params[:start_date] ? Date.parse(params[:start_date]).beginning_of_week(:monday) : Date.today.beginning_of_week(:monday)
      @end_date = @start_date + 6.days
      
      @weekly_trainings = ClubTeamTraining.where(club_pitch_id: @selected_pitch, recurring: false ).where("start_time >= ? AND start_time <= ?", @start_date, @end_date.end_of_day).order(:start_time)
      @recurring_trainings = ClubTeamTraining.where(club_pitch_id: @selected_pitch, recurring: true)
      
      @trainings_by_date = {}
      (@start_date..@end_date).each do |date|
        @trainings_by_date[date] = []
      end

      @weekly_trainings.each do |training|
        date = training.start_time.to_date
        @trainings_by_date[date] << training if @trainings_by_date.key?(date)
      end

      @recurring_trainings.each do |recurring|
        (@start_date..@end_date).each do |date|
          if date.wday == recurring.weekday
            if recurring.start_time.present? && recurring.end_time.present?
              virtual_training = recurring.dup
              virtual_training.start_time = date.in_time_zone('Lisbon').change(hour: recurring.start_time.hour, min: recurring.start_time.min)
              virtual_training.end_time = date.in_time_zone('Lisbon').change(hour: recurring.end_time.hour, min: recurring.end_time.min)
              virtual_training.id = recurring.id
              @trainings_by_date[date] << virtual_training
            end
          end
        end
      end
      
      @trainings_by_date.each do |date, trainings|
        @trainings_by_date[date] = trainings.sort_by(&:start_time)
      end
      
      
      @available_locker_rooms = ClubLockerRoom.where(club_profile_id: club_id, sport_id: sport_id, club_training_center_id: @selected_ct || nil)
      @available_teams = ClubTeam.where(club_profile_id: club_id, sport_id: sport_id)
      @selected_pitch_obj = ClubPitch.find(@selected_pitch)
      @available_zones = @selected_pitch_obj.fut11? ? ClubPitch::PITCH_ZONES_11 : ClubPitch::PITCH_ZONES_OTHERS
    end


  end

  def sport
    club = current_user.club? ? current_user.club_profile : current_user.board_profile.club_profile
    if params[:sport].blank?
      if club.has_football?
        redirect_to club_infrastructures_dashboard_path(sport: 'football') and return
      elsif club.has_handball?
        redirect_to club_infrastructures_dashboard_path(sport: 'handball') and return
      end
    end
    @selected_sport = params[:sport]
  end

  def check_if_club_or_board
    if user_signed_in? and !current_user.club? and !current_user.board?
      redirect_to root_path, alert: "Acesso Interdito! Àrea reservada a clubes e membros da direção"
    end
  end

  def club_teams

    club = current_user.club? ? current_user.club_profile : current_user.board_profile.club_profile
    if params[:sport].blank?
      if club.has_football?
        redirect_to club_teams_dashboard_path(sport: 'football') and return
      elsif club.has_handball?
        redirect_to club_teams_dashboard_path(sport: 'handball') and return
      end
    end

    @selected_sport = params[:sport]
    @sport_id = @selected_sport == 'football' ? 2 : 3

   
    if current_user.club?
      teams = current_user.club_profile.club_teams.where(sport_id: @sport_id)
    else
      teams = current_user.board_profile.club_profile.club_teams.where(sport_id: @sport_id)
    end

    if params[:team].blank? || (!teams.exists?(params[:team]) && params[:team] != 'others')
      if teams.any?
        redirect_to club_teams_dashboard_path(sport: @selected_sport, team: teams.first.id)
        return
      end
    end
  end

  def setup_search_teams
    @selected_team = params[:team].to_s
    @selected_sport = params[:sport]
    club_id = current_user.club? ? current_user.club_profile.id : current_user.board_profile.club_profile.id
    @query = params[:query]

    if @query.present?
        if @selected_team == 'others' and @selected_sport == 'football'
          player_query = PlayerProfile.search_by_name(@query).where(club_profile_id: club_id, sport: 'football').left_joins(:player_teams).where(player_teams: { id: nil })
          coach_query = CoachProfile.search_by_name(@query).where(club_profile_id: club_id, sport: 'football').left_joins(:coach_teams).where(coach_teams: { id: nil })
        elsif @selected_team == 'others' and @selected_sport == 'handball'
          player_query = PlayerProfile.search_by_name(@query).where(club_profile_id: club_id, sport: 'handball').left_joins(:player_teams).where(player_teams: { id: nil })
          coach_query = CoachProfile.search_by_name(@query).where(club_profile_id: club_id, sport: 'handball').left_joins(:coach_teams).where(coach_teams: { id: nil })
        else
          player_query = PlayerProfile.search_by_name(@query).joins(:player_teams).where(player_teams: { club_team_id: @selected_team })
          coach_query = CoachProfile.search_by_name(@query).joins(:coach_teams).where(coach_teams: { club_team_id: @selected_team })
        end
    else
      if @selected_team == 'others' and @selected_sport == 'football'
        player_query = PlayerProfile.where(club_profile_id: club_id, sport: 'football').left_joins(:player_teams).where(player_teams: { id: nil })
        coach_query = CoachProfile.where(club_profile_id: club_id, sport: 'football').left_joins(:coach_teams).where(coach_teams: { id: nil })
      elsif @selected_team == 'others' and @selected_sport == 'handball'
        player_query = PlayerProfile.where(club_profile_id: club_id, sport: 'handball').left_joins(:player_teams).where(player_teams: { id: nil })
        coach_query = CoachProfile.where(club_profile_id: club_id, sport: 'handball').left_joins(:coach_teams).where(coach_teams: { id: nil })
      else
        player_query = PlayerProfile.joins(:player_teams).where(player_teams: { club_team_id: @selected_team })
        coach_query = CoachProfile.joins(:coach_teams).where(coach_teams: { club_team_id: @selected_team })
      end
    end

    @player_results = player_query.page(params[:player_page]).per(4)
    @coach_results = coach_query.page(params[:coach_page]).per(4)

    @base_num_players = PlayerProfile.joins(:player_teams).where(player_teams: { club_team_id: @selected_team }).count
    @base_num_coaches = CoachProfile.joins(:coach_teams).where(coach_teams: { club_team_id: @selected_team }).count
    @base_football_players_wo_team = PlayerProfile.where(club_profile_id: club_id, sport: 'football').left_joins(:player_teams).where(player_teams: { id: nil }).count
    @base_handball_players_wo_team = PlayerProfile.where(club_profile_id: club_id, sport: 'handball').left_joins(:player_teams).where(player_teams: { id: nil }).count
    @base_football_coaches_wo_team = CoachProfile.where(club_profile_id: club_id, sport: 'football').left_joins(:coach_teams).where(coach_teams: { id: nil }).count
    @base_handball_coaches_wo_team = CoachProfile.where(club_profile_id: club_id, sport: 'handball').left_joins(:coach_teams).where(coach_teams: { id: nil }).count

    @sport_id = @selected_sport == 'football' ? 2 : 3
    club_ct_query = ClubTrainingCenter.where(club_profile_id: club_id, sport_id: @sport_id)
    club_pitches_query = ClubPitch.where(club_profile_id: club_id, sport_id: @sport_id)
    club_locker_rooms_query = ClubLockerRoom.where(club_profile_id: club_id, sport_id: @sport_id)
    @base_num_club_ct = club_ct_query.count
    @base_num_club_pitches = club_pitches_query.count
    @base_num_club_locker_rooms = club_locker_rooms_query.count
  end

  def setup_search_board
    @query = params[:query]
    club_id = current_user.club? ? current_user.club_profile.id : current_user.board_profile.club_profile.id
    if @query.present?
      board_query = BoardProfile.search_by_name(@query).where(club_profile_id: club_id )
    else
      board_query = BoardProfile.where(club_profile_id: club_id)
    end

    @board_results = board_query.page(params[:board_page]).per(4)
    @base_num_board = BoardProfile.where(club_profile_id: club_id).count
  end



end
