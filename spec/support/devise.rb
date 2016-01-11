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
    let(:current_user) {
      FactoryGirl.create(:admin)
    }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in :user, current_user #sign_in(scope, resource)
    end
  end

  def login_user
    let(:current_user) {
      FactoryGirl.create(:user)
    }
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      #current_user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in current_user
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller

  config.include RequestMacros, :type => :request
end
