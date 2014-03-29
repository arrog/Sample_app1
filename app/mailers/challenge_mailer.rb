class ChallengeMailer < ActionMailer::Base
  default from: "paul@moutoners.fr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  #
  def new_argument(user,challenge)
    @challenge = challenge
    @user = user
    attachments.inline['mail-challenge4-01.png'] = File.read("#{Rails.root}/app/assets/images/mail-challenge4-01.png")
    mail to: user.email, subject: "Ton tour!"
  end
end
