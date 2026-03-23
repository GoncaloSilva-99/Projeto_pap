class ClubExpensesController < ApplicationController
  def create
    if current_user.board?
      profile = current_user.board_profile.club_profile
    elsif current_user.club?
      profile = current_user.club_profile
    end
    @expense = profile.club_expenses.build(expense_params)
    if @expense.save
      redirect_to club_finances_dashboard_path, notice: "Despesa adicionada."
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
    @expense = profile.club_expenses.find(params[:id])
    @expense.destroy        
      redirect_to club_finances_dashboard_path, notice: "Despesa removida."
  end


  private

  def expense_params
    params.require(:club_expense).permit(:value, :description, :date)
  end
end