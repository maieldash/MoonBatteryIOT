class CreateLunarCells < ActiveRecord::Migration[7.2]
  def change
    create_table :lunar_cells do |t|
      t.string :name, null: false
      t.bigint :location_id
      t.string :serial_number, null: false, limit: 6

      t.timestamps
    end
  end
end
