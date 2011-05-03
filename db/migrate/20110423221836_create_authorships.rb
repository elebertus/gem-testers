class CreateAuthorships < ActiveRecord::Migration
  def self.up
    create_table :authorships do |t|
      t.integer :author_id, null: false
      t.integer :rubygem_id, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :authorships
  end
end
