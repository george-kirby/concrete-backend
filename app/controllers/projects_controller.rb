class ProjectsController < ApplicationController

    def index
        projects = Project.all
        render json: serialize(projects)
    end

    def show
        project = Project.find(params[:id])
        render json: serialize(project)
    end

    def create
        project = Project.create(project_params)
        if project.valid?
            render json: serialize(project)
        else
            render json: project.errors.full_messages
        end
    end

    def update
        project = Project.find(params[:id])
        if project.update(project_params)
            render json: serialize(project)
        else
            render json: project.errors.full_messages
        end
    end

    def destroy
        project = Project.find(params[:id])
        project.destroy
    end

    private

    def serialize(project_data)
        project_data.to_json(:include => {
            :tasks => {
                :except => [:created_at, :updated_at, :project_id],
                :include => [:project => {:except => [:created_at, :updated_at]}, 
                    :steps => {:except => [:created_at, :updated_at, :task_id]}]
            }
        })
    end

    def project_params
        params.require(:project).permit(:title, :user_id)
    end
end
