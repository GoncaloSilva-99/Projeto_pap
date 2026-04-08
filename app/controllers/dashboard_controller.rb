class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_club_or_board, only: [:club_equipment, :club_finances, :club_infrastructures, :club_teams, :club_board, :club_dashboard, :club_invitations ]
  before_action :club_teams, only: [:club_teams]
  before_action :setup_search_teams, only: [:club_teams]
  before_action :setup_search_board, only: [:club_board]
  before_action :sport, only: [:club_infrastructures]
  before_action :infrastructures, only: [:club_infrastructures]
  before_action :finances, only: [:club_finances]
  before_action :setup_search_transactions, only: [:club_finances]
  before_action :set_profile, only: [:club_equipment, :club_finances, :club_infrastructures, :club_teams, :club_board, :club_dashboard, :club_invitations ]
  before_action :materials, only: [:club_equipment ]
  before_action :setup_search_material, only: [:club_equipment]
  before_action :dashboard, only: [:club_dashboard]
  before_action :invitations, only: [:club_invitations]
  before_action :check_if_admin, only: [:admin_dashboard]
  before_action :admin_dashboard, only: [:admin_dashboard]
  before_action :admins, only: [:admins]
  before_action :club_verification, only: [:club_verification]

  protected

  def club_verification
    @type = params[:type] || "Pendentes"

    if @type == "Pendentes"
      @clubs_query = ClubProfile.where(status: 'pending')
    elsif @type == "Aprovados"
      @clubs_query = ClubProfile.where(status: 'verified')
    elsif @type == "Rejeitados"
      @clubs_query = ClubProfile.where(status: 'rejected')
    end

    if params[:query].present?
      if @type == "Pendentes"
        @clubs_query = ClubProfile.search_by_name(params[:query]).where(status: 'pending')
      elsif @type == "Aprovados"
        @clubs_query = ClubProfile.search_by_name(params[:query]).where(status: 'verified')
      elsif @type == "Rejeitados"
        @clubs_query = ClubProfile.search_by_name(params[:query]).where(status: 'rejected')
      end
      @clubs = @clubs_query.page(params[:clubs_page]).per(8)
      @clubs_count = @clubs.count
    end

    @clubs = @clubs_query.page(params[:admin_page]).per(8)
    @clubs_count = @clubs.count
    
  end

  def admins
    @admin_type = params[:type] || "Todos"

    if @admin_type == "Todos"
      @admin_list_query = AdminProfile.all
    elsif @admin_type == "Super Admin"
      @admin_list_query = AdminProfile.where(role: 'Super Admin')
    elsif @admin_type == "Admin Regular"
      @admin_list_query = AdminProfile.where(role: 'Admin Regular')
    end

    if params[:query].present?
      if @admin_type == "Todos"
        @admin_list_query = AdminProfile.search_by_name(params[:query])
      elsif @admin_type == "Super Admin"
        @admin_list_query = AdminProfile.search_by_name(params[:query]).where(role: 'Super Admin')
      elsif @admin_type == "Admin Regular"
        @admin_list_query = AdminProfile.search_by_name(params[:query]).where(role: 'Admin Regular')
      end
      @admins = @admin_list_query.page(params[:admin_page]).per(8)
      @admins_count = @admins.count
    end

    @admins = @admin_list_query.page(params[:admin_page]).per(8)
    @admins_count = @admins.count
    
  end

  def admin_dashboard
    @total_users = User.count
    @total_clubs_aprovados = ClubProfile.where(status: true).count
    @total_posts = Post.count
    @clubes_pendentes = ClubProfile.where(status: [false, nil]).count

    @novos_users_semana = User.where(created_at: 1.week.ago..Time.current).count
    @novos_clubs_aprovados_semana = ClubProfile.where(status: true, updated_at: 1.week.ago..Time.current).count
    @novos_posts_semana = Post.where(created_at: 1.week.ago..Time.current).count
    @novos_pendentes_semana = ClubProfile.where(status: [false, nil], created_at: 1.week.ago..Time.current).count


    @total_jogadores = PlayerProfile.count
    @total_treinadores = CoachProfile.count
    @total_admins = AdminProfile.count

    @novos_jogadores = PlayerProfile.where(created_at: 1.week.ago..Time.current).count
    @novos_treinadores = CoachProfile.where(created_at: 1.week.ago..Time.current).count
    @novos_admins = AdminProfile.where(created_at: 1.week.ago..Time.current).count


    @novos_jogadores_semana = @novos_jogadores
    @novos_treinadores_semana = @novos_treinadores
    @novos_clubes_semana = ClubProfile.where(created_at: 1.week.ago..Time.current).count


    @total_likes = PostLike.count
    @total_comentarios = PostComment.count
    @total_views = PostView.count

    @novos_likes_semana = PostLike.where(created_at: 1.week.ago..Time.current).count
    @novos_comentarios_semana = PostComment.where(created_at: 1.week.ago..Time.current).count
    @novas_views_semana = PostView.where(created_at: 1.week.ago..Time.current).count


    @reportes_por_resolver = ReportProfile.where(resolved: [false, nil]).count
    @reportes_resolvidos = ReportProfile.where(resolved: true).count
    @novos_reportes_semana = ReportProfile.where(created_at: 1.week.ago..Time.current).count


    @desportos = Sport.all.map do |sport|
      {
        nome: sport.name,
        clubes: ClubSport.where(sport_id: sport.id).count,
        jogadores: PlayerProfile.where(sport: sport.name).count,
        treinadores: CoachProfile.where(sport: sport.name).count,
        novos_jogadores: PlayerProfile.where(sport: sport.name, created_at: 1.week.ago..Time.current).count,
        novos_treinadores: CoachProfile.where(sport: sport.name, created_at: 1.week.ago..Time.current).count
      }
    end


    @total_follows = Follow.count
    @total_saves = PostSafe.count
    @novos_follows_semana = Follow.where(created_at: 1.week.ago..Time.current).count
    @novos_saves_semana = PostSafe.where(created_at: 1.week.ago..Time.current).count
  end
  
  def invitations
    @club = current_user.club? ? current_user.club_profile : current_user.board_profile.club_profile

    if params[:sport]
      @selected_sport = params[:sport]
    elsif @club.has_football?
      @selected_sport = 'football'
    elsif @club.has_handball?
      @selected_sport = 'handball'
    end

    @selected_type = params[:type] || 'pending'

    @player_invitations = ClubInvitationPlayer
      .joins(:player_profile)
      .where(club_profile_id: @club.id, status: @selected_type, player_profiles: { sport: @selected_sport })

    @coach_invitations = ClubInvitationCoach
      .joins(:coach_profile)
      .where(club_profile_id: @club.id, status: @selected_type, coach_profiles: { sport: @selected_sport})


    @player_invitations_results = @player_invitations.page(params[:player_invitations_page]).per(4)
    @coach_invitations_results  = @coach_invitations.page(params[:coach_invitations_page]).per(4)

    if params[:query].present?
      matching_player_ids = PlayerProfile.search_by_name(params[:query]).pluck(:id)
      @player_invitations_results = @player_invitations
        .where(player_profile_id: matching_player_ids)
        .page(params[:player_invitations_page]).per(4)

      matching_coach_ids = CoachProfile.search_by_name(params[:query]).pluck(:id)
      @coach_invitations_results = @coach_invitations
        .where(coach_profile_id: matching_coach_ids)
        .page(params[:coach_invitations_page]).per(4)
    end

    @player_invitations_count = @player_invitations_results.count
    @coach_invitations_count  = @coach_invitations_results.count
  end


  def dashboard
    @club_profile = current_user.club? ? current_user.club_profile : current_user.board_profile.club_profile
    club_id = @club_profile.id

    hoje = Date.current
    fim_semana = hoje.end_of_week(:monday)


    # MEMBROS
    @total_jogadores = PlayerProfile.where(club_profile_id: club_id).count
    @total_treinadores = CoachProfile.where(club_profile_id: club_id).count
    @total_equipas = ClubTeam.where(club_profile_id: club_id).count
    @jogadores_sem_equipa = PlayerProfile.where(club_profile_id: club_id).where.not(id: PlayerTeam.select(:player_profile_id)).count
    @treinadores_sem_equipa = CoachProfile.where(club_profile_id: club_id).left_joins(:coach_teams).where(coach_teams: { id: nil }).count

    # MEMBROS POR DESPORTO
    @jogadores_futebol = PlayerProfile.where(club_profile_id: club_id, sport: 'football').count
    @jogadores_andebol = PlayerProfile.where(club_profile_id: club_id, sport: 'handball').count
    @treinadores_futebol = CoachProfile.where(club_profile_id: club_id, sport: 'football').count
    @treinadores_andebol = CoachProfile.where(club_profile_id: club_id, sport: 'handball').count

    # FINANÇAS
    @saldo = ClubBalance.find_by(club_profile_id: club_id)
    @receitas_mes = ClubIncome.where(club_profile_id: club_id).where(date: Date.current.beginning_of_month..Date.current.end_of_month).sum(:value)
    @despesas_mes = ClubExpense.where(club_profile_id: club_id).where(date: Date.current.beginning_of_month..Date.current.end_of_month).sum(:value)
    @balanco_mes = @receitas_mes - @despesas_mes

    @top_despesas = ClubExpense
      .where(club_profile_id: club_id)
      .where(date: Date.current.beginning_of_month..Date.current.end_of_month)
      .order(value: :desc)
      .limit(4)

    ultimas_despesas = ClubExpense.where(club_profile_id: club_id).order(date: :desc).limit(3)
      .map { |d| { tipo: :despesa, descricao: d.description, valor: d.value, data: d.date } }
    ultimas_receitas = ClubIncome.where(club_profile_id: club_id).order(date: :desc).limit(3)
      .map { |r| { tipo: :receita, descricao: r.description, valor: r.value, data: r.date } }
    @ultimas_transacoes = (ultimas_despesas + ultimas_receitas).sort_by { |t| t[:data] }.reverse.first(4)

    # INFRAESTRUTURAS
    @total_campos = ClubPitch.where(club_profile_id: club_id).count
    @total_balnearios = ClubLockerRoom.where(club_profile_id: club_id).count
    @total_cts = ClubTrainingCenter.where(club_profile_id: club_id).count

    treinos_normais = ClubTeamTraining
      .joins(club_team: :club_profile)
      .where(club_profiles: { id: club_id })
      .where(recurring: false)
      .where(start_time: Time.current..fim_semana.end_of_day)
      .order(:start_time)
      .limit(5)

    treinos_recorrentes = ClubTeamTraining
      .joins(club_team: :club_profile)
      .where(club_profiles: { id: club_id })
      .where(recurring: true)

    virtual_recorrentes = []
    treinos_recorrentes.each do |treino|
      (hoje..fim_semana).each do |dia|
        next unless dia.wday == treino.weekday
        next unless treino.start_time.present?
        hora_inicio = dia.in_time_zone('Lisbon').change(hour: treino.start_time.hour, min: treino.start_time.min)
        next unless hora_inicio > Time.current
        virtual = treino.dup
        virtual.start_time = hora_inicio
        virtual_recorrentes << virtual
      end
    end

    @proximos_treinos = (treinos_normais.to_a + virtual_recorrentes).sort_by(&:start_time).first(5)

     treinos_normais_semana = ClubTeamTraining
      .joins(club_team: :club_profile)
      .where(club_profiles: { id: club_id })
      .where(recurring: false)
      .where(start_time: hoje.beginning_of_day..fim_semana.end_of_day)
      .count

    @treinos_esta_semana = treinos_normais_semana + virtual_recorrentes.count

    @top_receitas = ClubIncome
    .where(club_profile_id: club_id)
    .where(date: Date.current.beginning_of_month..Date.current.end_of_month)
    .order(value: :desc)
    .limit(4)

    # MATERIAL
    @total_materiais = ClubMaterial.where(club_profile_id: club_id).count
    @materiais_esgotados = ClubMaterial.where(club_profile_id: club_id).where("CAST(quantity AS INTEGER) = 0").count
    @materiais_futebol = ClubMaterial.where(club_profile_id: club_id, sport: 'Futebol').count
    @materiais_andebol = ClubMaterial.where(club_profile_id: club_id, sport: 'Andebol').count
  end

  def setup_search_material
    @query = params[:query]

    if @query.present?
      @geral_materials_query = ClubMaterial.search_by_name(@query).where(club_profile_id: @club_id)
      @football_materials_query = ClubMaterial.search_by_name(@query).where(club_profile_id: @club_id, sport: 'Futebol')
      @handball_materials_query = ClubMaterial.search_by_name(@query).where(club_profile_id: @club_id, sport: 'Andebol')

      @num_geral_materials = @geral_materials_query.count
      @num_football_materials = @football_materials_query.count
      @num_handball_materials = @handball_materials_query.count

      @geral_materials = @geral_materials_query.page(params[:geral_page]).per(8)
      @football_materials = @football_materials_query.page(params[:football_page]).per(8)
      @handball_materials = @handball_materials_query.page(params[:handball_page]).per(8)
    end
  end

  def materials
    @selected_sport = params[:sport]
    @club_profile = current_user.club? ? current_user.club_profile : current_user.board_profile.club_profile
    if !@selected_sport
      if @club_profile.has_both_sports?
        @selected_sport = 'Geral'
      elsif @club_profile.has_football?
        @selected_sport = 'Futebol'
      elsif @club_profile.has_handball?
        @selected_sport = 'Andebol'
      end
    end
    @club_id = current_user.club? ? current_user.club_profile.id : current_user.board_profile.club_profile.id
    @geral_materials_query = ClubMaterial.where(club_profile_id: @club_id)
    @football_materials_query = ClubMaterial.where(club_profile_id: @club_id, sport: 'Futebol')
    @handball_materials_query = ClubMaterial.where(club_profile_id: @club_id, sport: 'Andebol')

    @num_geral_materials = @geral_materials_query.count
    @num_football_materials = @football_materials_query.count
    @num_handball_materials = @handball_materials_query.count

    @geral_materials = @geral_materials_query.page(params[:geral_page]).per(8)
    @football_materials = @football_materials_query.page(params[:football_page]).per(8)
    @handball_materials = @handball_materials_query.page(params[:handball_page]).per(8)

  end


  def set_profile
    @club_profile = current_user.club? ? current_user.club_profile : current_user.board_profile.club_profile
  end

  def finances
      @club_id = current_user.club? ? current_user.club_profile.id : current_user.board_profile.club_profile.id
      @first_of_month = params[:start_date] ?  Date.parse(params[:start_date]).beginning_of_month : Date.current.beginning_of_month
      @last_of_month =  params[:start_date] ?  Date.parse(params[:start_date]).end_of_month : Date.current.end_of_month
      @current_month = l(@first_of_month, format: "%B")
      @current_year = @first_of_month.year
      
      @month_expenses = ClubExpense.where(club_profile_id: @club_id).where("date >= ? AND date <= ?", @first_of_month, @last_of_month)
      @month_expenses_total = 0
      @month_expenses.each do |expense|
        @month_expenses_total = @month_expenses_total + expense.value
      end
      @month_incomes = ClubIncome.where(club_profile_id: @club_id).where("date >= ? AND date <= ?", @first_of_month, @last_of_month)
      @month_incomes_total = 0
      @month_incomes.each do |income|
        @month_incomes_total = @month_incomes_total + income.value
      end
      @club_balance = ClubBalance.find_by(club_profile_id: @club_id)


  end

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
      
      @weekly_trainings = ClubTeamTraining.where(club_pitch_id: @selected_pitch, recurring: false).where("start_time >= ? AND start_time <= ?", @start_date, @end_date.end_of_day).order(:start_time)
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


  if @selected_locker_room
    @selected_team_lr = params[:team]
    @start_date_lr = params[:start_date] ? Date.parse(params[:start_date]).beginning_of_week(:monday) : Date.today.beginning_of_week(:monday)
    @end_date_lr = @start_date_lr + 6.days
    
    @weekly_occupations = ClubTeamTraining.where(club_locker_room_id: @selected_locker_room, recurring: false).where("start_time >= ? AND start_time <= ?", @start_date_lr, @end_date_lr.end_of_day).order(:start_time)
    @recurring_occupations = ClubTeamTraining.where(club_locker_room_id: @selected_locker_room, recurring: true)
    
    @occupations_by_date = {}
    (@start_date_lr..@end_date_lr).each do |date|
      @occupations_by_date[date] = []
    end

    @weekly_occupations.each do |occupation|
      date = occupation.start_time.to_date
      @occupations_by_date[date] << occupation if @occupations_by_date.key?(date)
    end

    @recurring_occupations.each do |recurring|
      (@start_date_lr..@end_date_lr).each do |date|
        if date.wday == recurring.weekday
          if recurring.start_time.present? && recurring.end_time.present?
            virtual_occupation = recurring.dup
            virtual_occupation.start_time = date.in_time_zone('Lisbon').change(hour: recurring.start_time.hour, min: recurring.start_time.min)
            virtual_occupation.end_time = date.in_time_zone('Lisbon').change(hour: recurring.end_time.hour, min: recurring.end_time.min)
            virtual_occupation.id = recurring.id
            @occupations_by_date[date] << virtual_occupation
          end
        end
      end
    end
    
    @occupations_by_date.each do |date, occupations|
      @occupations_by_date[date] = occupations.sort_by(&:start_time)
    end
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
    if user_signed_in? and !current_user.club? and !current_user.board? and !current_user.admin?
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

  def setup_search_transactions
    club_id = current_user.club? ? current_user.club_profile.id : current_user.board_profile.club_profile.id
    @query = params[:query]

    if @query.present?
      @month_expenses = ClubExpense.search_by_description(@query).where(club_profile_id: @club_id).where("date >= ? AND date <= ?", @first_of_month, @last_of_month)
      @month_incomes = ClubIncome.search_by_description(@query).where(club_profile_id: @club_id).where("date >= ? AND date <= ?", @first_of_month, @last_of_month)
    end
  end

  def check_if_admin
    if user_signed_in? and !current_user.admin?
      redirect_to root_path, alert: "Acesso Interdito! Àrea reservada a Admins"
    end
  end



end
