class PostingsController < ApplicationController
  before_action :set_journal
  before_action :set_posting, only: [:show, :edit, :update, :destroy]

  # GET /journals/:journal_id/postings
  # GET /journals/:journal_id/postings.json
  def index
    @postings = @journal.postings.all
  end

  # GET /journals/:journal_id/postings/1
  # GET /journals/:journal_id/postings/1.json
  def show
  end

  # GET /journals/:journal_id/postings/new
  def new
    @posting = @journal.postings.new
  end

  # GET /journals/:journal_id/postings/1/edit
  #def edit
  #end

  # POST /journals/:journal_id/postings
  # POST /journals/:journal_id/postings.json
  def create
    @posting = @journal.postings.new(posting_params)

    respond_to do |format|
      if @posting.save
        format.html { redirect_to @journal, notice: 'Posting was successfully created.' }
        format.json { render :show, status: :created, location: @journal }
      else
        format.html { render :new }
        format.json { render json: @posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /journals/:journal_id/postings/1
  # PATCH/PUT /journals/:journal_id/postings/1.json
  #def update
  #  respond_to do |format|
  #    if @posting.update(posting_params)
  #      format.html { redirect_to @journal, notice: 'Posting was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @journal }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @posting.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /journals/:journal_id/postings/1
  # DELETE /journals/:journal_id/postings/1.json
  #def destroy
  #  @posting.destroy
  #  respond_to do |format|
  #    format.html { redirect_to postings_url, notice: 'Posting was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private
    def set_journal
      @journal = Journal.find(params[:journal_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_posting
      @posting = @journal.postings.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def posting_params
      params.require(:posting).permit(:account_id, :amount)
    end
end
