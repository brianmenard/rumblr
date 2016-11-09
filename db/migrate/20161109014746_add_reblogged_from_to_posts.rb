class AddRebloggedFromToPosts < ActiveRecord::Migration
  def change
    
    add_column :posts, :reblogged_from, :integer
    
  end
end
