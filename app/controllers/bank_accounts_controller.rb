class BankAccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bank_account, only: %i[ show edit update destroy ]

  # GET /bank_accounts or /bank_accounts.json
  def index
    @bank_accounts = current_user.bank_accounts
    authorize @bank_accounts
  end

  # GET /bank_accounts/1 or /bank_accounts/1.json
  def show
    @bank_account = BankAccount.find(params[:id]) 
    authorize @bank_account
  end

  # GET /bank_accounts/new
  def new
    @bank_account = BankAccount.new
    authorize @bank_account
  end

  # GET /bank_accounts/1/edit
  def edit
    @bank_account = BankAccount.find(params[:id])
    # @bank_account.user? :current_user
    authorize @bank_account
  end

  # POST /bank_accounts or /bank_accounts.json
  def create
    
    @bank_account = BankAccount.new(bank_account_params)
    @bank_account.user_id = current_user.id
    respond_to do |format|
      if @bank_account.save
        format.html { redirect_to root_path, notice: "Bank account was successfully created." }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_accounts/1 or /bank_accounts/1.json
  def update
    @bank_account = BankAccount.find(params[:id]) 
    authorize @bank_account
    
    respond_to do |format|
      if @bank_account.update(bank_account_params)
        format.html { redirect_to root_path, notice: "Bank account was successfully updated." }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bank_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1 or /bank_accounts/1.json
  def destroy
    # @bank_account = BankAccount.find(params[:id]) 
    
    @bank_account.destroy
    authorize @bank_account
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Bank account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_account
      @bank_account = BankAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_account_params
      params.require(:bank_account).permit(:bank_name, :acc_no, :balance, :user_id)
    end
end
