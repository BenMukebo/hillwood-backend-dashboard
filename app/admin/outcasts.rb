ActiveAdmin.register Outcast do
  config.per_page = 10
  json_editor
  permit_params :avatar_url, :first_name, :last_name, :date_of_birth,
                :personal_details, :status, movie_ids: [], series_ids: []

  index do
    selectable_column
    id_column
    column :avatar_url do |outcast|
      image_tag outcast.avatar_url, width: 50, height: 30, class: 'movie_writter_avatar', style: 'border-radius: 2px',
                                    alt: "#{outcast.first_name} #{outcast.last_name}"
    end
    column :first_name
    column :last_name
    column :status
    column :total_movie do |outcast|
      outcast.movies.count
    end
    column :total_serie do |outcast|
      outcast.series.count
    end

    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :date_of_birth
      row :avatar_url do |outcast|
        if outcast.avatar_url
          image_tag outcast.avatar_url, width: 40, height: 40, class: 'movie_writter_avatar',
                                        alt: "#{outcast.first_name} #{outcast.last_name}"
        end
      end
      row :personal_details
      row :status
      row :created_at
      row :updated_at

      if outcast.movies.present?
        row 'Movies' do |outcast|
          table_for outcast.movies do
            column 'Movie Image', :image_url do |movie|
              image_tag movie.image_url, width: 40, height: 30
            end
            column 'Name' do |movie|
              link_to movie.name, [:admin, movie]
            end
            column 'Released Date', :released_at
            column 'Views', :views
            column 'Genre', :movie_genre
            column 'Status', :status
          end
        end
      else
        row 'Movies' do
          'No Movies'
        end
      end

      if outcast.series.present?
        row 'Series' do |outcast|
          table_for outcast.series do
            column 'Serie Image', :image_url do |serie|
              image_tag serie.image_url, width: 40, height: 30
            end
            column 'Serie Name' do |serie|
              link_to serie.name, [:admin, serie]
            end
            column 'Seasons', :seasons do |serie|
              serie.seasons.count
            end
            column 'Views', :views
            column 'Genre', :movie_genre
            column 'Status', :status
          end
        end
      else
        row 'Series' do
          'No Series'
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'MovieOutcast Input' do
      f.input :first_name
      f.input :last_name
      f.input :avatar_url
      f.input :date_of_birth
      f.input :personal_details, as: :json
      f.input :status, as: :select, collection: MovieWritter.statuses.keys
      f.input :movies, as: :check_boxes, collection: Movie.all.map { |movie| [movie.name, movie.id] }
      f.input :series, as: :check_boxes, collection: Serie.all.map { |serie| [serie.name, serie.id] }
    end
    f.actions
  end

  filter :first_name
  filter :last_name
  filter :status, as: :select
  filter :date_of_birth

  # permit_params do
  #   permitted = [:avatar_url, :first_name, :last_name, :date_of_birth, :personal_details, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
