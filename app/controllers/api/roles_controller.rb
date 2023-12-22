# class Api::RolesController < ::BaseController
class Api::RolesController < Api::ApiController
  # before_action :authenticate_user!
  before_action :set_role, only: %i[show edit update destroy]

  def index
    @roles = Role.includes(:users).all

    # render json: @roles, each_serializer: Roles::RoleSerializer, status: :ok
    render_success_response('Roles fetched successfully', @roles)
  end

  def show; end

  def new
    @role = Role.new
  end

  def edit; end

  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        # format.html { redirect_to api_role_url(@role), notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        # format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @role.update(role_params)
        # format.html { redirect_to api_role_url(@role), notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        # format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @role.destroy!

    respond_to do |format|
      # format.html { redirect_to api_roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def role_params
    params.require(:role).permit(:name)
  end
end
