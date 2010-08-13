class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  def home
    render :template => 'home/index'
  end
  
  def sample
    render :template => 'sample'
  end
end
