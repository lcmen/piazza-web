module CookiesHelper
  def raw_cookie(name)
    cookies.get_cookie(name.to_s)
  end
end
