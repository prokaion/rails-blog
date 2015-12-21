class CreateRequestScores < ActiveRecord::Migration
  def change
    create_table :request_scores do |t|
      t.string :ip
      t.integer :request_count

      t.timestamps null: false
    end
    add_index :request_scores, :ip, unique: true
  end
end
