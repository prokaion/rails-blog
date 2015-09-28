class Comment < ActiveRecord::Base
  belongs_to :article

  default_scope -> { order(created_at: :desc) }

  validates :commenter, presence: true
  validates :body, presence: true
  validates :body, length: { minimum: 3, maximum: 1000 }
end
