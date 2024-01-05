ActiveAdmin.register Season do
  permit_params :title, :description, :image_url, :status, :video_link_id, :episods_counter, :serie_id

  index do
    selectable_column
    id_column
    column :title
    column :status
    column :episods_counter
    column 'Serie', :serie

    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :image_url do |season|
        image_tag season.image_url, width: 100, height: 70
      end
      row :status
      row :video_link
      row :episods_counter
      row :serie
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :image_url, :status, :video_link_id, :episods_counter, :serie_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
