RSpec.configure do |config|
  config.before do
    ## many specs require system accounts, system account requires at least one admin user
    create(:admin_user)
  end
end
