class AddColumnToUpdate < ActiveRecord::Migration[5.2]
  def change
    add_column :updates, :created_at, :datetime
    add_column :updates, :updated_at, :datetime
  end
end
