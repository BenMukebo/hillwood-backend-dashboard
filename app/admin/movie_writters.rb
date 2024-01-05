ActiveAdmin.register MovieWritter do
  permit_params :avatar_url, :first_name, :last_name, :personal_details, :status, movie_ids: []
  # has_many :movies

  json_editor

  index do
    selectable_column
    id_column
    column :avatar_url do |movie_writter|
      # image_tag movie_writter.avatar_url, width: 40, height: 40, class: 'movie_writter_avatar'
      image_url = movie_writter.avatar_url.nil? ? 'https://via.placeholder.com/150' : movie_writter.avatar_url
      image_tag image_url, width: 40, height: 40, class: 'movie_writter_avatar',
                           alt: "#{movie_writter.first_name} #{movie_writter.last_name}"
    end
    column :first_name
    column :last_name
    column :status
    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :avatar_url do |movie_writter|
        image_url = movie_writter.avatar_url.nil? ? 'https://via.placeholder.com/150' : movie_writter.avatar_url
        image_tag image_url, width: 100, height: 70, class: 'movie_writter_avatar',
                             alt: "#{movie_writter.first_name} #{movie_writter.last_name}"
      end
      row :personal_details
      row :status
      row :created_at
      row :updated_at
      # row: movie_ids
      table_for movie_writter.movies.order('name ASC') do
        column 'movies' do |movie|
          link_to movie.name, [:admin, movie] # item_path(movie) TODO: Understand the :admin
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'MovieWritter Input' do
      f.input :first_name
      f.input :last_name
      f.input :avatar_url
      f.input :personal_details, as: :json
      f.input :status, as: :select, collection: MovieWritter.statuses.keys
      f.input :movies, as: :check_boxes
    end
    f.actions
  end

  # or
  #
  # permit_params do
  #   permitted = [:first_name, :last_name, :avatar_url, :personal_details, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
