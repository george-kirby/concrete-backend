class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :act
      t.integer :position, default: 1
      t.boolean :completed, default: false
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
