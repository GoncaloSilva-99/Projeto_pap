class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :destroy]

  def create
    if current_user.follow(@user)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "follow_button_suggestion_#{@user.id}",
              partial: "follows/follow_button_suggestions",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "follow_button_suggestion_modal_#{@user.id}",
              partial: "follows/follow_button_suggestions_modal",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "follow_button_profiles_#{@user.id}",
              partial: "follows/follow_button_profiles",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "followers_count_#{@user.id}",
              partial: "follows/followers_count",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "followers_list_#{@user.id}",
              partial: "follows/followers_list",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "following_count_#{@user.id}",
              partial: "follows/following_count",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "following_list_#{@user.id}",
              partial: "follows/following_list",
              locals: { user: @user }
            )
          ] 
        end
        format.html { redirect_back(fallback_location: root_path, notice: "A seguir #{@user.email}" ) }
      end
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_back(fallback_location: root_path, alert: "Erro ao seguir o utilizador") }
      end
    end
  end

  def destroy
    @follow = current_user.following_relationships.find_by(followed_id: params[:user_id])
    
    if @follow&.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "follow_button_suggestion_#{@user.id}",
              partial: "follows/follow_button_suggestions",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "follow_button_suggestion_modal_#{@user.id}",
              partial: "follows/follow_button_suggestions_modal",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "follow_button_profiles_#{@user.id}",
              partial: "follows/follow_button_profiles",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "followers_count_#{@user.id}",
              partial: "follows/followers_count",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "followers_list_#{@user.id}",
              partial: "follows/followers_list",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "following_count_#{@user.id}",
              partial: "follows/following_count",
              locals: { user: @user }
            ),
            turbo_stream.replace(
              "following_list_#{@user.id}",
              partial: "follows/following_list",
              locals: { user: @user }
            )
          ] 
        end
        format.html { redirect_back(fallback_location: root_path, notice: "Deixaste de seguir #{@user.email}") }
      end
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.html { redirect_back(fallback_location: root_path, alert: "Erro ao deixar de seguir") }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end