class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :cue
      t.string :display_time
      t.datetime :actual_time
      t.integer :position_at_time, default: 1
      t.string :tags, array: true, default: []
      t.string :steps, array: true, default: []
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
