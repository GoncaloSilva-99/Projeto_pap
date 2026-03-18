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
      current_club = current_user.club? ? 
        current_user.club_profile : 
        current_user.board_profile.club_profile

      @club_balance = current_club.build_club_balance(club_balance_params)

      if @club_balance.save
        redirect_to club_finances_dashboard_path, notice: "Saldo criado."
      else
        redirect_to club_finances_dashboard_path, alert: "Erro ao criar saldo."
      end
  end

  # PATCH/PUT /club_balances/1 or /club_balances/1.json
  def update
    if @club_balance.update(club_balance_params)
      redirect_to club_finances_dashboard_path, notice: "Saldo atualizado."
    else
      redirect_to club_finances_dashboard_path, alert: "Erro ao atualizar saldo."
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
        current_club = current_user.club? ? 
          current_user.club_profile : 
          current_user.board_profile.club_profile
        @club_balance = current_club.club_balance || current_club.build_club_balance
      end


    # Only allow a list of trusted parameters through.
    def club_balance_params
      params.expect(club_balance: [ :value ])
    end
end
