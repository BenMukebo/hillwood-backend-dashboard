ActiveAdmin.register Movie do
  permit_params :name, :description, :category, :image_url, :content_details,
                :views_counter, :likes_counter, :comments_counter, :status,
                :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, :movie_outcast_id

  # def index
  #   super do |movies|
  #     movies.paginate(page: params[:page], per_page: 10)
  #   end
  # end

  # movie has many movie_comments
  # movie has many movie_likes

  # belongs_to :movie_writter
  # navigation_menu :movie_writter

  index do
    selectable_column
    id_column
    column :name
    # column :category
    column :image_url do |movie|
      image_tag movie.image_url, width: 60, height: 60
    end
    column :video_link_id
    column :trailer_link_id
    column :views_counter
    column :likes_counter
    column :comments_counter
    # column :video_id
    column :status
    column :movie_genre
    column :movie_writter
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :category
      row :image_url do |movie|
        image_tag movie.image_url, width: 100
      end
      row :content_details
      row :views_counter
      row :likes_counter
      row :comments_counter
      row :status
      row :movie_genre
      row :video_link_id
      # row :video_link_id, :as => :select, :collection => Video.all.map{|u| ["#{u.title}", u.id]}
      row :trailer_link_id
      row :movie_writter
      row :movie_outcast_id
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Movie Input' do
      f.input :name
      f.input :description
      f.input :category
      f.input :image_url
      f.input :content_details, as: :json
      f.input :status
      f.input :movie_genre
      f.input :video_link_id
      f.input :trailer_link_id
      f.input :movie_writter
      f.input :movie_outcast_id
    end
    f.actions
  end

  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :category, :image_url, :content_details, :views_counter, :likes_counter, :comments_counter, :status, :movie_genre_id, :video_link_id, :trailer_link_id, :movie_writter_id, :movie_outcast_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
