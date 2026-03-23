class BoardProfilesController < ApplicationController
  before_action :set_board_profile, only: %i[ show edit update destroy ]

  # GET /board_profiles or /board_profiles.json
  def index
    @board_profiles = BoardProfile.all
  end

  # GET /board_profiles/1 or /board_profiles/1.json
  def show
      @page = params[:page]&.to_i || 1
      posts_per_page = 25
      
      @posts = Post.where(user_id: @board_profile.user.id).recent.offset((@page - 1) * posts_per_page)

      @has_more_posts = @posts.length == posts_per_page

      @post_comments = PostComment.where(post_id: @post)
      @num_post_comments = @post_comments.count
  end

  # GET /board_profiles/new
  def new
    @board_profile = BoardProfile.new
  end

  # GET /board_profiles/1/edit
  def edit
    @board_profile.build_user if @board_profile.user.nil?
  end

  # POST /board_profiles or /board_profiles.json
  def create
    @board_profile = BoardProfile.new(board_profile_params)

    respond_to do |format|
      if @board_profile.save
        format.html { redirect_to club_board_dashboard_path, notice: "Conta de direção criada com sucesso!" }
        format.json { render :show, status: :created, location: @board_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /board_profiles/1 or /board_profiles/1.json
  def update
    # Handle image removal
    @board_profile.profile_picture.purge if params[:board_profile][:remove_profile_picture] == '1'
    @board_profile.banner_picture.purge if params[:board_profile][:remove_banner_picture] == '1'

    profile_params = board_profile_params.dup
    user_attrs = profile_params.delete(:user_attributes)

    user_update_success = true
    account_details_changed = false

    if user_attrs.present? && @board_profile.user.present?
      user_attrs = user_attrs.to_h
      user_attrs = user_attrs.reject do |k, v|
        v.blank? && !%w[email_confirmation password_confirmation].include?(k.to_s)
      end

      if user_attrs.present?
        user = @board_profile.user
        account_details_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        account_details_changed ||= user_attrs[:password].present?

        email_being_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        password_being_changed = user_attrs[:password].present?

        if (email_being_changed || password_being_changed) && user_attrs[:current_password].blank?
          @board_profile.errors.add(:base, "É necessário introduzir a palavra-passe atual para alterar email ou palavra-passe.")
          user_update_success = false
        elsif user_attrs[:current_password].present?
          user_update_success = user.update_with_password(user_attrs)
        else
          user_update_success = user.update_without_password(user_attrs.except(:current_password))
        end

        if user.errors.any?
          user.errors.full_messages.each { |msg| @board_profile.errors.add(:base, msg) }
        end
      end
    end

    respond_to do |format|
      if @board_profile.update(profile_params) && user_update_success
        if account_details_changed
          sign_out(current_user) if current_user
          format.html { redirect_to new_user_session_path, notice: "Dados de login alterados. Por favor, entre novamente.", status: :see_other }
        else
          format.html { redirect_to @board_profile, notice: "Perfil atualizado com sucesso!", status: :see_other }
        end
        format.json { render :show, status: :ok, location: @board_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /board_profiles/1 or /board_profiles/1.json
  def destroy
    @board_profile.destroy!
    respond_to do |format|
      format.html { redirect_to club_board_dashboard_path, notice: "Membro da direção apagado com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board_profile
      @board_profile = BoardProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_profile_params
      permitted_params = [:user_id, :name, :status, :approved_by, :bio, :banner_picture, :profile_picture, :foundation_date]

      if action_name == 'update'
        permitted_params << { user_attributes: [:email, :email_confirmation, :current_password, :password, :password_confirmation] }
      end

      params.require(:board_profile).permit(*permitted_params)
    end
end