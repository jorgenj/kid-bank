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

  describe 'capture_balances before validate' do
    let(:account) {
      acct = create(:account)
      create(:deposit,    account: acct, amount: 10_00)
      create(:withdrawal, account: acct, amount:  3_00)
      acct
    }

    it 'should not run if record already persisted' do
      txn = create(:deposit, account: account, amount: 2_00)
      expect(txn.start_balance).to eq(7_00)
      expect(txn.end_balance).to eq(9_00)

      txn.note = 'updated note'
      txn.save!
      expect(txn.start_balance).to eq(7_00)
      expect(txn.end_balance).to eq(9_00)
    end

    it 'should add amount for deposit' do
      txn = create(:deposit, account: account, amount: 2_00)
      expect(txn.start_balance).to eq(7_00)
      expect(txn.end_balance).to eq(9_00)
    end

    it 'should subtract amount for withdrawal' do
      txn = create(:withdrawal, account: account, amount: 2_00)
      expect(txn.start_balance).to eq(7_00)
      expect(txn.end_balance).to eq(5_00)
    end
  end
end
