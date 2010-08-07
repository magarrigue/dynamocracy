# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_octocracy_spike_session',
  :secret      => '7a2fdf71df5d7e7c9be7efc88d874e091c716e430d95e89486c6ec0533365513ada95244954b5e8e6a0de540006b04dfcb24d44952d1ec66b981eaf326154fae'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
