class PlayerProfilesController < ApplicationController
  before_action :set_player_profile, only: %i[ show edit update destroy ]

  def remove_from_club
    @sport = params[:sport]
    @player_profile = PlayerProfile.find(params[:id])
    @player_profile.update(club_profile_id: nil)
    respond_to do |format|
      format.html { redirect_to club_teams_dashboard_path(sport: @sport), notice: "Jogador removido do clube com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # GET /player_profiles or /player_profiles.json
  def index
    @player_profiles = PlayerProfile.all
  end

  # GET /player_profiles/1 or /player_profiles/1.json
  def show
    @page = params[:page]&.to_i || 1
    posts_per_page = 25
    
    @posts = Post.where(user_id: @player_profile.user.id).recent.offset((@page - 1) * posts_per_page)

    @has_more_posts = @posts.length == posts_per_page

    @post_comments = PostComment.where(post_id: @post)
    @num_post_comments = @post_comments.count
  end

  # GET /player_profiles/new
  def new
    @player_profile = PlayerProfile.new
  end

  # GET /player_profiles/1/edit
  def edit
    @player_profile.build_user if @player_profile.user.nil?
  end

  # POST /player_profiles or /player_profiles.json
  def create
    @player_profile = PlayerProfile.new(player_profile_params)

    respond_to do |format|
      if @player_profile.save
        format.html { redirect_to @player_profile, notice: "Perfil de jogador criado com sucesso!" }
        format.json { render :show, status: :created, location: @player_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_profiles/1 or /player_profiles/1.json
  def update
    # Handle image removal
    @player_profile.profile_picture.purge if params[:player_profile][:remove_profile_picture] == '1'
    @player_profile.banner_picture.purge if params[:player_profile][:remove_banner_picture] == '1'

    profile_params = player_profile_params.dup
    user_attrs = profile_params.delete(:user_attributes)

    user_update_success = true
    account_details_changed = false

    if user_attrs.present? && @player_profile.user.present?
      user_attrs = user_attrs.to_h
      user_attrs = user_attrs.reject do |k, v|
        v.blank? && !%w[email_confirmation password_confirmation].include?(k.to_s)
      end

      if user_attrs.present?
        user = @player_profile.user
        account_details_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        account_details_changed ||= user_attrs[:password].present?

        email_being_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        password_being_changed = user_attrs[:password].present?

        if (email_being_changed || password_being_changed) && user_attrs[:current_password].blank?
          @player_profile.errors.add(:base, "É necessário introduzir a palavra-passe atual para alterar email ou palavra-passe.")
          user_update_success = false
        elsif user_attrs[:current_password].present?
          user_update_success = user.update_with_password(user_attrs)
        else
          user_update_success = user.update_without_password(user_attrs.except(:current_password))
        end

        if user.errors.any?
          user.errors.full_messages.each { |msg| @player_profile.errors.add(:base, msg) }
        end
      end
    end

    respond_to do |format|
      if @player_profile.update(profile_params) && user_update_success
        if account_details_changed
          sign_out(current_user) if current_user
          format.html { redirect_to new_user_session_path, notice: "Dados de login alterados. Por favor, entre novamente.", status: :see_other }
        else
          format.html { redirect_to @player_profile, notice: "Perfil editado com sucesso!", status: :see_other }
        end
        format.json { render :show, status: :ok, location: @player_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_profiles/1 or /player_profiles/1.json
  def destroy
    @player_profile.destroy!

    respond_to do |format|
      format.html { redirect_to player_profiles_path, notice: "Perfil de jogador apagado com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_profile
      @player_profile = PlayerProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_profile_params
      permitted_params = [:user_id, :name, :status, :approved_by, :bio, :banner_picture, :profile_picture, :foundation_date]

      if action_name == 'update'
        permitted_params << { user_attributes: [:email, :email_confirmation, :current_password, :password, :password_confirmation] }
      end

      params.require(:player_profile).permit(*permitted_params)
    end
end