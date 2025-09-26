class BoardProfilesController < ApplicationController
  before_action :set_board_profile, only: %i[ show edit update destroy ]

  # GET /board_profiles or /board_profiles.json
  def index
    @board_profiles = BoardProfile.all
  end

  # GET /board_profiles/1 or /board_profiles/1.json
  def show
  end

  # GET /board_profiles/new
  def new
    @board_profile = BoardProfile.new
  end

  # GET /board_profiles/1/edit
  def edit
  end

  # POST /board_profiles or /board_profiles.json
  def create
    @board_profile = BoardProfile.new(board_profile_params)

    respond_to do |format|
      if @board_profile.save
        format.html { redirect_to @board_profile, notice: "Board profile was successfully created." }
        format.json { render :show, status: :created, location: @board_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /board_profiles/1 or /board_profiles/1.json
  def update
    respond_to do |format|
      if @board_profile.update(board_profile_params)
        format.html { redirect_to @board_profile, notice: "Board profile was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @board_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /board_profiles/1 or /board_profiles/1.json
  def destroy
    @board_profile.destroy!

    respond_to do |format|
      format.html { redirect_to board_profiles_path, notice: "Board profile was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board_profile
      @board_profile = BoardProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def board_profile_params
      params.expect(board_profile: [ :user_id, :name, :bio, :birth_date, :club_profile_id, :role ])
    end
end
