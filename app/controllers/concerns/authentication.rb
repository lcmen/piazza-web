module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
    before_action :require_login

    helper_method :logged_in?
  end

  class_methods do
    def allow_unauthenticated(**kwargs)
      skip_before_action :require_login, **kwargs
    end

    def skip_authentication(**kwargs)
      skip_before_action :authenticate, **kwargs
      skip_before_action :require_login, **kwargs
    end
  end

  protected

  def logged_in?
    Current.user.present?
  end

  def require_login
    return if logged_in?

    redirect_to login_path, danger: t('flash.login_required'), status: :see_other
  end

  private

  def authenticate
    login = authenticate_with_cookie

    Current.login = login
    Current.user = login&.user
  end

  def authenticate_with_cookie
    data = cookies.encrypted[:login]&.with_indifferent_access
    data => { id:, user_id:, token: }
    User.authenticate(id: user_id, login_id: id, token: token)
  rescue NoMatchingPatternError
    nil
  end

  def remember(login)
    cookies.encrypted.permanent[:login] = { value: login.to_h }
  end
end
