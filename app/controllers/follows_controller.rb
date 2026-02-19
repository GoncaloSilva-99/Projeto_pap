class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_follow, only: %i[ show edit update destroy ]

  # GET /follows or /follows.json
  def index
    @follows = Follow.all
  end

  # GET /follows/1 or /follows/1.json
  def show
  end

  # GET /follows/new
  def new
    @follow = Follow.new
  end

  # GET /follows/1/edit
  def edit
  end

  # POST /follows or /follows.json
  def create
    current_user.follow(@user)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
        "follow_button_#{@user.id}",
        partial: "users/follow_button",
        locals: { user: @user }
        )
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end


  # DELETE /follows/1 or /follows/1.json
  def destroy
    current_user.unfollow(@user)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
        "follow_button_#{@user.id}",
        partial: "users/follow_button",
        locals: { user: @user })
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def follow_params
      params.expect(follow: [ :follower_id, :followed_id ])
    end
end
