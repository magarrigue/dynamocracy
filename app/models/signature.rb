class Signature < ActiveRecord::Base
  belongs_to :proposal, :counter_cache => true
end
