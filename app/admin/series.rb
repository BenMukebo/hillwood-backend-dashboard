ActiveAdmin.register Serie do
  permit_params :name, :description, :category, :image_url, :status,
                :movie_genre_id, :video_link_id, :movie_writter_id, :movie_outcast_id,
                content_details: %i[duration country licence original_language]

  index do
    selectable_column
    id_column
    column :name
    column :image_url do |serie|
      image_tag serie.image_url, width: 40, height: 40
    end
    column :content_details
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
      row :image_url do |serie|
        image_tag serie.image_url, width: 100, height: 70
      end
      row :content_details
      row :status
      row :movie_genre
      row :video_link
      row :movie_writter
      row :movie_outcast_ids
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  filter :name
  filter :description
  filter :category
  filter :image_url
  filter :content_details
  filter :status

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

  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :category, :image_url,
  # :content_details, :status, :movie_genre_id, :video_id,
  # :movie_writter_id, :movie_outcast_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
