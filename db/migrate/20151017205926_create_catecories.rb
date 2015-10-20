class CreateCatecories < ActiveRecord::Migration
  def change
    create_table :catecories do |t|
      t.string :cat_name

      t.timestamps null: false
    end
  end
end
