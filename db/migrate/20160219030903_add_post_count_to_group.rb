class AddPostCountToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :post_count, :integer, default: 0
  end
end
