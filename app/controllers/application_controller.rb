class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fName, :lName, :terms_of_service])
  end

  def redirect_to_tournament_with_privacy(tournament)
  	if tournament.privateURL
      redirect_to tournament_url_with_privacy(tournament)
    else
      redirect_to tournament
    end
  end

  def tournament_url_with_privacy(tournament)
		url_for(:controller => :tournaments, :action => "private_url", :key => tournament.private_url.key, :id => tournament.id)
  end
end
