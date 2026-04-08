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
      # --- Perfis ---
      clubs   = ClubProfile.where("LOWER(name) LIKE ?", "%#{@query.downcase}%")
                     .where(status: 'verified')
                     .to_a
      boards  = BoardProfile.where("LOWER(name) LIKE ?", "%#{@query.downcase}%").to_a
      coaches = CoachProfile.where("LOWER(name) LIKE ?", "%#{@query.downcase}%").to_a
      players = PlayerProfile.where("LOWER(name) LIKE ?", "%#{@query.downcase}%").to_a
      users   = UserProfile.where("LOWER(name) LIKE ?", "%#{@query.downcase}%").to_a
      admins  = AdminProfile.where("LOWER(name) LIKE ?", "%#{@query.downcase}%").to_a

      @profile_results = (clubs + boards + coaches + players + users + admins).uniq

      # --- Posts: IDs dos autores cujo nome contém a query ---
      name_q = "%#{@query.downcase}%"

      author_user_ids = (
        ClubProfile.where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        PlayerProfile.where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        CoachProfile.where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        BoardProfile.where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        AdminProfile.where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        UserProfile.where("LOWER(name) LIKE ?", name_q).pluck(:user_id)
      ).uniq

      # Grupo 1: posts de autores cujo nome bate com a query
      @author_posts = Post.includes(:user)
                          .where(user_id: author_user_ids)
                          .order(created_at: :desc)
                          .to_a

      # Grupo 2: posts cujo conteúdo bate com a query (excluindo os do grupo 1)
      @content_posts = Post.includes(:user)
                          .where.not(user_id: author_user_ids)
                          .where("LOWER(content) LIKE ?", "%#{@query.downcase}%")
                          .order(created_at: :desc)
                          .to_a
    else
      @profile_results = []
      @author_posts    = []
      @content_posts   = []
    end
  end
end
