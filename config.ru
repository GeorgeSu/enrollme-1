config_file =  File.expand_path('../../config/application.yml', __FILE__)
if File.exist?(config_file)
  APPLICATION_CONFIG=YAML.load_file(config_file)[Rails.env]['application']
  CONSTANTS=YAML.load_file(config_file)[Rails.env]['constants']
  APPLICATION_CONFIG.each{|k,v| ENV["APPLICATION_CONFIG_#{k}"] = v.to_s }
  CONSTANTS.each{|k,v| ENV["CONSTANTS_#{k}"] = v.to_s}
end