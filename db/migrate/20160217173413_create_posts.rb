class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
