class PostLikesController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

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
    @like = @post.post_likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "like_section_#{@post.id}",
              partial: "posts/like_section",
              locals: { post: @post }
            ),
            turbo_stream.replace(
              "like_section_modal_#{@post.id}",
              partial: "posts/like_section_modal",
              locals: { post: @post }
            )
          ]
        end
        format.html { redirect_to posts_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to posts_path }
      end
    end
  end


  # DELETE /post_likes/1 or /post_likes/1.json
  def destroy
    @post.destroy

    flash.now[:notice] = "Post eliminado com sucesso!"

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove("post_#{@post.id}"),
          turbo_stream.replace("flash", partial: "shared/flash")
        ]
      end

      format.html { redirect_to root_path, notice: "Post eliminado com sucesso!" }
    end
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def post_like_params
      params.expect(post_like: [ :user_id, :post_id ])
    end
end
