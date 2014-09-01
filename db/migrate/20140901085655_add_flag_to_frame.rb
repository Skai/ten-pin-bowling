class AddFlagToFrame < ActiveRecord::Migration
  def change
    add_column :frames, :flag, :string, :default => ''
  end
end
