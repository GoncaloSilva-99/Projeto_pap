class AdminProfilesController < ApplicationController
  before_action :set_admin_profile, only: %i[ show edit update destroy ]

  # GET /admin_profiles or /admin_profiles.json
  def index
    @admin_profiles = AdminProfile.all
  end

  # GET /admin_profiles/1 or /admin_profiles/1.json
  def show
  end

  # GET /admin_profiles/new
  def new
    @admin_profile = AdminProfile.new
  end

  # GET /admin_profiles/1/edit
  def edit
  end

  # POST /admin_profiles or /admin_profiles.json
  def create
    @admin_profile = AdminProfile.new(admin_profile_params)

    respond_to do |format|
      if @admin_profile.save
        format.html { redirect_to @admin_profile, notice: "Admin profile was successfully created." }
        format.json { render :show, status: :created, location: @admin_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_profiles/1 or /admin_profiles/1.json
  def update
    respond_to do |format|
      if @admin_profile.update(admin_profile_params)
        format.html { redirect_to @admin_profile, notice: "Admin profile was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @admin_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_profiles/1 or /admin_profiles/1.json
  def destroy
    @admin_profile.destroy!

    respond_to do |format|
      format.html { redirect_to admin_profiles_path, notice: "Admin profile was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_profile
      @admin_profile = AdminProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def admin_profile_params
      params.expect(admin_profile: [ :user_id, :name ])
    end
end
