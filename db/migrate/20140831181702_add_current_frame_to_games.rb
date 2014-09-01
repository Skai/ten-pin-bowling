class AddCurrentFrameToGames < ActiveRecord::Migration
  def change
    add_column :games, :current_frame, :integer, :default => 1
    add_column :games, :current_roll, :integer, :default => 1
  end
end