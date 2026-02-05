class ClubTeamTrainingsController < ApplicationController
  before_action :set_club_team_training, only: %i[ show edit update destroy ]
  before_action :build_club_team_training, only: [:create]
  before_action :no_zone_overlap_on_pitch, only: [:create, :update]

  # GET /club_team_trainings or /club_team_trainings.json
  def index
    @club_team_trainings = ClubTeamTraining.all
  end

  # GET /club_team_trainings/1 or /club_team_trainings/1.json
  def show
  end

  # GET /club_team_trainings/new
  def new
    @club_team_training = ClubTeamTraining.new
  end

  # GET /club_team_trainings/1/edit
  def edit
  end

  # POST /club_team_trainings or /club_team_trainings.json
  def create

      duration = params[:club_team_training][:duration_minutes].to_i
      training_params = club_team_training_params.except(:duration_minutes)
      @club_team_training = ClubTeamTraining.new(training_params) 
      @club_team_training.end_time = @club_team_training.start_time + duration.minutes

    if @club_team_training.recurring
      @club_team_training.weekday = @club_team_training.start_time.wday
    end

    respond_to do |format|
      if @club_team_training.save
        @selected_sport = params[:sport]
        @selected_pitch = params[:pitch]
        @selected_ct = params[:ct]
        if @selected_ct.present?
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch, ct: @selected_ct), notice: "Treino criado com sucesso!" }
        else
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch), notice: "Treino criado com sucesso!" }
        end
        format.json { render :show, status: :created, location: @club_team_training }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_team_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_team_trainings/1 or /club_team_trainings/1.json
  def update
    if params[:club_team_training][:duration_minutes].present?
      duration = params[:club_team_training][:duration_minutes].to_i
      club_team_training_params_hash = club_team_training_params.to_h
      club_team_training_params_hash[:end_time] = club_team_training_params_hash[:start_time].to_time + duration.minutes
    end
    respond_to do |format|
      if @club_team_training.update(club_team_training_params)
        @selected_sport = params[:sport]
        @selected_pitch = params[:pitch]
        @selected_ct = params[:ct]
        if @selected_ct.present?
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch, ct: @selected_ct), notice: "Treino atualizado com sucesso!" }
        else
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch), notice: "Treino atualizado com sucesso!" }
        end
        format.json { render :show, status: :ok, location: @club_team_training }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_team_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_team_trainings/1 or /club_team_trainings/1.json
  def destroy
    @club_team_training.destroy!

    respond_to do |format|
        @selected_sport = params[:sport]
        @selected_pitch = params[:pitch]
        @selected_ct = params[:ct]
        if @selected_ct.present?
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch, ct: @selected_ct), notice: "Treino apagado com sucesso!" }
        else
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch), notice: "Treino apagado com sucesso!" }
        end
      format.json { head :no_content }
    end
  end

  private

    def build_club_team_training
      @club_team_training = ClubTeamTraining.new(club_team_training_params)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_club_team_training
      @club_team_training = ClubTeamTraining.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_team_training_params
      params.require(:club_team_training).permit(:club_pitch_id, :club_locker_room_id, :club_team_id,:start_time, :end_time, :recurring, :pitch_zone, :locker_room_time_before, :locker_room_time_after, :name)
    end

    def times_overlap_with?(training1, training2)
      t1_start = training1.start_time
      t1_end = training1.end_time
      t2_start = training2.start_time
      t2_end = training2.end_time
      t1_start < t2_end and t2_start < t1_end
    end

    def zones_conflict?(zone1, zone2)
      return true if zone1.include?("Zona A") or zone2.include?("Zona A")
      return true if zone1 == zone2
      if zone1.include?("Zona B") and (zone2.include?("Zona D") or zone2.include?("Zona E"))
        return true
      end
      if zone2.include?("Zona B") and (zone1.include?("Zona D") or zone1.include?("Zona E"))
        return true
      end
      if zone1.include?("Zona C") and (zone2.include?("Zona F") or zone2.include?("Zona G"))
        return true
      end
      if zone2.include?("Zona C") and (zone1.include?("Zona F") or zone1.include?("Zona G"))
        return true
      end
      false
    end

    def no_zone_overlap_on_pitch
      overlapping = ClubTeamTraining.where(club_pitch_id: @club_team_training.club_pitch_id).where.not(id: @club_team_training.id)
      
      if @club_team_training.recurring
        overlapping = overlapping.where(recurring: true, weekday: @club_team_training.start_time.wday)
      else
        overlapping = overlapping.where("recurring = ? OR (recurring = ? AND weekday = ? AND start_time >= ? AND start_time <= ?)", false, true, @club_team_training.start_time.wday, @club_team_training.start_time.beginning_of_day, @club_team_training.start_time.end_of_day)
      end

      overlapping.each do |training|
        if times_overlap_with?(@club_team_training, training) and zones_conflict?(@club_team_training.pitch_zone, training.pitch_zone)
          @selected_sport = params[:sport]
          @selected_pitch = params[:pitch]
          @selected_ct = params[:ct]
          
          if @selected_ct.present?
            redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch, ct: @selected_ct), alert: "As alterações não foram guardadas! Existe uma sobreposição de treinos na zona selecionada"
          else
            redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch), alert: "As alterações não foram guardadas! Existe uma sobreposição de treinos na zona selecionada"
          end
          return
        end
    end
  end


end
