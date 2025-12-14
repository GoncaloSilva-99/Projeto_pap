class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({}) # cria uma instância do modelo user e guarda na variavel resource
    case params[:role]
      when "Player"
        resource.build_player_profile
        render "devise/registrations/new_player_profile" and return
      when "Club"
        resource.build_club_profile
        render "devise/registrations/new_club_profile" and return
      when "User"
        resource.build_user_profile
        render "devise/registrations/new_user_profile" and return
      when "Board"
        resource.build_board_profile
        render "devise/registrations/new_board_profile" and return
      when "Coach"
        resource.build_coach_profile
        render "devise/registrations/new_coach_profile" and return
    end
    respond_with resource # responde ao pedido http com o objeto resource para que campos possam ser preenchidos automaticamente
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    if resource.save
      set_flash_message! :notice, :signed_up
      if (user_signed_in? and current_user.club?) or (user_signed_in? and current_user.board?)
         respond_with resource, location: club_teams_dashboard_path
      end
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
        if resource.role == "Player"
          resource.build_player_profile
          render "devise/registrations/new_player_profile" and return
        elsif resource.role =="Club"
          resource.build_club_profile
          render "devise/registrations/new_club_profile" and return
        elsif resource.role =="User"
          resource.build_user_profile
          render "devise/registrations/new_user_profile" and return
        elsif resource.role == "Board"
          resource.build_board_profile
          render "devise/registrations/new_board_profile" and return
        elsif resource.role =="Coach"
          resource.build_coach_profile
          render "devise/registrations/new_coach_profile" and return
        end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def permitted_attributes
    [
      :email, :password, :password_confirmation, :current_password, :remember_me, :role,
      { user_profile_attributes: [:name, :bio] },
      { player_profile_attributes: [:name, :birth_date, :position, :bio, :contact, :parents_contact, :sport, :dominant_foot_or_hand, :secondary_position] },
      { coach_profile_attributes: [:name, :birth_date, :coach_type] },
      { club_profile_attributes: [:name] },
      { club_profile_attributes: [:name, :foundation_date, :bio, :contact, :verification_document, :profile_picture, :banner_picture] },
      { board_profile_attributes: [:name, :bio, :birth_date, :role] }
    ]
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: permitted_attributes)
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up){|user| user.permit(permitted_attributes)}
  end

  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end