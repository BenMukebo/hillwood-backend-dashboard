ActiveAdmin.register Album do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :category, :photo_url, :released_date, :songs_counter, :content_details, :status, :video_link
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :category, :photo_url, :released_date, :songs_counter, :content_details, :status, :video_link]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
