class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.references :user
      t.string :title
      t.string :description
      t.string :kind
      t.string :image_url
      t.string :identifier
      t.string :github_url
      t.string :markdown_content ,limit: 10000
      t.string :command_options, limit: 500
      t.integer :published_status

      t.timestamps
    end
    add_index :slides, :user_id
    add_index :slides, :identifier, unique: true
  end
end
