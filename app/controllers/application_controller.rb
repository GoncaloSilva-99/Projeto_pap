class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :check_banned

  private

  def check_banned
    if current_user&.banned?
      reason = current_user.ban_reason
      sign_out current_user
      flash[:banned] = reason
      redirect_to new_user_session_path
    end
  end


end
