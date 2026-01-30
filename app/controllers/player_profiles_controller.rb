class PlayerProfilesController < ApplicationController
  before_action :set_player_profile, only: %i[ show edit update destroy ]

  def remove_from_club
    @sport = params[:sport]
    @player_profile = PlayerProfile.find(params[:id])
    @player_profile.update(club_profile_id: nil)
    respond_to do |format|
      format.html { redirect_to club_teams_dashboard_path(sport: @sport), notice: "Jogador removido do clube com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /player_profiles or /player_profiles.json
  def index
    @player_profiles = PlayerProfile.all
  end

  # GET /player_profiles/1 or /player_profiles/1.json
  def show
  end

  # GET /player_profiles/new
  def new
    @player_profile = PlayerProfile.new
  end

  # GET /player_profiles/1/edit
  def edit
  end

  # POST /player_profiles or /player_profiles.json
  def create
    @player_profile = PlayerProfile.new(player_profile_params)

    respond_to do |format|
      if @player_profile.save
        format.html { redirect_to @player_profile, notice: "Player profile was successfully created." }
        format.json { render :show, status: :created, location: @player_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_profiles/1 or /player_profiles/1.json
  def update
    respond_to do |format|
      if @player_profile.update(player_profile_params)
        format.html { redirect_to @player_profile, notice: "Player profile was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @player_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_profiles/1 or /player_profiles/1.json
  def destroy
    @player_profile.destroy!

    respond_to do |format|
      format.html { redirect_to player_profiles_path, notice: "Player profile was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    def set_player_profile
      @player_profile = PlayerProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def player_profile_params
      params.expect(player_profile: [ :user_id, :name, :birth_date, :position, :bio, :contact, :parents_contact, :club_profile_id ])
    end
end
