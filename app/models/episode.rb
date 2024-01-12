class Episode < ApplicationRecord
  belongs_to :video_link, class_name: 'Video', optional: true
  belongs_to :trailer_link, class_name: 'Video', optional: true
  belongs_to :season
  belongs_to :serie

  # has_many :episode_comments, dependent: :destroy
  # has_many :episode_likes, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 60 }
  validates :description, length: { maximum: 1200 }
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true

  enum status: { unreleased: 0, released: 1, banned: 2 }, _default: 'unreleased', _prefix: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
