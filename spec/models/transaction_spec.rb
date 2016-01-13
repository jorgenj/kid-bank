require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:cash_account) { create(:cash_account) }

  describe 'deposit?' do
    it 'should work' do
      expect(Transaction.new(transaction_type: 'DEPOSIT')).to be_deposit
      expect(Transaction.new(transaction_type: 'WITHDRAWAL')).to_not be_deposit
      expect(Transaction.new(transaction_type: 'INVALID')).to_not be_deposit
      expect(Transaction.new(transaction_type: nil)).to_not be_deposit
    end
  end

  describe 'withdrawal?' do
    it 'should work' do
      expect(Transaction.new(transaction_type: 'WITHDRAWAL')).to be_withdrawal
      expect(Transaction.new(transaction_type: 'DEPOSIT')).to_not be_withdrawal
      expect(Transaction.new(transaction_type: 'INVALID')).to_not be_withdrawal
      expect(Transaction.new(transaction_type: nil)).to_not be_withdrawal
    end
  end
end
