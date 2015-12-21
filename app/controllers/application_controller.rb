class ApplicationController < ActionController::Base

  before_action :session_counter
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ArticlesHelper

  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def session_counter
     
      request_score = RequestScore.find_by(ip: request.remote_ip)

      if(request_score.nil?)
        request_score = RequestScore.new do |r|
          r.ip = request.remote_ip
          r.request_count = 0;
        end
      end
      request_score.request_count += 1

      if(request_score.save)
        puts request_score.ip + " saved success!"
      else
        puts "could not save request: "+request_score.ip+" to db!"
      end
    end
end
