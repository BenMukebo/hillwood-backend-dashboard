ActiveAdmin.register MovieComment do
  permit_params :text, :likes_counter, :movie_id, :user_id

  index do
    selectable_column
    id_column
    column :text
    column 'Comment Likes', :likes_counter
    column :movie
    column :user
    actions
  end

  show do
    attributes_table do
      row :text
      row :likes_counter
      row :movie
      row :user
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'MovieComment Input' do
      f.input :text
      # f.input :likes_counter
      f.input :movie
      f.input :user # TODO: let's use current_admin_user intead of userselecting a user
    end
    f.actions
  end

  # or
  #
  # permit_params do
  #   permitted = [:text, :likes_counter, :movie_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
