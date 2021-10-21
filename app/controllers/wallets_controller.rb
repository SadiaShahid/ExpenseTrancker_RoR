class WalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wallet, only: %i[ show edit update destroy ]

  # GET /wallets or /wallets.json
  def index
    # @wallets = Wallet.all
    #@wallet = Wallet.find_by_id(params[:id])
    @wallet = current_user.wallet
    authorize @wallet
  end

  # GET /wallets/1 or /wallets/1.json
  def show
    @wallet = Wallet.find_by_id(params[:id])
    authorize @wallet
  end

  # GET /wallets/new
  def new
    @wallet = Wallet.new
    authorize @wallet
  end

  # GET /wallets/1/edit
  def edit
   
    authorize @wallet
  end

  # POST /wallets or /wallets.json
  def create
    @wallet = Wallet.new(wallet_params)
    @wallet.user_id = current_user.id
    respond_to do |format|
      if @wallet.save
        format.html { redirect_to root_path, notice: "Wallet was successfully created." }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallets/1 or /wallets/1.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to root_path, notice: "Wallet was successfully updated." }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/1 or /wallets/1.json
  def destroy
    authorize @wallet
    # @wallet.destroy
    # respond_to do |format|
    #   format.html { redirect_to wallets_url, notice: "Wallet was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:credit, :user_id)
    end
end
