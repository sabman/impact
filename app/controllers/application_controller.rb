class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  def home
    render :template => 'home/index'
  end
end
