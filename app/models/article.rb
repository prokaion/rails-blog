class Article < ActiveRecord::Base
  include Filterable

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }  
  scope :published, -> (published) { where published: published }
  scope :most_recent, -> { Article.published(true).limit(4) }

	validates :title, presence: true,
					  length: { minimum: 3 }
  validates :text, presence: true
  validates :text, length: { minimum: 6, maximum: 10000 }
  validates :user_id, presence: true

  before_save :set_published_at_if_published

  private
    def set_published_at_if_published
      if( self.published? )
        self.published_at = Time.now
      end
    end

end
