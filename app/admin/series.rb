ActiveAdmin.register Serie do
  permit_params :name, :description, :category, :image_url, :views, :status,
                :movie_genre_id, :video_link_id, :movie_writter_id, :movie_outcast_id,
                content_details: %i[duration country licence original_language]

  index do
    selectable_column
    id_column
    column :image_url do |serie|
      image_tag serie.image_url, width: 40, height: 30
    end
    column :name
    column :comments do |serie|
      serie.serie_comments.count
    end
    column :likes do |serie|
      serie.serie_likes.count
    end
    column :views
    column 'Preview video', :video_link
    column 'Genre', :movie_genre
    column 'Author', :movie_writter
    column :seasons, as: :select
    # column :seasons_list do |serie|
    #   serie.seasons.map(&:title).join(', ')
    #   serie.seasons.map { |season| link_to season.title, [:admin, season] }.join(', ').html_safe
    # end
    column :status
    # column 'Outcasts', :movie_outcasts

    actions only: %i[show edit update]
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
      row :likes do |serie|
        serie.serie_likes.count
      end
      row :comments do |serie|
        serie.serie_comments.count
      end
      row :status
      row :movie_genre
      row :video_link
      row :movie_writter
      row :movie_outcast_ids
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
  filter :movie_outcast
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
      f.input :video_link_id, as: :select, collection: Video.all.map { |video_link| [video_link.url, video_link.id] }
      f.input :movie_writter_id
      f.input :movie_outcast_id
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
