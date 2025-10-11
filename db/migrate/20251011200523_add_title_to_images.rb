class AddTitleToImages < ActiveRecord::Migration[8.0]
  def change
    add_column :images, :title, :string
  end
end
