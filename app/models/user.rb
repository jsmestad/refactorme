class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :snippets
  has_many :refactors
  has_many :votes
  
  validates_uniqueness_of :login, :email
  
  named_scope :top_refactors, {
    :joins => ["INNER JOIN refactors ON refactors.user_id = users.id",
               "LEFT JOIN votes ON votes.refactor_id = refactors.id"],
    #:group => "users.id",
    #:conditions => "ratable_rankings.deleted_at IS NULL",
    :order => "SUM(votes.score) DESC, users.login ASC"
  }
  
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
