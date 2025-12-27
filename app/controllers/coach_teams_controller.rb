class CoachTeamsController < ApplicationController
  before_action :set_coach_team, only: %i[ show edit update destroy ]

  # GET /coach_teams or /coach_teams.json
  def index
    @coach_teams = CoachTeam.all
  end

  # GET /coach_teams/1 or /coach_teams/1.json
  def show
  end

  # GET /coach_teams/new
  def new
    @coach_team = CoachTeam.new
  end

  # GET /coach_teams/1/edit
  def edit
  end

  # POST /coach_teams or /coach_teams.json
  def create
    @coach_team = CoachTeam.new(coach_team_params)

    respond_to do |format|
      if @coach_team.save
        format.html { redirect_to @coach_team, notice: "Coach team was successfully created." }
        format.json { render :show, status: :created, location: @coach_team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coach_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coach_teams/1 or /coach_teams/1.json
  def update
    respond_to do |format|
      if @coach_team.update(coach_team_params)
        format.html { redirect_to @coach_team, notice: "Coach team was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @coach_team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coach_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coach_teams/1 or /coach_teams/1.json
  def destroy
    @coach_team.destroy!

    respond_to do |format|
      format.html { redirect_to club_teams_dashboard_path, notice: "Treinador removido da equipa com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach_team
      @coach_team = CoachTeam.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def coach_team_params
      params.expect(coach_team: [ :coach_profiles_id, :club_teams_id ])
    end
end
