class UserMailer < ApplicationMailer
  def reconfirmation_email(user, token)
    @user = user
    @token = token
    mail(
      to: user.unconfirmed_email,
      subject: "Confirma o teu novo email"
    )
  end
end
