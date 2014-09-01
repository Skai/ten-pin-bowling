class AddScoreToFrame < ActiveRecord::Migration
  def change
    add_column :frames, :score, :integer, :default => 0
  end
end
