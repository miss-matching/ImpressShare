class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :twitter_uid
      t.string :password
      t.string :login_id

      t.timestamps
    end
  end
end
