module RequestMacros
  def login_user(user = FactoryGirl.create(:user))
    post_via_redirect '/users/sign_in', user: {email: user.email, password: 's3cr3tp4ssw0rd'} 
  end

  def login_admin
    login_user(FactoryGirl.create(:admin))
  end
end

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      sign_in :user, admin #sign_in(scope, resource)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller

  config.include RequestMacros, :type => :request
end
