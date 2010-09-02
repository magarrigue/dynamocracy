
#Factory.define :user  do |u|
#  u.email 'joe@tlfj.com'
##  u.nickname 'joe'
#  u.password 'password'
##  u.password_confirmation 'password'
#end


Factory.define :user do |f|
 f.sequence(:email) {|n| "#{n}author@example.com"}
 f.password "password"
 f.password_confirmation "password"
 f.confirmation_token "confirmation{n}"
 f.reset_password_token  "reset_pasword_token"
 f.encrypted_password  "password" 
 f.password_salt  "password" 
end


Factory.define :crew do |v|
  v.name "a new crew"
  v.creator_id Factory(:user).id
end

Factory.define :proposal do |p|
  p.text "Superbe proposition assez longue pour avoir un sens"
  p.association :user, :factory => :user
  p.association :crew, :factory => :crew
end

Factory.define :vote do |v|
  v.value 'yes'
  v.voter_id Factory(:user).id
  v.association :proposal, :factory => :proposal
end


