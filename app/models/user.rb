class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :snippets
  has_many :refactors
  
  validates_uniqueness_of :login, :email
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
  def is_admin?
    !!self.admin
  end
  
  def to_param
    login
  end
  
end
