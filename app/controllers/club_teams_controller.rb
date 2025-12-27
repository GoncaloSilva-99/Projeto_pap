class ClubTeamsController < ApplicationController
  before_action :set_club_team, only: %i[ show edit update destroy ]

  # GET /club_teams or /club_teams.json
  def index
    @club_teams = ClubTeam.all
  end

  # GET /club_teams/1 or /club_teams/1.json
  def show
  end

  # GET /club_teams/new
  def new
    @club_team = ClubTeam.new
  end

  # GET /club_teams/1/edit
  def edit
  end

  # POST /club_teams or /club_teams.json
  def create
    @club_team = ClubTeam.new(club_team_params)

    respond_to do |format|
      if @club_team.save
        format.html { redirect_to club_teams_dashboard_path, notice: "Equipa criada com sucesso!" }
        format.json { render :show, status: :created, location: @club_team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_teams/1 or /club_teams/1.json
  def update
    respond_to do |format|
      if @club_team.update(club_team_params)
        format.html { redirect_to club_teams_dashboard_path, notice: "Nome da equipa mudado com sucesso!" }
        format.json { render :show, status: :ok, location: @club_team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_teams/1 or /club_teams/1.json
  def destroy
    @club_team.destroy!

    respond_to do |format|
      format.html { redirect_to club_teams_path, notice: "Club team was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_team
      @club_team = ClubTeam.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_team_params
      params.expect(club_team: [ :club_profile_id, :name, :sport_id ])
    end
end
