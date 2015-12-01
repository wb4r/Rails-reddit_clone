class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  validates :username, presence: true, uniqueness: true, length: {minimum: 3}
  validates :password, presence: true, on: :create, length: {minimum: 6}
  has_secure_password validations: false

  before_save :generate_slug!

  sluggable_column :username

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) #random 6digit number
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_twilio    
    # put your own credentials here 
    account_sid = 'ACc8d3f477ed67d4e39d75d1daed5ffb80' 
    auth_token = '94e865b0e795df730909795b370bd03e' 

    # client = Twilio::REST::Client.new(account_sid, auth_token)

    # account = client.account
    # message = account.sms.messages.create({:from => "+441334303026", :to => "+447599069201", :body => "please enter #{self.pin}"})

    from_number = "+441334303026"
    to_number = "+447599069201"

    begin
    # binding.pry
    client = Twilio::REST::Client.new account_sid, auth_token
    client.account.messages.create(
      :from => "+441334303026",
      :to =>   self.phone,
      :body => self.pin
    )   
    end

    # # set up a client to talk to the Twilio REST API 
    # client = Twilio::REST::Client.new account_sid, auth_token 
     
    # client.account.messages.create({
    #   :from => '+441334303026', 
    #   :to => '#{self.phone}' #'07599069201', 
    #   :body => '#{self.pin}' #'hi there',  
    # })
  end
end


  # def to_param
  #   self.slug    
  # end

  # def generate_slug!
  #   the_slug = to_slug(self.username)
  #   user = User.find_by slug: the_slug
  #   counter = 2

  #   while user && user != self 
  #     the_slug = append_suffix(the_slug, counter)
  #     user = User.find_by slug: the_slug
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



