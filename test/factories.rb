
#Factory.define :user  do |u|
#  u.email 'joe@tlfj.com'
##  u.nickname 'joe'
#  u.password 'password'
##  u.password_confirmation 'password'
#end


Factory.define :user do |f|
 f.sequence(:email) {|n| "author#{n}@example.com"}
 f.password "password"
 f.password_confirmation "password"
 f.sequence(:confirmation_token){|n| "confirmation#{n}"}
 f.reset_password_token  "reset_pasword_token"
 f.encrypted_password  "password" 
 f.password_salt  "password" 
end


Factory.define :crew do |c|
  c.name "a new crew"
  c.creator_id {Factory.create(:user).id}
end


Factory.define :membership do |m|
  m.role "officer"
  m.user_id Factory(:user).id
  m.crew_id Factory(:crew).id
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


