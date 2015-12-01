class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true

  # TEMPORARY DISABLED FOR DEVELOPMENT
  # validates_uniqueness_of :creator, scope: [:voteable_id, :voteable_type]
end