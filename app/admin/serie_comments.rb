ActiveAdmin.register SerieComment do
  menu parent: 'Series', priority: 2
  permit_params :text, :likes_counter, :serie_id, :user_id

  index do
    selectable_column
    id_column
    column :text
    column 'Comment Likes', :likes_counter
    column :serie
    column :user
    actions
  end

  show do
    attributes_table do
      row :text
      row :likes_counter
      row :serie
      row :user
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'SerieComment Input' do
      f.input :text
      f.input :serie
      f.input :user
    end
    f.actions
  end

  filter :serie
  filter :user
  filter :created_at

  # permit_params do
  #   permitted = [:text, :likes_counter, :serie_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
