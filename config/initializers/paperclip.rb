rails_root = (defined?(Rails) ? Rails.root : RAILS_ROOT).to_s
Dir["#{rails_root}/lib/paperclip_processors/*.rb"].each{ |f| require f  }