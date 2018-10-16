class CreateUpdatesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :updates do |t|
      t.string :title
      t.text :notes
      t.integer :project_id
    end
  end
end
