class FeedController < ApplicationController
  allow_unauthenticated only: :show

  def show
    render :show
  end
end
