module AuthenticationHelper
  def login(user, password = 'password', remember_me:)
    params = { email: user.email, password: }
    params[:remember_me] = "true" if remember_me
    post login_path, params: { user: params }
  end

  def logout
    delete logout_path
  end
end
