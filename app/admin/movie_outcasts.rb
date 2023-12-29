ActiveAdmin.register MovieOutcast do
  permit_params :avatar_url, :first_name, :last_name, :personal_details, :status

  json_editor

  index do
    selectable_column
    id_column
    column :avatar_url
    column :first_name
    column :last_name
    column :status
    actions
  end

  show do
    attributes_table do
      row :avatar_url
      row :first_name
      row :last_name
      row :personal_details
      row :status
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'MovieOutcast Input' do
      f.input :avatar_url
      f.input :first_name
      f.input :last_name
      f.input :personal_details, as: :json
      f.input :status, as: :select, collection: MovieWritter.statuses.keys
    end
    f.actions
  end

  # or
  #
  # permit_params do
  #   permitted = [:avatar_url, :first_name, :last_name, :personal_details, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
