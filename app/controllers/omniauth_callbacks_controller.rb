class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  
  def facebook
    if current_user.nil?
      
      data = request.env["omniauth.auth"].extra.raw_info
      
      unless @user = User.find_by_email(data.email)
 
        @user = User.new( :email => data.email, :password => Devise.friendly_token[0,20],
                          :gender => data.gender,
                          :avatar => open("http://graph.facebook.com/#{data.id}/picture?type=large"))
        @user.headline = data.bio if data.bio && data.bio.length < 100
        @user.save!
        @user.password_empty = true
        @user.save!
        @user
      end

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      km_record("Synchronized Facebook")
      save_service_user_id(:facebook)
    end
  end
end