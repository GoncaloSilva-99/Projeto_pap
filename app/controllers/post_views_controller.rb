class PostViewsController < ApplicationController
  before_action :set_post_view, only: %i[ show edit update destroy ]

  # GET /post_views or /post_views.json
  def index
    @post_views = PostView.all
  end

  # GET /post_views/1 or /post_views/1.json
  def show
  end

  # GET /post_views/new
  def new
    @post_view = PostView.new
  end

  # GET /post_views/1/edit
  def edit
  end

  # POST /post_views or /post_views.json
  def create
    @post_view = PostView.new(post_view_params)

    respond_to do |format|
      if @post_view.save
        format.html { redirect_to @post_view, notice: "Post view was successfully created." }
        format.json { render :show, status: :created, location: @post_view }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_view.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_views/1 or /post_views/1.json
  def update
    respond_to do |format|
      if @post_view.update(post_view_params)
        format.html { redirect_to @post_view, notice: "Post view was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post_view }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post_view.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_views/1 or /post_views/1.json
  def destroy
    @post_view.destroy!

    respond_to do |format|
      format.html { redirect_to post_views_path, notice: "Post view was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_view
      @post_view = PostView.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_view_params
      params.expect(post_view: [ :user_id, :post_id ])
    end
end
