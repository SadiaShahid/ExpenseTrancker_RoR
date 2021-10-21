class GroupPayersController < ApplicationController
  before_action :set_group_payer, only: %i[ show edit update destroy ]

  # GET /group_payers or /group_payers.json
  def index
    @group_payers = GroupPayer.all
  end

  # GET /group_payers/1 or /group_payers/1.json
  def show
  end

  # GET /group_payers/new
  def new
    @group_payer = GroupPayer.new
  end

  # GET /group_payers/1/edit
  def edit
  end

  # POST /group_payers or /group_payers.json
  def create
    @group_payer = GroupPayer.new(group_payer_params)

    respond_to do |format|
      if @group_payer.save
        format.html { redirect_to @group_payer, notice: "Group payer was successfully created." }
        format.json { render :show, status: :created, location: @group_payer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_payer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_payers/1 or /group_payers/1.json
  def update
    respond_to do |format|
      if @group_payer.update(group_payer_params)
        format.html { redirect_to @group_payer, notice: "Group payer was successfully updated." }
        format.json { render :show, status: :ok, location: @group_payer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_payer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_payers/1 or /group_payers/1.json
  def destroy
    @group_payer.destroy
    respond_to do |format|
      format.html { redirect_to group_payers_url, notice: "Group payer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_payer
      @group_payer = GroupPayer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_payer_params
      params.require(:group_payer).permit(:group_expense_id, :user_id, :integer, :lent, :borrow)
    end
end
