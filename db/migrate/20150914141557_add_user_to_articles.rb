class AddUserToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :user, index: true, foreign_key: true
    add_index :articles, [:user_id, :created_at]
  end

end
