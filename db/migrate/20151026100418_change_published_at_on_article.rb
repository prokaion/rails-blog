class ChangePublishedAtOnArticle < ActiveRecord::Migration
  def change
    change_column :articles, :published_at, :datetime, :null => true, :default => nil
  end
end
