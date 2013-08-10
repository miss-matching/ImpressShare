class AddPublishedStatusToSlides < ActiveRecord::Migration
  def change
      add_column :slides, :published_status, :integer
  end
end
