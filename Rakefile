desc 'Publishing the website via rsync'
task :deploy do
  puts 'Publishing your website, silence is golden...'
  user = 'user'
  server = 'blog.lio.pw'
  path = '/var/www/blog.lio.pw/public_html'
  sh "rsync -rtzh --delete _site/ #{user}@#{server}:#{path}"
end