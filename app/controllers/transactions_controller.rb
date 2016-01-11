class TransactionsController < ApplicationController
  before_action :set_account
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /accounts/:account_id/transactions
  # GET /accounts/:account_id/transactions.json
  def index
    @transactions = @account.transactions.all
  end

  # GET /accounts/:account_id/transactions/1
  # GET /accounts/:account_id/transactions/1.json
  def show
  end

  # GET /accounts/:account_id/transactions/new
  def new
    @transaction = @account.transactions.new(transaction_params)
  end

  # GET /accounts/:account_id/transactions/1/edit
  #def edit
  #end

  # POST /accounts/:account_id/transactions
  # POST /accounts/:account_id/transactions.json
  def create
    @transaction = @account.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @account, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/:account_id/transactions/1
  # PATCH/PUT /accounts/:account_id/transactions/1.json
  #def update
  #  respond_to do |format|
  #    if @transaction.update(transaction_params)
  #      format.html { redirect_to @account, notice: 'Transaction was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @account }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @transaction.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /accounts/:account_id/transactions/1
  # DELETE /accounts/:account_id/transactions/1.json
  #def destroy
  #  @transaction.destroy
  #  respond_to do |format|
  #    format.html { redirect_to @account, notice: 'Transaction was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    def set_account
      @account = current_user.accounts.find(params[:account_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = @account.transactions.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      if params.key?(:transaction)
        params.require(:transaction).permit(:transaction_type, :amount, :note)
      else
        {}
      end
    end
end
