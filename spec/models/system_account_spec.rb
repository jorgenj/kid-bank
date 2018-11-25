require 'rails_helper'

RSpec.describe SystemAccount, type: :model do
  describe 'SystemAccount.cash' do
    it 'should be findable' do
      expect(Role.all).to_not be_empty

      expect(SystemAccount.cash!).to be_a(SystemAccount)
      expect(SystemAccount.cash!).to be_persisted
    end
  end

  describe 'SystemAccount.interest' do
    it 'should be findable' do
      expect(Role.all).to_not be_empty

      expect(SystemAccount.interest!).to be_a(SystemAccount)
      expect(SystemAccount.interest!).to be_persisted
    end
  end
end
