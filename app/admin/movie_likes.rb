ActiveAdmin.register MovieLike do
  menu parent: 'Movies', priority: 2, label: 'Movie Likes', url: '/admin/movie_likes'
  permit_params :movie_id, :user_id

  form do |f|
    f.inputs 'MovieLike Input' do
      f.input :movie
      f.input :user # TODO: let's use current_admin_user intead of userselecting a user
    end
    f.actions
  end

  # or
  #
  # permit_params do
  #   permitted = [:movie_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
