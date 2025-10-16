class AddContentToPoems < ActiveRecord::Migration[8.0]
  def change
    add_column :poems, :content, :text, null: false
    remove_column :poems, :url, :string
  end
end
