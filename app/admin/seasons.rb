ActiveAdmin.register Season do
  menu parent: 'Series', priority: 1, label: 'Seasons', url: '/admin/seasons'
  # if: proc { current_admin_user.admin? }
  permit_params :title, :description, :image_url, :released_at, :status,
                :video_link_id, :episods_counter, :serie_id

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
      # ransackable_associations
      row :released_at
      row :status
      row :video_link
      row :episods_counter
      row :serie
      row :created_at
      row :updated_at
      table_for season.episodes.order('name ASC') do
        column 'episodes' do |episode|
          link_to episode.name, [:admin, episode] # TODO: Understand the :admin
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :image_url
      f.input :status
      f.input :video_link
      f.input :episods_counter
      f.input :serie
    end
    f.actions
  end

  filter :title
  filter :status
  filter :released_at
  filter :episods_counter
  filter :serie
  filter :created_at

  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :image_url, :status, :video_link_id, :episods_counter, :serie_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
