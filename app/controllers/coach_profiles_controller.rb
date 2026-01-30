class CoachProfilesController < ApplicationController
  before_action :set_coach_profile, only: %i[ show edit update destroy ]

  def remove_from_club
    @sport = params[:sport]
    @coach_profile = CoachProfile.find(params[:id])
    @coach_profile.update(club_profile_id: nil)
    respond_to do |format|
      format.html { redirect_to club_teams_dashboard_path(sport: @sport), notice: "Treinador removido do clube com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /coach_profiles or /coach_profiles.json
  def index
    @coach_profiles = CoachProfile.all
  end

  # GET /coach_profiles/1 or /coach_profiles/1.json
  def show
  end

  # GET /coach_profiles/new
  def new
    @coach_profile = CoachProfile.new
  end

  # GET /coach_profiles/1/edit
  def edit
  end

  # POST /coach_profiles or /coach_profiles.json
  def create
    @coach_profile = CoachProfile.new(coach_profile_params)

    respond_to do |format|
      if @coach_profile.save
        format.html { redirect_to @coach_profile, notice: "Coach profile was successfully created." }
        format.json { render :show, status: :created, location: @coach_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coach_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coach_profiles/1 or /coach_profiles/1.json
  def update
    respond_to do |format|
      if @coach_profile.update(coach_profile_params)
        format.html { redirect_to @coach_profile, notice: "Coach profile was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @coach_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coach_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coach_profiles/1 or /coach_profiles/1.json
  def destroy
    @coach_profile.destroy!

    respond_to do |format|
      format.html { redirect_to coach_profiles_path, notice: "Coach profile was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach_profile
      @coach_profile = CoachProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def coach_profile_params
      params.expect(coach_profile: [ :user_id, :name, :birth_date, :club_id, :coach_type ])
    end
end
