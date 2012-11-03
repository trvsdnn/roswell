class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def allowed_tags_for(model)
    klass = model.to_s[0..-2].camelize.constantize
    tags = klass.tags
    if current_user.admin?
      tags
    else
      tags.reject { |tag| !current_user.allowed_tags.include?(tag) }
    end
  end
  helper_method :allowed_tags_for

  def authorize
    if current_user.nil?
      redirect_to login_url, :alert => 'Not authorized'
    elsif params[:action] == 'tagged' && ( !current_user.admin? && !current_user.allowed_tags.include?(params[:tag]) )
      redirect_to login_url, :alert => 'Not authorized'
    end
  end
end
