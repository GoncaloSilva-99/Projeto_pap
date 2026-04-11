class HomeController < ApplicationController
  def index
    if user_signed_in?
      @page = params[:page]&.to_i || 1
      
      @posts = current_user.home_feed(page: @page, per_page: 25)

      
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
      name_q = "%#{@query.downcase}%"

      clubs   = ClubProfile.joins(:user).where(users: { banned: [false, nil] }).where(status: 'verified').where("LOWER(name) LIKE ?", name_q).to_a
      boards  = BoardProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).to_a
      coaches = CoachProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).to_a
      players = PlayerProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).to_a
      users   = UserProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).to_a
      admins  = AdminProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).to_a

      @profile_results = (clubs + boards + coaches + players + users + admins).uniq

      author_user_ids = (
        ClubProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        PlayerProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        CoachProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        BoardProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        AdminProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).pluck(:user_id) +
        UserProfile.joins(:user).where(users: { banned: [false, nil] }).where("LOWER(name) LIKE ?", name_q).pluck(:user_id)
      ).uniq

      @author_posts = Post.includes(:user)
                          .where(user_id: author_user_ids)
                          .excluding_banned_users
                          .order(created_at: :desc)
                          .to_a

      @content_posts = Post.includes(:user)
                          .where.not(user_id: author_user_ids)
                          .excluding_banned_users
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