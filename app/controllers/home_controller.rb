class HomeController < ApplicationController
  def index
    if user_signed_in?
      @page = params[:page]&.to_i || 1
      posts_per_page = 25
      
      if current_user.following.any?
        @posts = current_user.feed_posts(page: @page, per_page: 25)
      else
        @posts = Post.recent.limit(25).offset((@page - 1) * 25)
      end

      @has_more_posts = @posts.length == posts_per_page
      
      @posts.each { |post| post.mark_as_viewed_by(current_user) } if @posts.present?
      @suggested_users = current_user.suggested_users_to_follow(limit: 6)
      @suggested_users_modal = current_user.suggested_users_to_follow(limit: 12)

      @post_comments = PostComment.where(post_id: @post)
      @num_post_comments = @post_comments.count
    end
  end

  def search
    @query = params[:query].to_s.strip
    @selected_category = params[:category].presence_in(%w[perfis publicacoes]) || 'perfis'

    if @query.present?
      @profile_results = []
      @profile_results += CoachProfile.search_by_name(@query) if defined?(CoachProfile)
      @profile_results += PlayerProfile.search_by_name(@query) if defined?(PlayerProfile)
      @profile_results += BoardProfile.search_by_name(@query) if defined?(BoardProfile)
      @profile_results += ClubProfile.search_by_name(@query) if defined?(ClubProfile)
      @profile_results = @profile_results.uniq

      @post_results = Post.where("caption ILIKE :q OR text ILIKE :q", q: "%#{@query}%")
    else
      @profile_results = []
      @post_results = []
    end
  end
end
