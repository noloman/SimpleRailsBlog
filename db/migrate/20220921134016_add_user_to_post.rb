class AddUserToPost < ActiveRecord::Migration[7.0]
  def change
    change_table :posts do |p|
      p.references :user
    end
  end
end
