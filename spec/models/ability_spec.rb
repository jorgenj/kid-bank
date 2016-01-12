require 'rails_helper'
require "cancan/matchers"

RSpec.describe Account, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'admin role' do
    let(:user) { create(:admin_user) }

    it { should be_able_to(:manage, Account.new) }
    it { should be_able_to(:manage, Journal.new) }
    it { should be_able_to(:manage, Posting.new) }
    it { should be_able_to(:manage, Transaction.new) }
  end

  describe 'normal user' do
    let(:user)  { create(:user) }

    it { should_not be_able_to(:create, Account.new) }
    it { should be_able_to(:create, Account.new(user_id: user.id)) }
    it { should be_able_to(:manage, Account.new(user_id: user.id)) }

    it { should_not be_able_to(:edit, Account.new(user_id: user.id + 1)) }
    it { should_not be_able_to(:read, Account.new(user_id: user.id + 1)) }
    it { should_not be_able_to(:update, Account.new(user_id: user.id + 1)) }
    it { should_not be_able_to(:destroy, Account.new(user_id: user.id + 1)) }
  end
end
