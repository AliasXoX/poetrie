class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :poem, null: false, foreign_key: true
      t.integer :start_position, null: false
      t.integer :end_position, null: false
      t.text :content, limit: 100000, null: false
      t.timestamps
    end
  end
end
