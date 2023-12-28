ActiveAdmin.register Video do
  index do
    selectable_column
    id_column
    column :url
    column :mime_type
    column :status
    # actions
  end

  show do
    attributes_table do
      row :url
      row :mime_type
      row :status
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Video Details' do
      f.input :url
      f.input :mime_type
      f.input :status
    end
    f.actions
  end

  permit_params :url, :mime_type, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:url, :mime_type, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
