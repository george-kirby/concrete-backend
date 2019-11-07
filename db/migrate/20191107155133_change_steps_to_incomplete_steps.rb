class ChangeStepsToIncompleteSteps < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :steps, :incomplete_steps
  end
end
