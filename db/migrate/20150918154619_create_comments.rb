class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :article, index: true, foreign_key: true
      t.string :commenter,
      t.text :body

      t.timestamps null: false
    end
  end
end
