Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :bcrypt
  manager.failure_app = SessionsController
end

# Setup Session Serialization
Warden::Manager.serialize_into_session{ |user| [user.class, user.id] }
Warden::Manager.serialize_from_session{ |klass, id| klass.find(id) }

Warden::Strategies.add(:bcrypt) do
  def valid?
    true
  end

  def authenticate!
    return fail! unless user = User.find_by_login(params['session']['login'])
    hash = params['session']['password'] 

    hash << user.password_salt unless user.password_salt.nil?
    if user.password == hash 
      success!(user)
    else
      errors.add(:login, "Username or Password are incorrect.")
      fail!
    end
  end
end

