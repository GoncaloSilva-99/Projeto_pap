class PostLikesController < ApplicationController
  before_action :set_post_like, only: %i[ show edit update destroy ]

  # GET /post_likes or /post_likes.json
  def index
    @post_likes = PostLike.all
  end

  # GET /post_likes/1 or /post_likes/1.json
  def show
  end

  # GET /post_likes/new
  def new
    @post_like = PostLike.new
  end


  # POST /post_likes or /post_likes.json
  def create
    @like = @post.likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
          "like_section_#{@post.id}",
          partial: "posts/like_section",
          locals: { post: @post }
        )
        end
        format.html { redirect_to posts_path }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
          "like_section_#{@post.id}",
          partial: "posts/like_section",
          locals: { post: @post, error: "Já deste like!" }
        )
        end
        format.html { redirect_to posts_path }
      end
    end
  end


  # DELETE /post_likes/1 or /post_likes/1.json
  def destroy
    @like = @post.post_likes.find_by(user: current_user)
    @like&.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
        "like_section_#{@post.id}",
        partial: "posts/like_section",
        locals: { post: @post })
      end
      format.html { redirect_to posts_path }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_like
      @post_like = PostLike.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_like_params
      params.expect(post_like: [ :user_id, :post_id ])
    end
end
