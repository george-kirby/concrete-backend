class UsersController < ApplicationController

    def index
        users = User.all
        render json: serialize(users)
    end

    def show
        user = User.find(params[:id])
        render json: serialize(user)
    end
    
    def create
        user = User.new(user_params)
        if user.valid?
            user.save
            render json: user
        end
    end

    def update
        user = User.find(params[:id])
        user.update(user_params)
        render json: user
    end

    # def destroy
    #     user = User.find(params[:id])
    #     user.destroy
    # end

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

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
