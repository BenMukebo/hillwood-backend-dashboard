ActiveAdmin.register Artist do
  config.per_page = 10
  json_editor
  permit_params :avatar_url, :first_name, :last_name, :date_of_birth, :personal_details, :status

  index do
    selectable_column
    id_column
    column :avatar_url do |artist|
      image_url = artist.avatar_url.nil? ? 'https://via.placeholder.com/150' : artist.avatar_url
      image_tag image_url, alt: "#{artist.first_name} #{artist.last_name}",
                           width: 50, height: 30, style: 'border-radius: 2px'
    end
    column :first_name
    column :last_name
    column :status

    actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :date_of_birth
      row :avatar_url do |artist|
        image_tag artist.avatar_url, width: 100, height: 70, style: 'border-radius: 2px'
      end

      row :personal_details
      row :status
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  form do |f|
    f.inputs 'Artist Details' do
      f.input :first_name
      f.input :last_name
      f.input :avatar_url
      f.input :date_of_birth
      f.input :personal_details, as: :json
      f.input :status
      # f.input :avatar_url, as: :file, input_html: { accept: 'image/*' }
    end

    f.actions
  end

  filter :first_name
  filter :last_name
  filter :status
  filter :date_of_birth

  #
  # permit_params do
  #   permitted = [:avatar_url, :first_name, :last_name, :date_of_birth, :personal_details, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
