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
        step = Step.new(step_params)
        if step.valid?
            step.save
            render json: serialize(step)
        end
    end

    def update
        step = Step.find(params[:id])
        step.update(step_params)
        render json: serialize(step)
    end

    def destroy
        step = Step.find(params[:id])
        step.destroy
    end

    private

    def serialize(step_data)
        step_data.to_json(:except => [:created_at, :updated_at])
    end

    def step_params
        params.require(:step).permit(:act, :task_id, :position, :completed)
    end
end
