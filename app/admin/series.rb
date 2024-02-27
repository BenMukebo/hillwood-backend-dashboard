ActiveAdmin.register Serie do
  config.per_page = [10, 15, 20]
  permit_params :name, :description, :category, :image_url, :views, :status,
                :movie_genre_id, :video_link_id, :movie_writter_id, outcast_ids: [],
                                                                    content_details: %i[duration country licence original_language]

  index do
    selectable_column
    id_column
    column :image_url do |serie|
      image_tag serie.image_url, width: 40, height: 30
    end
    column :name
    column 'Preview video', :video_link
    column 'Author', :movie_writter
    column 'Genre', :movie_genre
    column :views
    # column :comments do |serie|
    #   serie.serie_comments.size
    # end
    # column :likes do |serie|
    #   serie.serie_likes.size
    # end
    column :likes_count
    column :comments_count
    column :seasons, as: :select
    # column :seasons_list do |serie|
    #   serie.seasons.map(&:title).join(', ')
    #   serie.seasons.map { |season| link_to season.title, [:admin, season] }.join(', ').html_safe
    # end
    column :status

    actions only: %i[show edit update]
  end

  controller do
    def scoped_collection
      super.includes(:movie_genre, :movie_writter, :video_link, :seasons, :video_link, :serie_comments, :serie_likes)
    end
  end

  show do
    attributes_table do
      row :name
      row :description
      row :category
      row :image_url do |serie|
        image_tag serie.image_url, width: 100, height: 70
      end
      row :content_details
      row :views
      row :likes_count
      row :comments_count
      row :status
      row :movie_genre
      row :video_link
      row :movie_writter
      row :outcasts do |serie|
        # serie.outcasts.map(&:first_name).join(', ')
        serie.outcasts.map { |outcast| "- #{link_to("#{outcast.first_name} #{outcast.last_name}", [:admin, outcast])}" }.join(', ').html_safe
      end
      row :created_at
      row :updated_at
      table_for serie.seasons.order('title ASC') do
        column 'seasons' do |season|
          link_to season.title, [:admin, season]
        end
      end

      table_for serie.serie_comments.order('id ASC') do
        column 'serie_comments' do |serie_comment|
          link_to serie_comment.text, [:admin, serie_comment]
        end
      end
    end
    active_admin_comments
  end

  filter :name
  filter :category
  filter :status
  filter :movie_genre
  filter :movie_writter
  # filter :outcasts
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :category
      f.input :image_url
      f.input :content_details
      f.input :status
      f.input :movie_genre
      f.input :video_link
      f.input :movie_writter, collection: MovieWritter.all.map { |movie_writter| ["#{movie_writter.first_name} #{movie_writter.last_name}", movie_writter.id] }
      f.input :outcasts, as: :check_boxes, collection: Outcast.all.map { |outcast| ["#{outcast.first_name} #{outcast.last_name}", outcast.id] }
    end
    f.actions
  end

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
  #   permitted = [:name, :description, :category, :image_url,
  # :content_details, :status, :movie_genre_id, :video_id,
  # :movie_writter_id, :movie_outcast_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
