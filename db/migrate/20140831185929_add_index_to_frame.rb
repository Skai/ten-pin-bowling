class AddIndexToFrame < ActiveRecord::Migration
  def change
    add_column :frames, :idx, :integer, :default => 1
  end
end
