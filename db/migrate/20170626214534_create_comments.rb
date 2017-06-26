class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :author_id
      t.integer :post_id
      t.integer :parent_id
      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :post_id
    add_index :comments, :parent_id
  end
end
