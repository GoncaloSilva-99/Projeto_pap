class HomeController < ApplicationController
  def index
    if user_signed_in?
      @page = params[:page]&.to_i || 1
      
      if current_user.following.any?
        @posts = current_user.feed_posts(page: @page, per_page: 25)
      else
        @posts = Post.recent.limit(25).offset((@page - 1) * 25)
      end
      
      @posts.each { |post| post.mark_as_viewed_by(current_user) } if @posts.present?
      @suggested_users = current_user.suggested_users_to_follow(limit: 6)
    end
  end
end
