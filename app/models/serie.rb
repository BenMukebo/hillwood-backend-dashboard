class Serie < ApplicationRecord
  include MediaFilters

  belongs_to :movie_genre
  belongs_to :movie_writter, optional: true # , class_name: 'MovieWritter', foreign_key: 'movie_writter_id'
  belongs_to :video_link, class_name: 'Video', optional: true # , foreign_key: :video_link_id

  has_many :seasons, dependent: :restrict_with_error
  has_many :episodes, through: :seasons, dependent: :restrict_with_error
  has_many :serie_comments, dependent: :destroy
  has_many :serie_likes, dependent: :destroy

  # represents the association between the serie and the outcast
  has_many :outcast_associations, as: :media_association, dependent: :destroy
  has_many :outcasts, through: :outcast_associations

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2, maximum: 60 }
  validates :description, presence: true, length: { minimum: 12, maximum: 1200 }
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true
  validates :content_details, presence: true

  enum status: { unreleased: 0, released: 1, banned: 2 }, _default: 'unreleased', _prefix: true
  enum category: { movie: 0, series: 1, documentary: 2 }, _default: 'serie', _prefix: true

  validates :status, presence: true, inclusion: { in: statuses.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[category created_at description id image_url
       movie_genre_id movie_outcast_id content_details
       movie_writter_id outcasts_id name status updated_at video_link_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[serie_comments movie_genre movie_writter outcasts seasons episodes video_link]
  end

  def self.released
    where(status: [1, 2])
  end

  def increment_view
    self.views += 1
    save
  end

  # def self.search_by_name(name)
  #   where('name ILIKE ?', "%#{name}%")
  # end
end
