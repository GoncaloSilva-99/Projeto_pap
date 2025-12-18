class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_club_or_board

  protected

  def check_if_club_or_board
    if user_signed_in? and !current_user.club? and !current_user.board?
      redirect_to root_path, alert: "Acesso Interdito! Àrea reservada a clubes e membros da direção"
    end
  end

end
