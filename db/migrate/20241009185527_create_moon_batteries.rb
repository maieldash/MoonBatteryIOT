class CreateMoonBatteries < ActiveRecord::Migration[7.2]
  def change
    create_table :moon_batteries do |t|
      t.string :mac_address, null: false
      t.string :serial_number, null: false, limit: 6
      t.datetime :last_ping
      t.integer :charge_level, null: false, default: 0
      t.integer :temperature, null: false, default: 20
      t.string :mode, null: false, default: "eco"
      t.integer :power_limit, null: false, default: 1000
      t.references :connected_lunar_cell, foreign_key: { to_table: :lunar_cells }

      t.timestamps
    end
    add_index :moon_batteries, :serial_number, unique: true
    add_index :moon_batteries, :mac_address, unique: true
  end
end
