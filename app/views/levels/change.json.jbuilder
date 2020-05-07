json.set! :user do
  json.set! :name, @user.name
  json.set! :email, @user.email
  json.set! :easy, @user.easy
  json.set! :medium, @user.medium
  json.set! :difficult, @user.difficult
end