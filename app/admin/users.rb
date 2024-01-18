ActiveAdmin.register User do
  json_editor

  index do
    selectable_column
    id_column
    column 'Profile Picture', :profile do |user|
      image_url = user.profile['avatar_url'].nil? ? 'https://via.placeholder.com/150' : user.profile['avatar_url']
      image_tag image_url, width: 40, height: 40, alt: user.username, class: 'user_avatar'
    end
    column 'Email Address', :email
    column :username
    column :phone_number
    column :age_group
    column 'Country', :location do |user|
      user.location['country'].nil? ? 'N/A' : user.location['country']
    end
    column :role
    column 'Verification', :verification_status
    actions defaults: false do |user|
      item 'View', admin_user_path(user), class: 'member_link'
      item 'Edit', edit_admin_user_path(user), class: 'member_link'
    end
  end

  show do
    attributes_table do
      row :username
      row :email
      row :phone_number
      row :age_group
      row 'Profile Picture', :profile do |user|
        image_url = user.profile['avatar_url'].nil? ? 'https://via.placeholder.com/150' : user.profile['avatar_url']
        image_tag image_url, width: 100, height: 70, alt: user.username, class: 'user_avatar'
      end
      row :terms_of_service
      row :welcome_email_send
      row :role
      row :verification_status
      row :profile, as: :json
      row :location, as: :json
      row :social_links, as: :json
      row :created_at
      row :confirmed_at
      row :last_sign_in_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :username
      if params[:action] == 'new' # Display password fields only on the create action
        f.input :password
        f.input :password_confirmation
      end
      f.input :phone_number
      f.input :age_group
      f.input :verification_status
      f.input :role
      f.input :welcome_email_send
      f.input :terms_of_service
      f.input :profile, as: :json
      f.input :location, as: :json
      f.input :social_links, as: :json
    end
    f.actions
  end

  filter :username
  filter :email
  filter :phone_number
  filter :age_group
  filter :verification_status
  filter :role
  filter :created_at

  # belongs_to :role, optional: true

  permit_params :email, :username, :password, :password_confirmation, :phone_number, :age_group, :terms_of_service,
                :welcome_email_send, :role_id, :verification_status,
                profile: %i[avatar_url first_name last_name sex phone_verified date_of_birth],
                location: %i[country state city zip_code address],
                social_links: %i[facebook twitter instagram youtube linkedin]

  # OR
  # permit_params do
  # permitted = [:provider, :uid, :encrypted_password, :reset_password_token, :reset_password_sent_at,
  # :allow_password_change, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at,
  # :unconfirmed_email, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
  # :last_sign_in_ip, :email, :username, :phone_number, :age_group, :terms_of_service, :remember_me,
  # :welcome_email_send, :tokens, :role_id, :profile, :location, :social_links, :verification_status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
