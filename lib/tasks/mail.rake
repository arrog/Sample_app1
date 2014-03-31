task :mail => :environment do
  
  num = 1
  numero = 1
  
  user = User.where(id: num).first
  challenge = Challenge.where(id: numero).first
  
  ChallengeMailer.new_argument(user, challenge).deliver

end

task :mail2 => :environment do
    
  ch=Challenge.where(:state => ["incomplete","first","second","third","forth","fifth","sixth","seventh","eighth"])
  
  ch.each do |challenge|
    if challenge.active?
      user=challenge.speaking
      ChallengeMailer.new_argument(user, challenge).deliver
    end
  end
end