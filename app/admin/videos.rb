ActiveAdmin.register Video do
  permit_params :url, :status, details: %i[duration definition dimention size caption language mime_type]

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
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'Video Details' do
      f.input :url
      f.input :status
      f.input :details, as: :json
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
