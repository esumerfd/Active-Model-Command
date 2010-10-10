require 'rubygems'
require 'rake/gempackagetask'
require 'rake/clean'

CLOBBER.include('pkg')

task :default => [:rspec]

task :rspec do
  sh "rspec spec/*_spec.rb" rescue nil
end

gemspec = eval(File.read("active_model_command.gemspec"))
desc "Build the RubyGem for Active Model Command."
task :gem => [ :rspec ]
Rake::GemPackageTask.new(gemspec) do |g|
  g.need_tar    = true
  g.need_zip    = false
  g.package_dir = "pkg"
end
