def sync_asset plugin_files, app_folder
  FileUtils.mkdir app_folder, :verbose => true unless File.exists? app_folder
  FileUtils.cp plugin_files, File.join(app_folder, ''), :verbose => true
end

current_path = File.dirname(__FILE__)

sync_asset Dir.glob(File.join(current_path, 'db', 'migrations', '*.rb')), File.join(RAILS_ROOT, 'db', 'migrate')
sync_asset Dir.glob(File.join(current_path, 'initializers', '*.rb')), File.join(RAILS_ROOT, 'config', 'initializers')
sync_asset Dir.glob(File.join(current_path, 'public', 'images', '*')), File.join(RAILS_ROOT, 'public', 'images', 'openid')
sync_asset Dir.glob(File.join(current_path, 'public', 'javascripts', '*')), File.join(RAILS_ROOT, 'public', 'javascripts', 'openid')
sync_asset Dir.glob(File.join(current_path, 'public', 'sass', '*')), File.join(RAILS_ROOT, 'public', 'stylesheets', 'sass')

puts "Okay for copying resources ...\n\n\n\n"

begin
  User
rescue NameError
  puts "Could not find User model, run this to set it up"
  puts "./script/generate scaffold user nickname:string openid:string email:string"
  puts "\n"
  puts "then run your migrations"
  puts "rake db:migrate"
  puts "\n"
end