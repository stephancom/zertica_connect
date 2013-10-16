class MessageNotifications < ActionMailer::Base
  default from: "no-reply@zertica.com"

  # subject lines are set in the i18n file, en.yml

  def new_message(message)
    @message = message

    mail to: @message.user.email
  end
end
