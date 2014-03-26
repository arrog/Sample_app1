class UserMailer < ActionMailer::Base
  default from: "paul@moutoners.fr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user,debate,debate1,challenge)
    @debate = debate
    @debate1 = debate1
    @challenge = challenge
    @user = user
    attachments.inline['mail-challenge1-04.png'] = File.read("#{Rails.root}/app/assets/images/mail-challenge1-04.png")
    attachments.inline['mail-challenge2-05.png'] = File.read("#{Rails.root}/app/assets/images/mail-challenge2-05.png")
    attachments.inline['mail-challenge3-06.png'] = File.read("#{Rails.root}/app/assets/images/mail-challenge3-06.png")
    mail to: user.email, subject: "Bienvenue sur Moutoners"
  end
end