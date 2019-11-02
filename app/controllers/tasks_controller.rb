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
        task = Task.create(task_params)
        if task.valid?
            byebug
            same_time_tasks = Task.all.filter{|t| (t.actual_time == task.actual_time) && (t != task)}.sort_by{|task| task.position_at_time}
            if !same_time_tasks.empty?
                task.update(position_at_time: same_time_tasks.last.position_at_time + 1)
            end
            render json: serialize(task)
        else
            render json: task.errors.full_messages
        end
    end

    def update
        task = Task.find(params[:id])
        if task.update(task_params)
            render json: serialize(task)
        else
            render json: task.errors.full_messages
        end
    end

    def destroy
        task = Task.find(params[:id])
        task.destroy
    end

    private

    def serialize(task_data)
        task_data.to_json(
            :except => [:created_at, :updated_at],
            :include => {
                :project => {:except => [:created_at, :updated_at]}, 
                :steps => {:except => [:created_at, :updated_at]}
            }
        )
    end

    def task_params
        params.require(:task).permit(:title, :project_id, :cue, :actual_time, :display_time, :position_at_time)
    end
end
