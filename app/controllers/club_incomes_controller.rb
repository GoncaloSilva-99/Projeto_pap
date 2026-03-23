class ClubIncomesController < ApplicationController
  def create
    if current_user.board?
      profile = current_user.board_profile.club_profile
    elsif current_user.club?
      profile = current_user.club_profile
    end
    @income = profile.club_incomes.build(income_params)
    if @income.save
      redirect_to club_finances_dashboard_path, notice: "Receita adicionada."
    else
      render :new
    end
  end

  def destroy
    if current_user.board?
      profile = current_user.board_profile
    elsif current_user.club?
      profile = current_user.club_profile
    end
    @income = profile.club_incomes.find(params[:id])
    @income.destroy        
      redirect_to club_finances_dashboard_path, notice: "Receita removida."
  end


  private

  def income_params
    params.expect(club_income: [ :value, :description, :date ])
  end
end