ActiveAdmin.register MovieOutcast do
  permit_params :avatar_url, :first_name, :last_name, :personal_details, :status

  json_editor

  index do
    selectable_column
    id_column
    column :avatar_url do |movie_outcast|
      image_tag movie_outcast.avatar_url, width: 40, height: 40, class: 'movie_writter_avatar',
                                          alt: "#{movie_outcast.first_name} #{movie_outcast.last_name}", style: 'border-radius: 50%'
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
      row :avatar_url do |movie_outcast|
        if movie_outcast.avatar_url
          image_tag movie_outcast.avatar_url, width: 40, height: 40, class: 'movie_writter_avatar',
                                              alt: "#{movie_outcast.first_name} #{movie_outcast.last_name}"
        end
      end
      row :personal_details
      row :status
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'MovieOutcast Input' do
      f.input :first_name
      f.input :last_name
      f.input :avatar_url
      f.input :personal_details, as: :json
      f.input :status, as: :select, collection: MovieWritter.statuses.keys
    end
    f.actions
  end

  # or
  # permit_params do
  #   permitted = [:avatar_url, :first_name, :last_name, :personal_details, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
