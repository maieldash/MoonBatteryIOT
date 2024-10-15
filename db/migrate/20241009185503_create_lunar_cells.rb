class CreateLunarCells < ActiveRecord::Migration[7.2]
  def change
    create_table :lunar_cells do |t|
      t.string :name, null: false
      t.string :location

      t.timestamps
    end
  end
end
