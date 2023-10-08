json.extract! user, :id, :name, :surname, :birthday, :created_at, :updated_at
json.url user_url(user, format: :json)
