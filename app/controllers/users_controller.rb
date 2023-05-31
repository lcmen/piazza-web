class UsersController < ApplicationController
  allow_unauthenticated only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Organization.create(members: [@user])
      remember(@user.logins.create)
      redirect_to root_path, status: :see_other, success: t('.flash.success', name: @user.name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
