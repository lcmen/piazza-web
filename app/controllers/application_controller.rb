class ApplicationController < ActionController::Base
  include Authentication

  add_flash_types :danger, :success
end
