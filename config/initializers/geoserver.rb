config = YAML.load_file("#{Rails.root}/config/geoserver.yml")[Rails.env]
RESULTS_GEOSERVER_URL  = "#{config['host']}:#{config['port']}"
RESULTS_GEOSERVER_USER = config['username']
RESULTS_GEOSERVER_PASS = config['password']
