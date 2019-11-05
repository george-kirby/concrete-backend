class StepsController < ApplicationController
    def index
        steps = Step.all
        render json: serialize(steps)
    end

    def show
        step = Step.find(params[:id])
        render json: serialize(step)
    end

    def create
        task = Task.find(step_params[:task_id])
        step = Step.create(step_params)
        if step.valid?
            step.update(position: task.steps.length + 1)
            render json: serialize(step)
        else
            render json: step.errors.full_messages
        end
    end

    def update
        step = Step.find(params[:id])
        if step.update(step_params)
            render json: serialize(step)
        else
            render json: step.errors.full_messages
        end
    end

    def destroy
        step = Step.find(params[:id])
        step.destroy
    end

    private

    def serialize(step_data)
        step_data.to_json(
            :except => [:created_at, :updated_at],
            :include => {
                :task => {
                    :only => [:id],
                    :include => {
                        :project => {:only => [:id]}
                    }
                }
            }
        )
    end

    def step_params
        params.require(:step).permit(:act, :task_id, :completed)
    end
end
