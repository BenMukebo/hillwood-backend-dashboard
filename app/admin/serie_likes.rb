ActiveAdmin.register SerieLike do
  menu parent: 'Series', priority: 2
  permit_params :serie_id, :user_id

  form do |f|
    f.inputs 'SerieLike Input' do
      f.input :serie
      f.input :user
    end
    f.actions
  end

  # permit_params do
  #   permitted = [:serie_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
