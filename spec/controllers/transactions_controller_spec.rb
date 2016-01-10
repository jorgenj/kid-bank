require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TransactionsController, type: :controller do
  let!(:cash_account) {
    create(:account, name: 'CASH')
  }

  let(:user_account) {
    create(:account)
  }

  # This should return the minimal set of attributes required to create a valid
  # Transaction. As you add validations to Transaction, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { transaction_type: 'DEPOSIT', 
      account_id: user_account.id,
      amount: 10_000,
      note: 'My first deposit',
    }
  }

  let(:invalid_attributes) {
    { transaction_type: 'foo', 
      account_id: nil,
      amount: nil,
      note: '',
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TransactionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all transactions as @transactions" do
      transaction = Transaction.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:transactions)).to eq([transaction])
    end
  end

  describe "GET #show" do
    it "assigns the requested transaction as @transaction" do
      transaction = Transaction.create! valid_attributes
      get :show, {:id => transaction.to_param}, valid_session
      expect(assigns(:transaction)).to eq(transaction)
    end
  end

  describe "GET #new" do
    it "assigns a new transaction as @transaction" do
      get :new, {}, valid_session
      expect(assigns(:transaction)).to be_a_new(Transaction)
    end
  end

  describe "GET #edit" do
    it "assigns the requested transaction as @transaction" do
      transaction = Transaction.create! valid_attributes
      get :edit, {:id => transaction.to_param}, valid_session
      expect(assigns(:transaction)).to eq(transaction)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Transaction" do
        expect {
          post :create, {:transaction => valid_attributes}, valid_session
        }.to change(Transaction, :count).by(1)
      end

      it "assigns a newly created transaction as @transaction" do
        post :create, {:transaction => valid_attributes}, valid_session
        puts assigns(:transaction).errors.inspect
        expect(assigns(:transaction)).to be_a(Transaction)
        expect(assigns(:transaction)).to be_persisted

        txn = assigns(:transaction)
        expect(txn.journal).to be_a(Journal)
        expect(txn.journal).to be_persisted

        expect(txn.journal.postings).to_not be_empty
        expect(txn.journal.postings.count).to eq(2)
        expect(txn.journal.postings.sum(:amount)).to eq(0)

        expect(txn.journal.postings[0].account).to eq(cash_account)
        expect(txn.journal.postings[0].amount).to eq(-10_000)

        expect(txn.journal.postings[1].account).to eq(user_account)
        expect(txn.journal.postings[1].amount).to eq(10_000)
      end

      it "redirects to the created transaction" do
        post :create, {:transaction => valid_attributes}, valid_session
        expect(response).to redirect_to(Transaction.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved transaction as @transaction" do
        post :create, {:transaction => invalid_attributes}, valid_session
        expect(assigns(:transaction)).to be_a_new(Transaction)
      end

      it "re-renders the 'new' template" do
        post :create, {:transaction => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => new_attributes}, valid_session
        transaction.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested transaction as @transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => valid_attributes}, valid_session
        expect(assigns(:transaction)).to eq(transaction)
      end

      it "redirects to the transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => valid_attributes}, valid_session
        expect(response).to redirect_to(transaction)
      end
    end

    context "with invalid params" do
      it "assigns the transaction as @transaction" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => invalid_attributes}, valid_session
        expect(assigns(:transaction)).to eq(transaction)
      end

      it "re-renders the 'edit' template" do
        transaction = Transaction.create! valid_attributes
        put :update, {:id => transaction.to_param, :transaction => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested transaction" do
      transaction = Transaction.create! valid_attributes
      expect {
        delete :destroy, {:id => transaction.to_param}, valid_session
      }.to change(Transaction, :count).by(-1)
    end

    it "redirects to the transactions list" do
      transaction = Transaction.create! valid_attributes
      delete :destroy, {:id => transaction.to_param}, valid_session
      expect(response).to redirect_to(transactions_url)
    end
  end

end
