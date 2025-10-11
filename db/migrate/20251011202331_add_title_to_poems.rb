class AddTitleToPoems < ActiveRecord::Migration[8.0]
  def change
    add_column :poems, :title, :string
  end
end
