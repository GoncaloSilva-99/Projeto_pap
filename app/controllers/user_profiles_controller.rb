class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: %i[ show edit update destroy ]

  # GET /user_profiles or /user_profiles.json
  def index
    @user_profiles = UserProfile.all
  end

  # GET /user_profiles/1 or /user_profiles/1.json
  def show
      @page = params[:page]&.to_i || 1
      posts_per_page = 25
      
      @posts = Post.where(user_id: @user_profile.user.id).recent.offset((@page - 1) * posts_per_page)

      @has_more_posts = @posts.length == posts_per_page

      @post_comments = PostComment.where(post_id: @post)
      @num_post_comments = @post_comments.count
  end

  # GET /user_profiles/new
  def new
    @user_profile = UserProfile.new
  end

  # GET /user_profiles/1/edit
  def edit
    @user_profile.build_user if @user_profile.user.nil?
  end

  # POST /user_profiles or /user_profiles.json
  def create
    @user_profile = UserProfile.new(user_profile_params)

    respond_to do |format|
      if @user_profile.save
        format.html { redirect_to @user_profile, notice: "Perfil de adepto criado com sucesso!" }
        format.json { render :show, status: :created, location: @user_profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_profiles/1 or /user_profiles/1.json
  def update
    # Handle image removal
    @user_profile.profile_picture.purge if params[:user_profile][:remove_profile_picture] == '1'
    @user_profile.banner_picture.purge if params[:user_profile][:remove_banner] == '1'

    profile_params = user_profile_params.dup
    user_attrs = profile_params.delete(:user_attributes)

    user_update_success = true
    account_details_changed = false

    if user_attrs.present? && @user_profile.user.present?
      user_attrs = user_attrs.to_h
      user_attrs = user_attrs.reject do |k, v|
        v.blank? && !%w[email_confirmation password_confirmation].include?(k.to_s)
      end

      if user_attrs.present?
        user = @user_profile.user
        account_details_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        account_details_changed ||= user_attrs[:password].present?

        email_being_changed = user_attrs[:email].present? && user_attrs[:email] != user.email
        password_being_changed = user_attrs[:password].present?

        if (email_being_changed || password_being_changed) && user_attrs[:current_password].blank?
          @user_profile.errors.add(:base, "É necessário introduzir a palavra-passe atual para alterar email ou palavra-passe.")
          user_update_success = false
        elsif user_attrs[:current_password].present?
          user_update_success = user.update_with_password(user_attrs)
        else
          user_update_success = user.update_without_password(user_attrs.except(:current_password))
        end

        if user.errors.any?
          user.errors.full_messages.each { |msg| @user_profile.errors.add(:base, msg) }
        end
      end
    end

    respond_to do |format|
      if @user_profile.update(profile_params) && user_update_success
        if account_details_changed
          sign_out(current_user) if current_user
          format.html { redirect_to new_user_session_path, notice: "Dados de login alterados. Por favor, entre novamente.", status: :see_other }
        else
          format.html { redirect_to @user_profile, notice: "Perfil atualizado com sucesso!", status: :see_other }
        end
        format.json { render :show, status: :ok, location: @user_profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_profiles/1 or /user_profiles/1.json
  def destroy
    @user_profile.destroy!

    respond_to do |format|
      format.html { redirect_to user_profiles_path, notice: "Perfil de adepto apagado com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_profile_params
      permitted_params = [:user_id, :name, :status, :approved_by, :bio, :banner, :profile_picture, :foundation_date]

      if action_name == 'update'
        permitted_params << { user_attributes: [:email, :email_confirmation, :current_password, :password, :password_confirmation] }
      end

      params.require(:user_profile).permit(*permitted_params)
    end
end