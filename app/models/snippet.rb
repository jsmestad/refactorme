class Snippet < ActiveRecord::Base
  acts_as_list
  
  def approve!
    add_to_list
  end
  
  def reject!
    return self.destroy ? true : false
  end
  
end
