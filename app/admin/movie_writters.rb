ActiveAdmin.register MovieWritter do
  config.per_page = 10
  json_editor
  permit_params :avatar_url, :first_name, :last_name, :date_of_birth,
                :personal_details, :status, movie_ids: [], series_ids: []

  index do
    selectable_column
    id_column
    column :avatar_url do |movie_writter|
      # image_tag movie_writter.avatar_url, width: 40, height: 40, class: 'movie_writter_avatar'
      image_url = movie_writter.avatar_url.nil? ? 'https://via.placeholder.com/150' : movie_writter.avatar_url
      image_tag image_url, alt: "#{movie_writter.first_name} #{movie_writter.last_name}",
                           width: 50, height: 30, class: 'movie_writter_avatar', style: 'border-radius: 2px'
    end
    column :first_name
    column :last_name
    column :status
    column :total_media do |movie_writter|
      movie_writter.series.size + movie_writter.movies.size
    end
    actions
  end

  controller do
    def scoped_collection
      super.includes(:movies, :series)
    end
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :date_of_birth
      row :avatar_url do |movie_writter|
        image_url = movie_writter.avatar_url.nil? ? 'https://via.placeholder.com/150' : movie_writter.avatar_url
        image_tag image_url, width: 100, height: 70, class: 'movie_writter_avatar',
                             alt: "#{movie_writter.first_name} #{movie_writter.last_name}"
      end
      row :personal_details
      row :status
      row :created_at
      row :updated_at
      # row :movies
      if movie_writter.movies.present?
        row 'Movies' do |movie_writter| # or => row :movies do |movie_writter|
          table_for movie_writter.movies do
            column 'Movie Image', :image_url do |movie|
              image_tag movie.image_url, width: 40, height: 30
            end
            column 'Movie Name' do |movie|
              link_to movie.name, [:admin, movie]
            end
            column 'Movie Released At', :released_at
            column 'Views', :views
            column 'Likes', :likes_counter
            column 'Comments', :comments_counter
            column 'outcasts' do |movie|
              movie.outcasts.size
            end
            column 'Genre', :movie_genre
            column 'Status', :status
          end
        end
      else
        row 'Movies' do
          span 'No Movies '
          span link_to(' Add New Movie', new_admin_movie_path) # TODO: Implement the path link to contain the movie_writter_id
        end
      end

      if movie_writter.series.present?
        row 'Series' do |movie_writter| # or => row :series do |movie_writter|
          table_for movie_writter.series do
            column 'Serie Image', :image_url do |serie|
              image_tag serie.image_url, width: 40, height: 30
            end
            column 'Serie Name' do |serie|
              link_to serie.name, [:admin, serie]
            end
            column 'Seasons', :seasons do |serie|
              serie.seasons.size
            end
            column 'Views', :views
            column 'outcasts' do |serie|
              serie.outcasts.size
            end
            column 'Genre', :movie_genre
            column 'Status', :status
          end
        end
      else
        row 'Series' do
          span 'No Series '
          span link_to(' Add New Serie', new_admin_series_path)
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
      # f.input :avatar_url, as: :file, input_html: { accept: 'image/*' }
      f.input :date_of_birth
      f.input :personal_details, as: :json
      f.input :status, as: :select, collection: MovieWritter.statuses.keys
      f.input :movies, as: :check_boxes # , collection: Movie.all.map { |movie| [movie.name, movie.id] }
      f.input :series, as: :check_boxes
      # div class: 'horizontal-checkbox-container' do
      #   f.input :movies, as: :check_boxes
      # end
    end
    f.actions
  end

  filter :first_name
  filter :last_name
  filter :status, as: :select, collection: MovieWritter.statuses.keys
  filter :date_of_birth
end
