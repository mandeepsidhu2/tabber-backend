json.set! :user do
  json.set! :id, @user.id
  json.set! :name, @user.name
  json.set! :email, @user.email
  json.set! :easy, @varEasy
  json.set! :medium, @varMedium
  json.set! :difficult, @varDifficult
end