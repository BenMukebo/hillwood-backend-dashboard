ActiveAdmin.register Episode do
  menu parent: %w[Series Seasons]
  permit_params :name, :description, :image_url, :released_at, :duration, :status,
                :video_link_id, :trailer_link_id, :season_id, :serie_id

  index do
    selectable_column
    id_column
    column :name
    column :image_url do |episode|
      image_tag episode.image_url, width: 40, height: 40, class: 'admin-table-img'
    end
    column :released_at
    column :duration
    column :status
    column :video_link
    column :trailer_link
    column :season
    column :serie
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :image_url do |episode|
        image_tag episode.image_url, width: 100, height: 70, class: 'admin-table-img'
      end
      row :released_at
      row :duration
      row :status
      row :video_link
      row :trailer_link
      row :season
      row :serie
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :image_url
      f.input :released_at
      f.input :duration
      f.input :status
      f.input :video_link
      f.input :trailer_link
      f.input :season
      f.input :serie
    end
    f.actions
  end

  filter :name
  filter :released_at
  filter :duration
  filter :status

  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :image_url, :released_at, :duration, :status,
  #                :video_link_id, :trailer_link_id, :season_id, :serie_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
