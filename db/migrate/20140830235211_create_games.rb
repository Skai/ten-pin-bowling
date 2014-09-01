class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :score
      t.boolean :is_finished

      t.timestamps
    end
  end
end
