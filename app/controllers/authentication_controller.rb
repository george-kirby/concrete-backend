class AuthenticationController < ApplicationController

    def create
        user = User.find_by(email: login_params[:email])
        if user && user.authenticate(login_params[:password])
            render json: { token: issue_token({user_id: user.id}), user: serialize(user)}
        else
            render json: { errors: ["Invalid login credentials"]}
        end
    end

    def validate
        if @current_user
            render json: { token: issue_token({user_id: @current_user.id}), user: serialize(@current_user)}
        else
            render json: { errors: ["user not found"] }
        end
    end

    private

    def serialize(user_data)
        user_data.to_json(
            :except => [:password_digest],
            :include => {
                :tasks => {:except => [:created_at, :updated_at, :user_id]}
            }
        )
    end

    def login_params
        params.require(:user).permit(:email, :password)
    end
end
