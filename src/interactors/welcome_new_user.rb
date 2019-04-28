class WelcomeNewUser
  include Interactor

  def call
    if context.user.send_welcome_email
      context.welcome_email_sent = true
    else
      context.welcome_email_sent = false
      context.fail!(message: "welcome email failed")
    end
  end
end
