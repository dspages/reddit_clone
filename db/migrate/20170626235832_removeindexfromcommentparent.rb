class Removeindexfromcommentparent < ActiveRecord::Migration[5.1]
  def change
    remove_index :comments, :parent_id
  end
end
