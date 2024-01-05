class Serie < ApplicationRecord
  belongs_to :movie_genre
  belongs_to :movie_writter, optional: true
  # belongs_to :movie_outcast

  belongs_to :video_link

  # has_many :serie_comments, dependent: :destroy
  # has_many :serie_likes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 60 }
  validates :description, presence: true, length: { minimum: 12, maximum: 1200 }
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :content_details, presence: true

  enum status: { unreleased: 0, released: 1, banned: 2 }, _default: 'unreleased', _prefix: true
  enum category: { movie: 0, series: 1, documentary: 2 }, _default: 'serie', _prefix: true

  validates :status, presence: true, inclusion: { in: statuses.keys }
end
