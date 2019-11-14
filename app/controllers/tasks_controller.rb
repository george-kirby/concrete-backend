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
            last_position_at_time(task)
            render json: serialize(task)
        else
            render json: task.errors.full_messages
        end
    end

    def update
        task = Task.find(params[:id])
        old_actual_time = task.actual_time
        task.update(task_params)
        if task.valid?
            if old_actual_time != task.actual_time
                last_position_at_time(task)
            end
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
        task_data.to_json(:except => [:created_at, :updated_at])
    end

    def last_position_at_time(task)
        same_time_tasks = Task.all.filter{|t| (t.actual_time == task.actual_time) && (t != task)}
        if !same_time_tasks.empty?
            ordered_same_time_tasks = same_time_tasks.sort_by{|task| task.position_at_time}
            task.update(position_at_time: ordered_same_time_tasks.last.position_at_time + 1)
        end
    end

    def task_params
        improved_task_params = params.require(:task).permit(:user_id, :title, :project_id, :cue, :actual_time, :display_time, :position_at_time, :complete_steps, :incomplete_steps, :tags)
        improved_task_params[:complete_steps] = JSON.parse(improved_task_params[:complete_steps]) if improved_task_params[:complete_steps]
        improved_task_params[:incomplete_steps] = JSON.parse(improved_task_params[:incomplete_steps]) if improved_task_params[:incomplete_steps]
        improved_task_params[:tags] = JSON.parse(improved_task_params[:tags]) if improved_task_params[:tags]
        improved_task_params
    end
end
