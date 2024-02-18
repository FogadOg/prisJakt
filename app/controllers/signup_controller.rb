class SignupController < ApplicationController
    
    def create
        @user = User.new(user_params)
        inputUserName = user_params["name"]
        inputUserPassword = user_params["password"]
  
        if User.exists?(name: inputUserName)
            @message = "user with the username already exists"
            render :new, status: :unprocessable_entity

        elsif isPasswordValid(inputUserPassword)
            @message = "invalid password"
            render :new, status: :unprocessable_entity
        else
            @user.save
            redirect_to root_path, notice: "You have been registered successfully."
        end
    end

    def isPasswordValid(password)
        if password.present? && !password.match(/\A(?=.*[A-Z])(?=.*[0-9])(?=.*\W)/)
          return true
        end
        return false
    end

  
    def new
      @user = User.new
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :password)
    end
  end
  