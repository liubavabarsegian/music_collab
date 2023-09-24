json.extract! user, :id, :name, :surname, :birthday, :phone, :email, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
