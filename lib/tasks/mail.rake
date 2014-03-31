task :mail => :environment do
  
  num = 1
  numero = 2
  
  user = User.where(id: num).first
  challenge = Challenge.where(id: numero).first
  
  ChallengeMailer.new_argument(user, challenge).deliver

end