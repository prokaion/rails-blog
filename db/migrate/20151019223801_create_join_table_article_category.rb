class CreateJoinTableArticleCategory < ActiveRecord::Migration
  def change
    create_join_table :articles, :categories, :id => false do |t|
      t.integer :article_id
      t.integer :category_id
    end

    add_index(:articles_categories, [:article_id, :category_id])

  end
end
