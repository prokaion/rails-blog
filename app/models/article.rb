class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
	validates :title, presence: true,
					  length: { minimum: 3 }
  validates :text, presence: true
  validates :text, length: { minimum: 6, maximum: 10000 }
  validates :user_id, presence: true


end
