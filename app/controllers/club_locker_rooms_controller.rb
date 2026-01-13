class ClubLockerRoomsController < ApplicationController
  before_action :set_club_locker_room, only: %i[ show edit update destroy ]

  def remove_from_ct
    @sport = params[:sport]
    @club_locker_room = ClubLockerRoom.find(params[:id])
    @club_locker_room.update(club_training_center_id: nil)
    respond_to do |format|
      format.html { redirect_to club_infrastructures_dashboard_path(sport: @sport), notice: "Balneário removido do CT com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  def add_to_ct
    @sport = params[:sport]
    @club_locker_room = ClubLockerRoom.find(params[:id])
    @club_ct = params[:club_locker_room][:club_training_center_id]
    @club_locker_room.update(club_training_center_id: @club_ct)
    respond_to do |format|
      format.html { redirect_to club_infrastructures_dashboard_path(sport: @sport), notice: "Balneário adicionado ao CT com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

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
        @selected_sport = params[:sport]
        if params[:ct].present?
            @selected_ct = params[:ct]
            format.html { redirect_to club_infrastructures_dashboard_path(ct: @selected_ct, sport: @selected_sport), notice: "Balneário criado com sucesso!" }
        else
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport), notice: "Balneário criado com sucesso!" }
        end
        
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
        @selected_sport = params[:sport]
        if params[:ct].present?
          @selected_ct = params[:ct]
          format.html { redirect_to club_infrastructures_dashboard_path(ct: @selected_ct, sport: @selected_sport), notice: "Balneário atualizado com sucesso!", status: :see_other }
        else
          format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport), notice: "Balneário atualizado com sucesso!", status: :see_other }
        end
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
      @selected_sport = params[:sport]
      if params[:ct].present?
        @selected_ct = params[:ct]
        format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport, ct: @selected_ct), notice: "Balneário apagado com sucesso!", status: :see_other }
      else
        format.html { redirect_to club_infrastructures_dashboard_path(sport: @selected_sport), notice: "Balneário apagado com sucesso!", status: :see_other }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_locker_room
      @club_locker_room = ClubLockerRoom.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def club_locker_room_params
      params.require(:club_locker_room).permit(:club_profile_id, :club_training_center_id, :sport_id, :name, :locker_room_picture)
    end
end
