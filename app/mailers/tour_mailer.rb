class TourMailer < ActionMailer::Base
  default from: "paul@moutoners.fr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tour_mailer.votre_tour.subject
  #
  def votre_tour(name, mail, challenge)
    @challenge = challenge
    attachments.inline['mail-challenge4-01.png'] = File.read("#{Rails.root}/app/assets/images/mail-challenge4-01.png")
    mail to: mail, subject: "C'est à vous de débattre!"   
  end
  
end
