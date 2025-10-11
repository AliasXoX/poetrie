class AddImageFileToImages < ActiveRecord::Migration[8.0]
  def change
    add_column :images, :image_file, :string
  end
end
