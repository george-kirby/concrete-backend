class AddCompleteStepsToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :complete_steps, :string, array: true, default: []
  end
end
