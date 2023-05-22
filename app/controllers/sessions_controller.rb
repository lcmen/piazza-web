class SessionsController < ApplicationController
  allow_unauthenticated only: %i[new create]

  def new
    render :new
  end

  def create
    if login = User.login(**session_params.to_h.symbolize_keys)
      remember(login)
      redirect_to root_path, success: t('.flash.success'), status: :see_other
    else
      flash.now[:danger] = t('.flash.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Current.login&.destroy
    redirect_to root_path, success: t('.flash.success'), status: :see_other
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
