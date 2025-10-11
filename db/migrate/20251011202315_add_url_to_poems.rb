class AddUrlToPoems < ActiveRecord::Migration[8.0]
  def change
    add_column :poems, :url, :string
  end
end
