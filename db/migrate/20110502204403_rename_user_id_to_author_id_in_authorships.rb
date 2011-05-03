class RenameUserIdToAuthorIdInAuthorships < ActiveRecord::Migration
  def self.up
    rename_column :authorships, :user_id, :author_id
  end

  def self.down
        rename_column :authorships, :author_id, :user_id
  end
end
