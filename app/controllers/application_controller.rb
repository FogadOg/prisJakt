class ApplicationController < ActionController::Base
    helper_method :currentUser

    def currentUser
      @currentUser ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    
  def redirectLoggedInUser
    if currentUser
      redirect_to root_path 
    end
  end
end
