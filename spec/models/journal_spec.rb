require 'rails_helper'

RSpec.describe Journal, type: :model do
  describe 'deposit!' do
    let(:acct) {
      create(:account)
    }

    it 'creates two entries on the ledger' do
      expect {
        expect {
          Journal.deposit!(acct, 10_000)
        }.to change { Journal.count }.by(1)
      }.to change { Posting.count }.by(2)

      j = Journal.last
      expect(j.postings.sum(:amount)).to eq(0)

      expect(j.postings[0].account).to eq(Account.cash_account)
      expect(j.postings[0].amount).to eq(-10_000)

      expect(j.postings[1].account).to eq(acct)
      expect(j.postings[1].amount).to eq(10_000)
    end

    it 'disallows depositing negative amount' do
      expect { Journal.deposit!(acct, -1) }.to raise_error('Amount must be greater than 0')
    end

    it 'disallows zero amount' do
      expect { Journal.deposit!(acct, 0) }.to raise_error('Amount must be greater than 0')
    end

    it 'requires non-null account' do
      expect { Journal.deposit!(nil, 1) }.to raise_error('Account must not be nil')
    end

    it 'requires non-null amount' do
      expect { Journal.deposit!(acct, nil) }.to raise_error('Amount must not be nil')
    end
  end

  describe 'withdraw!' do
    let(:acct) {
      create(:account)
    }

    it 'creates two entries on the ledger' do
      expect {
        expect {
          Journal.withdraw!(acct, 10_000)
        }.to change { Journal.count }.by(1)
      }.to change { Posting.count }.by(2)

      j = Journal.last
      expect(j.postings.sum(:amount)).to eq(0)

      expect(j.postings[0].account).to eq(acct)
      expect(j.postings[0].amount).to eq(-10_000)

      expect(j.postings[1].account).to eq(Account.cash_account)
      expect(j.postings[1].amount).to eq(10_000)
    end

    it 'disallows depositing negative amount' do
      expect { Journal.withdraw!(acct, -1) }.to raise_error('Amount must be greater than 0')
    end

    it 'disallows zero amount' do
      expect { Journal.withdraw!(acct, 0) }.to raise_error('Amount must be greater than 0')
    end

    it 'requires non-null account' do
      expect { Journal.withdraw!(nil, 1) }.to raise_error('Account must not be nil')
    end

    it 'requires non-null amount' do
      expect { Journal.withdraw!(acct, nil) }.to raise_error('Amount must not be nil')
    end
  end
end
