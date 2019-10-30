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
        project = Project.new(project_params)
        byebug
        if project.valid?
            project.save
            render json: serialize(project)
        # else
        #     render project.errors.full_messages # incorrect syntax
        end
    end

    def update
        project = Project.find(params[:id])
        project.update(project_params)
        render json: serialize(project)
    end

    def destroy
        project = Project.find(params[:id])
        project.destroy
    end

    private

    def serialize(project_data)
        project_data.to_json(:include => {
            :tasks => {
                :except => [:created_at, :updated_at, :id, :project_id],
                :include => [:steps => {:except => [:created_at, :updated_at, :id, :task_id]}]
            }
        })
    end

    def project_params
        params.require(:project).permit(:title, :user_id)
    end
end
