class Album < ApplicationRecord
  has_and_belongs_to_many :artists
  # has_many :songs, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 60 }
  validates :description, presence: true, length: { minimum: 12, maximum: 1200 }
  validates :photo_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true
  validates :release_date, presence: true
  validates :songs_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  enum status: { unpublished: 0, published: 1, banned: 2 }, _default: 'unpublished', _prefix: true

  validates :status, presence: true, inclusion: { in: statuses.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category content_details created_at description id name photo_url released_date songs_counter status updated_at
       video_link]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['artists']
  end
end
