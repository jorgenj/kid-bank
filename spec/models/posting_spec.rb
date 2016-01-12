require 'rails_helper'

RSpec.describe Posting, type: :model do
  describe 'update_account_balance after save' do
    let(:account) {
      create(:account).tap do |acct|
        create(:posting, account: acct, amount: 10_00)
      end
    }

    it 'should update the account balance' do
      expect(Account.find(account.id)).to eq(account)

      p = nil
      expect {
        p = create(:posting, account: account, amount: 2_00)
      }.to change { 
        Account.find(account.id).balance 
      }.from(10_00).to(12_00)

      Account.where(id: account.id).update_all(balance: 99_00)
      account.reload
      expect(account.balance).to eq(99_00)

      expect {
        p.save!
      }.to change {
        Account.find(account.id).balance 
      }.from(99_00).to(12_00)
    end
  end

  describe 'capture_balances before validate' do
    let(:account) {
      acct = create(:account)
      create(:posting, account: acct, amount: 10_00)
      acct
    }

    it 'should not run if record already persisted' do
      p = create(:posting, account: account, amount: 2_00)
      expect(p.start_balance).to eq(10_00)
      expect(p.end_balance).to   eq(12_00)

      p.save!
      expect(p.start_balance).to eq(10_00)
      expect(p.end_balance).to   eq(12_00)
    end

    it 'should add amount for deposit' do
      p = create(:posting, account: account, amount: 2_00)
      expect(p.start_balance).to eq(10_00)
      expect(p.end_balance).to   eq(12_00)
    end

    it 'should subtract amount for withdrawal' do
      p = create(:posting, account: account, amount: -2_00)
      expect(p.start_balance).to eq(10_00)
      expect(p.end_balance).to   eq( 8_00)
    end
  end
end
