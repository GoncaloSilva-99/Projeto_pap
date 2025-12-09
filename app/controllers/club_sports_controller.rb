class ClubSportsController < ApplicationController
  before_action :set_club_sport, only: %i[ show edit update destroy ]

  # GET /club_sports or /club_sports.json
  def index
    @club_sports = ClubSport.all
  end

  # GET /club_sports/1 or /club_sports/1.json
  def show
  end

  # GET /club_sports/new
  def new
    @club_sport = ClubSport.new
  end

  # GET /club_sports/1/edit
  def edit
  end

  # POST /club_sports or /club_sports.json
  def create
    @club_sport = ClubSport.new(club_sport_params)

    respond_to do |format|
      if @club_sport.save
        format.html { redirect_to club_teams_dashboard_path, notice: "Desporto Criado com sucesso!" }
        format.json { render :show, status: :created, location: @club_sport }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_sport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_sports/1 or /club_sports/1.json
  def update
    respond_to do |format|
      if @club_sport.update(club_sport_params)
        format.html { redirect_to @club_sport, notice: "Club sport was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @club_sport }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_sport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_sports/1 or /club_sports/1.json
  def destroy
    @club_sport.destroy!

    respond_to do |format|
      format.html { redirect_to club_teams_dashboard_path, notice: "Desporto apagado com sucesso", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_sport
      @club_sport = ClubSport.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_sport_params
      params.expect(club_sport: [ :club_profile_id, :sport_id ])
    end
end
