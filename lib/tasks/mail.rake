task :mail2 => :environment do
    
  ch=Challenge.where(:state => ["incomplete","first","second","third","forth","fifth","sixth","seventh","eighth"])
  
  ch.each do |challenge|
    if challenge.active?
      user=challenge.speaking
      puts user.email
      puts challenge.title
      ChallengeMailer.new_argument(user, challenge).deliver
    end
  end
end