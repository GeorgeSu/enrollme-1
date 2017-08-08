class AddPointerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recommendation_pointer, :int, :default => 0
  end
end
