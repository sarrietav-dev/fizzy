class Users::PermissionsController < ApplicationController
  wrap_parameters :user, include: %i[ can_create_boards ]

  before_action :set_user
  before_action :ensure_permission_to_administer_user

  def update
    @user.update!(permission_params)

    respond_to do |format|
      format.html { redirect_to account_settings_path }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = Current.account.users.active.find(params[:user_id])
    end

    def ensure_permission_to_administer_user
      head :forbidden unless Current.user.can_administer?(@user)
    end

    def permission_params
      params.require(:user).permit(:can_create_boards)
    end
end
