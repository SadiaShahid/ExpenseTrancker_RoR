class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = current_user.groups
    authorize @groups

  end

  # GET /groups/1 or /groups/1.json
  def show
    authorize @group
    if !@group.group_users.where( role: "owner" ).empty?
      @owner = @group.group_users.where( role: "owner" ).first.user 
    else
      @group.group_users.first.update(role:'owner')
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
    authorize @group
  end

  # GET /groups/1/edit
  def edit
    @group = current_user.groups.find(params[:id])
    authorize @group

  end

  # POST /groups or /groups.json
  def create
    # authorize @group

    @group = Group.new(group_params)
    @group.group_users.new(user: current_user, role: 'owner')
    @group.add_by = current_user.id
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group was successfully updated." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = current_user.groups.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :add_by)
    end
end
