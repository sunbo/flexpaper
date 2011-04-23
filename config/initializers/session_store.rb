# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_xxg_project_session',
  :secret      => 'a4e655f5e219423952bb7637f751743343d94d1e6647b85865baac845629164366218eed62e2d36623ba9266f8e10e2bc084eacf05a9396df8f3da03e1477a77'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
