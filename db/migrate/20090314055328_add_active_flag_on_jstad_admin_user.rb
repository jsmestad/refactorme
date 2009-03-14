class AddActiveFlagOnJstadAdminUser < ActiveRecord::Migration
  def self.up
    @user = User.find_by_login!('jstad')
    @user.active = true
    @user.save
  end

  def self.down
    @user = User.find_by_login!('jstad')
    @user.active = false
    @user.save
  end
end
