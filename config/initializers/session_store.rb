# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ebooks_session',
  :secret      => '63f3757b9fc7fe750ac675732d90d528410bef2079dcabdf06f06ba8df06b0fcfddff582edfd240e4aa4c6674df62a21dd6fbbc89b4e7e010268bb8ddbe73253'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
