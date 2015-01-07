require 'reduce'

desc 'Publishing the website via rsync'
task :deploy do
  puts 'Publishing your website, silence is golden...'
  user = 'user'
  server = 'blog.lio.pw'
  path = '/var/www/blog.lio.pw/public_html'
  sh "rsync -rtzh --delete _site/ #{user}@#{server}:#{path}"
end

desc "Minify _site/"
task :minify do
  puts "\n## Compressing static assets"
  original = 0.0
  compressed = 0
  Dir.glob("_site/**/*.*") do |file|
    case File.extname(file)
      when ".css", ".html", ".js"
        puts "Processing: #{file}"
        original += File.size(file).to_f
        min = Reduce.reduce(file)
        File.open(file, "w") do |f|
          f.write(min)
        end
        compressed += File.size(file)
      else
        puts "Skipping: #{file}"
      end
  end
  puts "Total compression %0.2f\%" % (((original-compressed)/original)*100)
end