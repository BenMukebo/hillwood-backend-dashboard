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
    column :name
    # column :category
    column :image_url do |movie|
      image_tag movie.image_url, width: 40, height: 40
    end
    column :video_link_id
    column :trailer_link_id
    column :views_counter
    column :likes_counter
    column :comments_counter
    # column :video_id
    column :status
    column 'Genre', :movie_genre
    column 'Author', :movie_writter
    # column 'Outcasts', :movie_outcasts

    actions
  end

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

  # or
  # permit_params do
  #   permitted = [:name, :description, :category, :image_url, :content_details,
  #                :views_counter, :likes_counter, :comments_counter, :status,
  #                :movie_genre_id, :video_link_id, :trailer_link_id,
  #                :movie_writter_id, :movie_outcast_ids]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
