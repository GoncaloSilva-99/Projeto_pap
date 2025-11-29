class PlayerTeamsController < ApplicationController
  before_action :set_player_team, only: %i[ show edit update destroy ]

  # GET /player_teams or /player_teams.json
  def index
    @player_teams = PlayerTeam.all
  end

  # GET /player_teams/1 or /player_teams/1.json
  def show
  end

  # GET /player_teams/new
  def new
    @player_team = PlayerTeam.new
  end

  # GET /player_teams/1/edit
  def edit
  end

  # POST /player_teams or /player_teams.json
  def create
    @player_team = PlayerTeam.new(player_team_params)

    respond_to do |format|
      if @player_team.save
        format.html { redirect_to @player_team, notice: "Player team was successfully created." }
        format.json { render :show, status: :created, location: @player_team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_teams/1 or /player_teams/1.json
  def update
    respond_to do |format|
      if @player_team.update(player_team_params)
        format.html { redirect_to @player_team, notice: "Player team was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @player_team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_teams/1 or /player_teams/1.json
  def destroy
    @player_team.destroy!

    respond_to do |format|
      format.html { redirect_to player_teams_path, notice: "Player team was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_team
      @player_team = PlayerTeam.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def player_team_params
      params.expect(player_team: [ :player_profiles_id, :club_teams_id ])
    end
end
