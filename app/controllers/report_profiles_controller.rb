class ReportProfilesController < ApplicationController
  before_action :set_report_profile, only: %i[ show edit update destroy ]

  # GET /report_profiles or /report_profiles.json
  def index
    @report_profiles = ReportProfile.all
  end

  # GET /report_profiles/1 or /report_profiles/1.json
  def show
  end

  # GET /report_profiles/new
  def new
    @report_profile = ReportProfile.new
  end

  # GET /report_profiles/1/edit
  def edit
  end

  # POST /report_profiles or /report_profiles.json
  def create
    @report_profile = ReportProfile.new(report_profile_params)

    respond_to do |format|
      if @report_profile.save
        format.html { redirect_back fallback_location: root_path, notice: "Perfil reportado com sucesso!" }
        format.json { render :show, status: :created, location: @report_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /report_profiles/1 or /report_profiles/1.json
  def update
    respond_to do |format|
      if @report_profile.update(report_profile_params)
        format.html { redirect_to @report_profile, notice: "Report profile was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @report_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_profiles/1 or /report_profiles/1.json
  def destroy
    @report_profile.destroy!

    respond_to do |format|
      format.html { redirect_to report_profiles_path, notice: "Report profile was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report_profile
      @report_profile = ReportProfile.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def report_profile_params
      params.require(:report_profile).permit(:user_id, :content, :resolved)
    end
end
