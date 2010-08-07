
Factory.define :user  do |u|
  u.email 'joe@tlfj.com'
  u.nickname 'joe'
end

Factory.define :proposal do |p|
  p.text "Superbe proposition assez longue pour avoir un sens"
  p.user_id Factory(:user).id
end

Factory.define :vote do |v|
  v.value 'yes'
  v.voter_id Factory(:user).id
  v.association :proposal, :factory => :proposal
end
