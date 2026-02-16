class ClubProfilesController < ApplicationController
  before_action :set_club_profile, only: %i[ show edit update destroy ]

  # GET /club_profiles or /club_profiles.json
  def index
    @club_profiles = ClubProfile.all
  end

  # GET /club_profiles/1 or /club_profiles/1.json
  def show
  end

  # GET /club_profiles/new
  def new
    @club_profile = ClubProfile.new
  end

  # GET /club_profiles/1/edit
  def edit
  end

  # POST /club_profiles or /club_profiles.json
  def create
    @club_profile = ClubProfile.new(club_profile_params)

    respond_to do |format|
      if @club_profile.save
        format.html { redirect_to @club_profile, notice: "Club profile was successfully created." }
        format.json { render :show, status: :created, location: @club_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_profiles/1 or /club_profiles/1.json
  def update
    # Handle image removal
    @club_profile.profile_picture.purge if params[:club_profile][:remove_profile_picture] == '1'
    @club_profile.banner_picture.purge if params[:club_profile][:remove_banner_picture] == '1'
    
    # Clean bio - remove indentation spaces but keep user-inserted line breaks
    bio_params = club_profile_params
    if bio_params[:bio].present?
      bio_params[:bio] = bio_params[:bio].strip.lines.map(&:strip).join("\n")
    end
    
    respond_to do |format|
      if @club_profile.update(bio_params)
        format.html { redirect_to @club_profile, notice: "Club profile was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @club_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_profiles/1 or /club_profiles/1.json
  def destroy
    @club_profile.destroy!

    respond_to do |format|
      format.html { redirect_to club_profiles_path, notice: "Club profile was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_profile
      @club_profile = ClubProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_profile_params
      params.expect(club_profile: [ :user_id, :name, :status, :approved_by, :bio, :banner_picture, :profile_picture ])
    end
end
