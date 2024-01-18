ActiveAdmin.register Movie do
  permit_params :name, :description, :category, :image_url, :released_at,
                :views_counter, :likes_counter, :comments_counter, :status,
                :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id,
                :movie_outcast_id, movie_outcast_ids: [], movie_comment_ids: [],
                                   content_details: %i[duration country licence original_language]
  # movie_comments_attributes: %i[id content user_id _destroy],

  # def index
  #   super do |movies|
  #     movies.paginate(page: params[:page], per_page: 10)
  #   end
  # end

  # belongs_to :movie_writter
  # navigation_menu :movie_writter

  index do
    selectable_column
    id_column
    column :image_url do |movie|
      image_tag movie.image_url, width: 40, height: 30
    end
    column :name
    column :released_at
    column :video_link
    column :trailer_link
    column 'Views', :views_counter
    column 'Likes', :likes_counter
    column 'Comments', :comments_counter
    column 'Genre', :movie_genre
    column 'Author', :movie_writter
    column :status
    # column 'Outcasts', :movie_outcasts

    actions only: %i[show edit update] # TODO: Fix the only: options
  end

  # index as: :grid do |movie|
  #   link_to image_tag(movie.image_url), admin_movie_path(movie)
  # end

  show do
    attributes_table do
      row :name
      row :description
      row :category
      row :image_url do |movie|
        image_tag movie.image_url, width: 100, height: 70
      end
      row :released_at
      row :content_details, as: :json
      row :views_counter
      row :likes_counter
      row :comments_counter
      row :status
      row :movie_genre
      row :video_link
      row :trailer_link
      row :movie_writter
      row :movie_outcast_ids
      row :created_at
      row :updated_at
      table_for movie.movie_comments.order('id ASC') do
        column 'movie_comments' do |movie_comment|
          link_to movie_comment.text, [:admin, movie_comment] # item_path(movie_comment) TODO: Understand the :admin
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Movie Input' do
      f.input :name
      f.input :description
      f.input :category
      f.input :image_url
      f.input :released_at
      f.input :content_details, as: :json
      f.input :status
      f.input :movie_genre
      f.input :video_link_id, as: :select, collection: Video.all.map { |video_link| [video_link.url, video_link.id] }
      f.input :trailer_link
      f.input :movie_writter
      # f.input :movie_outcast_ids, as: :check_boxes
    end
    f.actions
  end

  filter :name
  filter :category
  filter :status, as: :select, collection: Movie.statuses.keys
  # filter :status, as: :select, collection: Movie.statuses.map { |status, _value| [status, status] }
  filter :released_at
  filter :movie_genre
  filter :movie_writter, as: :select, collection: MovieWritter.all.map { |writter| [writter.first_name, writter.id] }
  filter :movie_outcast_id
  filter :created_at

  scope :all, default: true

  scope :published do |movies|
    movies.where(status: 1)
  end

  scope :unreleased do |movies|
    movies.where(status: 0)
  end

  scope :banned do |movies|
    movies.where(status: 2)
  end

  # permit_params do
  #   permitted = [:name, :description, :category, :image_url, :content_details,
  #                :views_counter, :likes_counter, :comments_counter, :status,
  #                :movie_genre_id, :video_link_id, :trailer_link_id,
  #                :movie_writter_id, :movie_outcast_ids]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
