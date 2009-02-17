class User < ActiveRecord::Base
  include BCrypt

  def password
    @password ||= Password.new(crypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.crypted_password = @password
  end
end
