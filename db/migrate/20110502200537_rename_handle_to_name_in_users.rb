class RenameHandleToNameInUsers < ActiveRecord::Migration
  def self.up
    rename_column :users, :handle, :name
  end

  def self.down
    rename_column :users, :name, :handle
  end
end
