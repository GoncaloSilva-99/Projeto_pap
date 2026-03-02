class PostSavesController < ApplicationController
  before_action :set_post_safe, only: %i[ show edit update destroy ]

  # GET /post_saves or /post_saves.json
  def index
    @post_saves = PostSafe.all
  end

  # GET /post_saves/1 or /post_saves/1.json
  def show
  end

  # GET /post_saves/new
  def new
    @post_safe = PostSafe.new
  end

  # GET /post_saves/1/edit
  def edit
  end

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

  # POST /post_saves or /post_saves.json
  def create
    @post_safe = PostSafe.new(post_safe_params)

      if @post_safe.save
        format.html { redirect_to @post_safe, notice: "Post safe was successfully created." }
        format.json { render :show, status: :created, location: @post_safe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_safe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_saves/1 or /post_saves/1.json
  def update
    respond_to do |format|
      if @post_safe.update(post_safe_params)
        format.html { redirect_to @post_safe, notice: "Post safe was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post_safe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post_safe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_saves/1 or /post_saves/1.json
  def destroy
    @post_safe.destroy!

    respond_to do |format|
      format.html { redirect_to post_saves_path, notice: "Post safe was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_safe
      @post_safe = PostSafe.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_safe_params
      params.expect(post_safe: [ :user_id, :post_id ])
    end
end
