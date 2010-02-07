# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_vboxweb_rb_session',
  :secret => 'b5b97ded2aa3eb5c82c07997e8ecb10aa367ef579337f9f1c7f452240325f3006baa6306b6e54ad5eff96c4fe946a7950cf47d42984a17bfdd3646d1ec22a47e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
