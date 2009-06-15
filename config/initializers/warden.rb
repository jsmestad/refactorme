Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :my_strategy
  manager.failure_app = LoginController
end

# Setup Session Serialization
Warden::Manager.serialize_into_session{ |user| [user.class, user.id] }
Warden::Manager.serialize_from_session{ |klass, id| klass.find(id) }

# Declare your strategies here
#Warden::Strategies.add(:my_strategy) do
#  def authenticate!
#    # do stuff
#  end
#end

