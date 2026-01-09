class ClubPitchesController < ApplicationController
  before_action :set_club_pitch, only: %i[ show edit update destroy ]

  def remove_from_ct
    @sport = params[:sport]
    @club_pitch = ClubPitch.find(params[:pitch])
    @club_pitch.update(club_training_center_id: nil)
    respond_to do |format|
      format.html { redirect_to club_infrastructures_dashboard_path(sport: @sport), notice: "Campo removido do CT com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  def add_to_ct
    @sport = params[:sport]
    @club_pitch = ClubPitch.find(params[:pitch])
    @club_ct = params[:ct]
    @club_pitch.update(club_training_center_id: @club_ct)
    respond_to do |format|
      format.html { redirect_to club_infrastructures_dashboard_path(sport: @sport), notice: "Campo adicionado ao CT com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /club_pitches or /club_pitches.json
  def index
    @club_pitches = ClubPitch.all
  end

  # GET /club_pitches/1 or /club_pitches/1.json
  def show
  end

  # GET /club_pitches/new
  def new
    @club_pitch = ClubPitch.new
  end

  # GET /club_pitches/1/edit
  def edit
  end

  # POST /club_pitches or /club_pitches.json
  def create
    @club_pitch = ClubPitch.new(club_pitch_params)

    respond_to do |format|
      if @club_pitch.save
        format.html { redirect_to club_infrastructures_dashboard_path, notice: "Campo criado com sucesso!" }
        format.json { render :show, status: :created, location: @club_pitch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_pitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_pitches/1 or /club_pitches/1.json
  def update
    respond_to do |format|
      if @club_pitch.update(club_pitch_params)
        format.html { redirect_to club_infrastructures_dashboard_path, notice: "Campo atualizado com sucesso!", status: :see_other }
        format.json { render :show, status: :ok, location: @club_pitch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_pitch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_pitches/1 or /club_pitches/1.json
  def destroy
    @club_pitch.destroy!

    respond_to do |format|
      format.html { redirect_to club_infrastructures_dashboard_path, notice: "Campo apagado com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_pitch
      @club_pitch = ClubPitch.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_pitch_params
      params.expect(club_pitch: [ :club_profile_id, :club_training_center_id, :sport_id, :name, :pitch_picture ])
    end
end
