# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Exclude all files starting with '_' but explicitly register the extensions we are interested in compiling
config.assets.precompile.shift
precompile_path = Proc.new do |path|
  path.match(%r((^[^_\/]|\/[^_])[^\/]*$)) &&
    File.extname(path).in?([
      '.png', '.gif', '.jpg', '.jpeg', '.svg', '.ico', '.cur', '.xcf', # Images
      '.js', '.css' # Plain old JS/CSS
    ])
end
config.assets.precompile.push(precompile_path)
