json.extract! person, :id, :full_name, :email, :created_at, :updated_at
json.url person_url(person, format: :json)
