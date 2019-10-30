class TasksController < ApplicationController

    def index
        tasks = Task.all
        render json: serialize(tasks)
    end

    def show
        task = Task.find(params[:id])
        render json: serialize(task)
    end

    def create
        task = Task.new(task_params)
        if task.valid?
            task.save
            render json: serialize(task)
        end
    end

    def update
        task = Task.find(params[:id])
        task.update(task_params)
        render json: serialize(task)
    end

    def destroy
        task = Task.find(params[:id])
        task.destroy
    end

    private

    def serialize(task_data)
        task_data.to_json(
            :except => [:created_at, :updated_at],
            :include => {:steps => {:except => [:created_at, :updated_at]}})
    end

    def task_params
        params.require(:task).permit(:title, :project_id, :cue, :actual_time, :display_time, :position_at_time)
    end
end
