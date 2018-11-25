require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  let(:account) {
    create(:account)
  }

  let(:valid_transaction) {
    account.transactions.new()
  }

  let(:invalid_transaction) {
    txn = account.transactions.new(transaction_type: 'foo',
                              account_id: nil,
                              amount: nil,
                              note: '')
    txn.save
    txn
  }

  it "renders new transaction form" do
    @account = assign(:account, account)
    @transaction = assign(:transaction, valid_transaction)

    render

    assert_select "form[action=?][method=?]", account_transactions_path(@account), "post" do
    end
  end

  context "with invalid @tranaction" do
    it "renders error messages" do
      @account = assign(:account, account)
      @transaction = assign(:transaction, invalid_transaction)

      render

      expect(rendered).to match /Note is too short/
    end
  end
end
