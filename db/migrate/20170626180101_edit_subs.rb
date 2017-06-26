class EditSubs < ActiveRecord::Migration[5.1]
  def change
    remove_column :subs, :moderator_id
    # remove_index :subs, :moderator_id
  end
end
