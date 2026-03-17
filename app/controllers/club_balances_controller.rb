class ClubBalancesController < ApplicationController
  before_action :set_club_balance, only: %i[ show edit update destroy ]

  # GET /club_balances or /club_balances.json
  def index
    @club_balances = ClubBalance.all
  end

  # GET /club_balances/1 or /club_balances/1.json
  def show
  end

  # GET /club_balances/new
  def new
    @club_balance = ClubBalance.new
  end

  # GET /club_balances/1/edit
  def edit
  end

  # POST /club_balances or /club_balances.json
  def create
    @club_balance = ClubBalance.new(club_balance_params)

    respond_to do |format|
      if @club_balance.save
        format.html { redirect_to @club_balance, notice: "Club balance was successfully created." }
        format.json { render :show, status: :created, location: @club_balance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @club_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /club_balances/1 or /club_balances/1.json
  def update
    respond_to do |format|
      if @club_balance.update(club_balance_params)
        format.html { redirect_to @club_balance, notice: "Club balance was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @club_balance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @club_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /club_balances/1 or /club_balances/1.json
  def destroy
    @club_balance.destroy!

    respond_to do |format|
      format.html { redirect_to club_balances_path, notice: "Club balance was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_balance
      @club_balance = ClubBalance.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def club_balance_params
      params.expect(club_balance: [ :club_profile_id, :value ])
    end
end
