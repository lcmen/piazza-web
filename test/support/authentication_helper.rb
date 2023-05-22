module AuthenticationHelper
  def login(user, password = 'password')
    post login_path, params: { user: { email: user.email, password: } }
  end

  def logout
    delete logout_path
  end
end
