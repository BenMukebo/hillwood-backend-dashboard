class Movie < ApplicationRecord
  belongs_to :movie_writter, optional: true # , class_name: 'MovieWritter', foreign_key: 'movie_writter_id'
  # has_many :movie_outcasts, class_name: 'MovieOutcast', foreign_key: 'movie_outcast_id', dependent: :destroy
  # has_and_belongs_to_many :movie_outcasts, join_table: :movies_movie_outcasts

  belongs_to :movie_genre

  belongs_to :video_link, class_name: 'Video', optional: true # , foreign_key: :video_link_id
  belongs_to :trailer_link, class_name: 'Video', optional: true # , foreign_key: :trailer_link_id

  # has_one :trailer_link, foreign_key: :video_link_id
  # has_one :video_link, foreign_key: :trailer_link_id
  # belongs_to :movie_outcast

  has_many :movie_comments, dependent: :destroy
  has_many :movie_likes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 60 }
  validates :description, presence: true, length: { minimum: 12, maximum: 1200 }
  validates :image_url, format: { with: URI::DEFAULT_PARSER.make_regexp }
  validates :content_details, presence: true
  validates :views_counter, :likes_counter, :comments_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  enum status: { unreleased: 0, released: 1, banned: 2 }, _default: 'unreleased', _prefix: true
  enum category: { movie: 0, series: 1, documentary: 2 }, _default: 'movie', _prefix: true
  # enum status: { pending: 0, processing: 1, processed: 2, failed: 3, completed: 4 }, _default: 'pending', _prefix: true

  validates :status, presence: true, inclusion: { in: statuses.keys }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name category content_details created_at description image_url status
       comments_counter likes_counter views_counter trailer_link_id video_link_id updated_at
       movie_genre_id movie_outcast_id movie_writter_id ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[movie_comments movie_genre movie_likes movie_writter trailer_link video_link]
  end

  # def self.search_by_name(name)
  #   where('name ILIKE ?', "%#{name}%")
  # end

  # def self.search_by_category(category)
  #   where(category: category)
  # end

  # def self.search_by_name_and_category(name, category)
  #   where('name ILIKE ?', "%#{name}%").where(category: category)
  # end

  # def self.search_by_name_or_category(name, category)
  #   where('name ILIKE ? OR category = ?', "%#{name}%", category)
  # end
end

# Unknown key: :optional.
# Valid keys are: :class_name, :anonymous_class, :primary_key, :foreign_key, :dependent, :validate, :inverse_of, :strict_loading, :autosave, :required, :touch
