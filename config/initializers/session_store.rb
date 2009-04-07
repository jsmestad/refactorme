# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_refactor_me_session',
  :secret      => 'd39e01721bd6e927455de42fb0145f551d1fbd2eb30fc22cc6cdc377390406671ae4cc53c3c316ee0950df12531130bebf9dbb9ca0edf2f8011750ff7ef1690f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :cookie_store
