ActiveAdmin.register Video do
  permit_params :url, :status, details: %i[duration definition dimention size caption language mime_type], movie_ids: []

  json_editor

  index do
    selectable_column
    id_column
    column :url
    column :status
    actions
  end

  show do
    attributes_table do
      row :url
      row :status
      row :details, as: :json
      row :created_at
      row :updated_at
      # table_for video.movies.order('name ASC') do
      #   column "Movies" do |movie|
      #     link_to movie.name, admin_movie_path(movie)
      #   end
      # end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Video Details' do
      f.input :url
      f.input :status
      f.input :details, as: :json
      # f.input :movies, :as => :check_boxes
    end
    f.actions
  end

  # or
  #
  # permit_params do
  #   permitted = [:url, :mime_type, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
