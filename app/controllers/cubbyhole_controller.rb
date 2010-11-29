class CubbyholeController < ApplicationController

  def index
    if user_signed_in?
      @articles = current_user.articles
      render :index
    else
      render :index, :layout => false
    end
  end
  
end