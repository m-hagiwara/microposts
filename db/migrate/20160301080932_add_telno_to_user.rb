class AddTelnoToUser < ActiveRecord::Migration
  def change
    add_column :users, :telno, :integer
  end
end
