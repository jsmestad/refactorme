# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_refactorme_session',
  :secret      => '58707204afd7c825100883a44c82935cbda2d2b1b604bc988bb241c28dc9fd32b19fa88c361baa2df93358007034efab140346c118bd6dcaacbaffdedd9510bf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
