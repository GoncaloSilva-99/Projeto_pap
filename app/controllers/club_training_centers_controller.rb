class ClubTrainingCentersController < ApplicationController
  before_action :set_club_training_center, only: %i[ show edit update destroy ]

  # GET /club_training_centers or /club_training_centers.json
  def index
    @club_training_centers = ClubTrainingCenter.all
  end

  # GET /club_training_centers/1 or /club_training_centers/1.json
  def show
  end

  # GET /club_training_centers/new
  def new
    @club_training_center = ClubTrainingCenter.new
  end

  # GET /club_training_centers/1/edit
  def edit
  end

  # POST /club_training_centers or /club_training_centers.json
  def create
    @club_training_center = ClubTrainingCenter.new(club_training_center_params)

    respond_to do |format|
      if @club_training_center.save
        format.html { redirect_to club_infrastructures_dashboard_path, notice: "Centro de treinos criado com sucesso!" }
        format.json { render :show, status: :created, location: @club_training_center }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_training_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_training_centers/1 or /club_training_centers/1.json
  def update
    respond_to do |format|
      if @club_training_center.update(club_training_center_params)
        format.html { redirect_to club_infrastructures_dashboard_path, notice: "Centro de treinos editado com sucesso!", status: :see_other }
        format.json { render :show, status: :ok, location: @club_training_center }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_training_center.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_training_centers/1 or /club_training_centers/1.json
  def destroy
    @club_training_center.destroy!

    respond_to do |format|
      format.html { redirect_to club_infrastructures_dashboard_path, notice: "Centro de treinos apagado com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_training_center
      @club_training_center = ClubTrainingCenter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_training_center_params
      params.require(:club_training_center).permit(:club_profile_id, :name, :sport_id, :ct_picture)
    end
end
