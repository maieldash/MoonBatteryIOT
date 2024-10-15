class CreateConfigurations < ActiveRecord::Migration[7.2]
  def change
    create_table :configurations do |t|
      t.references :moon_battery, null: false, foreign_key: true
      t.string :key, null: false
      t.string :value, null: false

      t.timestamps
    end
  end
end
