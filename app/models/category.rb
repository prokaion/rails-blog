class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  default_scope -> { order(cat_name: :asc) }
  validates :cat_name, length: { minimum: 3, maximum: 30 }
end

