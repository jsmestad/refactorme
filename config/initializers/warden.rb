Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :bcrypt
  manager.failure_app = SessionsController
end

# Setup Session Serialization
Warden::Manager.serialize_into_session{ |user| [user.class, user.id] }
Warden::Manager.serialize_from_session{ |klass, id| klass.find(id) }

Warden::Strategies.add(:bcrypt) do
  def valid?
    params[:username] || params[:password]
  end
  
  def authenticate!
    return fail! unless user = User.first(:username => params[:username])
    
    if user.crypted_password == params[:password]
      success!(user)
    else
      errors.add(:login, "Username or Password are incorrect.")
      fail!
    end
  end
end

