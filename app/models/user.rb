class User < ActiveRecord::Base
  # ============================================================
  # Validations for faking :bcrypt from AuthLogic with Warden
  attr_accessor :password, :password_confirmation  
  validates_presence_of     :crypted_password, :on => :update,  :if => :has_no_credentials?
  validates_confirmation_of :password, :if => :password
  
  validates_uniqueness_of :perishable_token, :if => :perishable_token_changed?
  before_save :reset_perishable_token
  
  # ============================================================  
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
  
  def is_admin?
   self.admin
  end
  
  def active?
   active
  end
  
  def signup!(params)
    self.login = params[:user][:login]
    self.email = params[:user][:email]
    save
  #  save_without_session_maintenance
  end
  
  # ============================================================
  # Methods from or faking AuthLogic for Warden
  def password=(pass)
    @password = pass
    unless pass.blank?
      self.crypted_password =  pass.nil? ? nil : ::BCrypt::Password.create("#{pass}#{password_salt}", :cost => 10)
    end
    @password
  end
  
  def crypted_password
    @crypted_password ||= begin
      ep = read_attribute(:crypted_password)
      ep.nil? ? nil : ::BCrypt::Password.new(ep)
    end
  end
  
  def password_salt
    @password_salt ||= begin
      pws = read_attribute(:password_salt)
      pws.nil? ? write_attribute(:password_salt, Digest::SHA512.hexdigest(unique_token)) : pws
    end
  end
  
  def has_no_credentials?
    self.crypted_password.blank?
  end
  
  def unique_token
    Time.now.to_s + (1..10).collect{ rand.to_s }.join
  end
  
  # Resets the perishable token to a random friendly token.
  def reset_perishable_token
    self.perishable_token = ::ActiveSupport::SecureRandom.base64(15).tr("+/=", "-_").strip.delete("\n")
  end
  
  # Same as reset_perishable_token, but then saves the record afterwards.
  def reset_perishable_token!
    reset_perishable_token
    save(false)
  end
  
  def self.find_using_perishable_token(token, age = 1.week)
    find(:first, :conditions => ["perishable_token = ? AND updated_at > ?", token, age])    
  end
  # ============================================================
  
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
  
  def to_param
    self.login
  end
  
end
