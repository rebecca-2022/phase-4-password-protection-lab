class SessionsController < ApplicationController
    # POST /sessions
    def create 
        @user = User.find_by(username: params[:username])
        if @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            render json: @user, status: :created
        else
            render json: {error: "Invalid Username or Password"}, status: :unauthorized
        end
    end

    # DELETE /sessions
    def destroy
        session.delete :user_id
        head :no_content
    end
end