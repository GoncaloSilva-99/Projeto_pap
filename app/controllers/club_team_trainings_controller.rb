class ClubTeamTrainingsController < ApplicationController
  before_action :set_club_team_training, only: %i[ show edit update destroy ]

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
    @club_team_training = ClubTeamTraining.new(club_team_training_params)

    if has_conflict?(@club_team_training)
      @selected_sport = params[:sport]
      @selected_pitch = params[:pitch]
      if params[:ct].present?
        @selected_ct = params[:ct]
        redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch, ct: @selected_ct), alert: "Conflito: já existe um treino neste horário para este campo ou balneário"
      else
        redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, pitch: @selected_pitch), alert: "Conflito: já existe um treino neste horário para este campo ou balneário"
      end
      return
    end

    if @club_team_training.recurring
      @club_team_training.weekday = @club_team_training.start_time.wday
    end

    respond_to do |format|
      if @club_team_training.save
        if params[:ct].present?
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
    respond_to do |format|
      if @club_team_training.update(club_team_training_params)
        format.html { redirect_to @club_team_training, notice: "Club team training was successfully updated.", status: :see_other }
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
      format.html { redirect_to club_team_trainings_path, notice: "Club team training was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_team_training
      @club_team_training = ClubTeamTraining.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_team_training_params
      params.require(:club_team_training).permit(:club_pitch_id, :club_locker_room_id, :club_team_id,:start_time, :end_time, :recurring)
    end

    def has_conflict?(training)
      pitch_conflicts = ClubTeamTraining.where(club_pitch_id: training.club_pitch_id)
      locker_conflicts = ClubTeamTraining.where(club_locker_room_id: training.club_locker_room_id)
      
      if training.recurring
        [pitch_conflicts, locker_conflicts].each do |conflicts|
          conflicts.each do |existing|
            if existing.recurring && existing.weekday == training.start_time.wday
              if times_overlap?(training, existing)
                return true
              end
            end
          end
        end
      else

        [pitch_conflicts, locker_conflicts].each do |conflicts|
          conflicts.each do |existing|
            if existing.recurring
              if existing.weekday == training.start_time.wday && times_overlap?(training, existing)
                return true
              end
            else
              if existing.start_time.to_date == training.start_time.to_date && times_overlap?(training, existing)
                return true
              end
            end
          end
        end
      end
      
      false
    end
    
    def times_overlap?(training1, training2)
      t1_start = training1.start_time.hour * 60 + training1.start_time.min
      t1_end = training1.end_time.hour * 60 + training1.end_time.min
      t2_start = training2.start_time.hour * 60 + training2.start_time.min
      t2_end = training2.end_time.hour * 60 + training2.end_time.min
      
      t1_start < t2_end && t2_start < t1_end
    end
end
