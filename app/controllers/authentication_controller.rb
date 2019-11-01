class AuthenticationController < ApplicationController

    def create
        # byebug
        user = User.find_by(email: login_params[:email])
        if user && user.authenticate(login_params[:password])
            render json: { token: issue_token({user_id: user.id}), user: serialize(user)}
        else
            render json: { errors: ["Invalid login credentials"]}
        end
    end

    private

    def serialize(user_data)
        user_data.to_json(
            :except => [:password_digest],
            :include => {
            :projects => {
                :except => [:created_at, :updated_at, :id, :user_id],
                :include => [:tasks => {
                    :except => [:created_at, :updated_at, :id, :project_id],
                    :include => [:steps => {:except => [:created_at, :updated_at, :id, :task_id]}]
                }]
            }
        })
    end

    def login_params
        params.require(:user).permit(:email, :password)
    end
end
