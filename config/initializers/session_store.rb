# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_vboxweb_rb_session',
  :secret      => '3c63a54655efb98191e402278a433b07e68fc3e5367b0b17ba738be6f51460ad670661907fbce6236bac92355f83d77dc4d5da7c05e872ec5a2741d2581bcafe'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
