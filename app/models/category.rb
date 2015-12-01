class Category < ActiveRecord::Base
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: {minimum: 3}

  before_save :generate_slug!

  sluggable_column :name

  # def to_param
  #   self.slug
  # end

  # def generate_slug!
  #   the_slug = to_slug(self.name)
  #   cat = Category.find_by slug: the_slug
  #   counter = 2

  #   while cat && cat != self 
  #     the_slug = append_suffix(the_slug, counter)
  #     cat = Category.find_by slug: the_slug
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