class User < ActiveRecord::Base
  #acts_as_authentic :crypto_provider => Authlogic::CryptoProviders::BCrypt,
  #                  :password_field_validates_length_of_options => { :on => :update, :if => :has_no_credentials? }
  
  #attr_accessible :login, :email, :password, :password_confirmation, :active
  
  validates_length_of :login, :within => 2..15
  
  has_many :snippets
  has_many :refactors
  has_many :votes
  has_many :voted_refactors, :through => :votes, :source => :refactor
  
  validates_uniqueness_of :login, :email
  
  named_scope :top_refactors, {
    :joins => ["INNER JOIN refactors ON refactors.user_id = users.id",
               "LEFT JOIN votes ON votes.refactor_id = refactors.id"],
    :order => "SUM(votes.score) DESC, users.login ASC"
  }
  
  #def is_admin?
  #  self.admin
  #end
  
  #def active?
  #  active
  #end
  
  def signup!(params)
    self.login = params[:user][:login]
    self.email = params[:user][:email]
  #  save_without_session_maintenance
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    UserNotifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    UserNotifier.deliver_activation_confirmation(self)
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserNotifier.deliver_password_reset_instructions(self)
  end
  
  def deliver_approved_snippet_notification!(snippet)
    UserNotifier.deliver_approved_snippet_notification(self, snippet)
  end

  def has_no_credentials?
    self.crypted_password.blank?
  end
  
  attr_accessor :password, :password_confirmation  
  
  validates_presence_of     :crypted_password
  validates_confirmation_of :password
  
  def password=(pass)
    @password = ::BCrypt::Password.create(pass)
    self.crypted_password = @password
  end
  
  def password
    @password ||= ::BCrypt::Password.new(crypted_password)
  end

  def unique_token
    Time.now.to_s + (1..10).collect{ rand.to_s }.join
  end
  
  def to_param
    self.login
  end
  
end
