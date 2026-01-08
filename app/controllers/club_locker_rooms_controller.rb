class ClubLockerRoomsController < ApplicationController
  before_action :set_club_locker_room, only: %i[ show edit update destroy ]

  # GET /club_locker_rooms or /club_locker_rooms.json
  def index
    @club_locker_rooms = ClubLockerRoom.all
  end

  # GET /club_locker_rooms/1 or /club_locker_rooms/1.json
  def show
  end

  # GET /club_locker_rooms/new
  def new
    @club_locker_room = ClubLockerRoom.new
  end

  # GET /club_locker_rooms/1/edit
  def edit
  end

  # POST /club_locker_rooms or /club_locker_rooms.json
  def create
    @club_locker_room = ClubLockerRoom.new(club_locker_room_params)

    respond_to do |format|
      if @club_locker_room.save
        format.html { redirect_to @club_locker_room, notice: "Club locker room was successfully created." }
        format.json { render :show, status: :created, location: @club_locker_room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_locker_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_locker_rooms/1 or /club_locker_rooms/1.json
  def update
    respond_to do |format|
      if @club_locker_room.update(club_locker_room_params)
        format.html { redirect_to @club_locker_room, notice: "Club locker room was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @club_locker_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_locker_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_locker_rooms/1 or /club_locker_rooms/1.json
  def destroy
    @club_locker_room.destroy!

    respond_to do |format|
      format.html { redirect_to club_locker_rooms_path, notice: "Club locker room was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_locker_room
      @club_locker_room = ClubLockerRoom.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_locker_room_params
      params.expect(club_locker_room: [ :club_profile_id, :club_training_center_id, :sport_id, :name ])
    end
end
