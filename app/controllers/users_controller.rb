class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def ban
    @user = User.find(params[:id])
    @ban_reason = params[:ban_reason]
    @user.update!(banned: true, banned_by: current_user.id, ban_reason: @ban_reason)
    redirect_back fallback_location: root_path, notice: "Utilizador Banido!"
  end

  def unban
    @user = User.find(params[:id])
    @user.update!(banned: false, banned_by: nil, ban_reason: nil)
    redirect_back fallback_location: root_path, notice: "Ban removido!"
  end

  private

  def require_admin!
    redirect_to root_path unless current_user&.admin?
  end
end