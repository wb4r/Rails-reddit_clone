class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
    
  # has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  # before_save :generate_slug!
  # after_validation would be the same
  # in this case if the user changes the title the url will also changes
  # that is very bad for bookmarking, if you dont want that, instead of 
  # before_save u have to use before_create and it wont change no matter
  # the title

  # def total_votes
  #   self.votes.where(vote: true).size - self.votes.where(vote: false).size
  # end

  sluggable_column :title

  # def to_param
  #   self.slug
  # end

  # def generate_slug!
  #   the_slug = to_slug(self.title)
  #   post = Post.find_by slug: the_slug
  #   counter = 2

  #   while post && post != self 
  #     the_slug = append_suffix(the_slug, counter)
  #     post = Post.find_by slug: the_slug
  #     counter += 1
  #   end
  #   self.slug = the_slug.downcase
  # end

  # def append_suffix(str, ctr)
  #   if str.split('-').last.to_i != 0
  #     return str.split('-').slice(0...-1).join('-') + '-' + ctr.to_s
  #   else
  #     return str + "-" + ctr.to_s
  #   end    
  # end

  # def to_slug(name)
  #   str = name.strip
  #   str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
  #   str.gsub! /-+/, "-" 
  #   str.downcase
  # end
end





