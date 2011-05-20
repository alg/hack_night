AppConfig = YAML.load_file(File.join(Rails.root, 'config', 'config.yml'))
AppConfig.merge! YAML.load_file(File.join Rails.root, 'config', 'config.private.yml')

# Override config options by correct environment
env_options = AppConfig.delete(Rails.env)
AppConfig.merge!(env_options) unless env_options.nil?
