class RemoveImageFileFromImages < ActiveRecord::Migration[8.0]
  def change
    remove_column :images, :image_file, :string
  end
end
