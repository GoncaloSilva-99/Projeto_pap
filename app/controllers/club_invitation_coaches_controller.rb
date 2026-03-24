class ClubInvitationCoachesController < ApplicationController
  before_action :set_club_invitation_coach, only: %i[ show edit update destroy ]

  # GET /club_invitation_coaches or /club_invitation_coaches.json
  def index
    @club_invitation_coaches = ClubInvitationCoach.all
  end

  # GET /club_invitation_coaches/1 or /club_invitation_coaches/1.json
  def show
  end

  # GET /club_invitation_coaches/new
  def new
    @club_invitation_coach = ClubInvitationCoach.new
  end

  # GET /club_invitation_coaches/1/edit
  def edit
  end

  # POST /club_invitation_coaches or /club_invitation_coaches.json
  def create
    @club_invitation_coach = ClubInvitationCoach.new(club_invitation_coach_params)

    respond_to do |format|
      if @club_invitation_coach.save
        format.html { redirect_to @club_invitation_coach, notice: "Club invitation coach was successfully created." }
        format.json { render :show, status: :created, location: @club_invitation_coach }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_invitation_coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_invitation_coaches/1 or /club_invitation_coaches/1.json
  def update
    respond_to do |format|
      if @club_invitation_coach.update(club_invitation_coach_params)
        format.html { redirect_to @club_invitation_coach, notice: "Club invitation coach was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @club_invitation_coach }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_invitation_coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_invitation_coaches/1 or /club_invitation_coaches/1.json
  def destroy
    @club_invitation_coach.destroy!

    respond_to do |format|
      format.html { redirect_to club_invitation_coaches_path, notice: "Club invitation coach was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_invitation_coach
      @club_invitation_coach = ClubInvitationCoach.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_invitation_coach_params
      params.expect(club_invitation_coach: [ :club_profile_id, :coach_profile_id, :status ])
    end
end
