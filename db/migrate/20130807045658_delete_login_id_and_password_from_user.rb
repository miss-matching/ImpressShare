class DeleteLoginIdAndPasswordFromUser < ActiveRecord::Migration
  def up
     remove_column :users, :login_id
     remove_column :users, :password
  end

  def down
     remove_column :users, :login_id, :string
     remove_column :users, :password, :string
  end
end
