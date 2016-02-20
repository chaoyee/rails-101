class AddPostCountToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :post_count, :integer, default: 0
  end
end
