json.set! :user do
  json.set! :name, @user.name
  json.set! :email, @user.email
  json.set! :token, @token
end