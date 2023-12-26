ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column 'Email Address', :email
    column :username
    column :phone_number
    column :age_group
    column :terms_of_service
    column :welcome_email_send
    column :role_id
    # column :location
    column :verification_status
    column :created_at
    column :confirmed_at
    column :last_sign_in_at
    actions
    # default_actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :created_at
    end
    active_admin_comments
  end

  belongs_to :role, optional: true
  permit_params :email, :username, :phone_number, :age_group, :terms_of_service, :welcome_email_send, :role_id,
                :verification_status, profile: %i[avatar_url first_name last_name sex phone_verified date_of_birth],
                                      location: %i[country state city zip_code address]

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
