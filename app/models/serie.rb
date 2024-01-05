class Serie < ApplicationRecord
  belongs_to :movie_genre
  belongs_to :movie_writter, optional: true
  # belongs_to :movie_outcast, optional: true
  belongs_to :video_link, class_name: 'Video', optional: true # , foreign_key: :video_link_id

  # has_many :serie_comments, dependent: :destroy
  # has_many :serie_likes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 60 }
  validates :description, presence: true, length: { minimum: 12, maximum: 1200 }
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :content_details, presence: true

  enum status: { unreleased: 0, released: 1, banned: 2 }, _default: 'unreleased', _prefix: true
  enum category: { movie: 0, series: 1, documentary: 2 }, _default: 'serie', _prefix: true

  validates :status, presence: true, inclusion: { in: statuses.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category content_details created_at description id image_url movie_genre_id movie_outcast_id
       movie_writter_id name status updated_at video_link_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movie_genre movie_writter video_link]
  end
end
