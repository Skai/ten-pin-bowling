class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.boolean :is_active
      t.integer :roll1_pins
      t.integer :roll2_pins
      t.integer :roll3_pins
      t.references :game, index: true
      
      t.timestamps
    end
  end
end
