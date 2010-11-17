class CubbyholeController < ApplicationController

  def index
    if user_signed_in?
      render :index
    else
      render :index, :layout => false
    end
  end
  
end