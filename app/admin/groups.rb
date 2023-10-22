ActiveAdmin.register Group do
  filter :id
  filter :name
  filter :leader
  filter :city
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :members_number, :country_id, :region_id, :city_id, :leader_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :members_number, :country_id, :region_id, :city_id, :leader_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
