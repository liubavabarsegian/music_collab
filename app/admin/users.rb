ActiveAdmin.register User do
  filter :id
  filter :email
  filter :name
  filter :surname
  filter :has_concert_experience
  filter :career_start_year
  filter :city

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :name, :surname, :birthday, :country_id, :region_id, :city_id, :career_start_year, :has_concert_experience
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :name, :surname, :birthday, :country_id, :region_id, :city_id, :career_start_year, :has_concert_experience]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    column :id
    column :name
    column :surname
    column :email
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :surname
      row :birthday
      row :desktop_text
      row :country
      row :region
      row :city
      row :career_start_year
      row :has_concert_experience
      row :created_at
      row :updated_at
    end
  end
end
