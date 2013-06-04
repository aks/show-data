# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "show_data"
  gem.homepage = "http://github.com/aks/show_data"
  gem.license = "MIT"
  gem.summary = 'Format or pretty-print Ruby data'
  gem.description = <<-EOF
	Format or pretty-print Ruby data, including arrays, hashes, and structs.
	The keys ond values f the arrays and hashes are aligned for easy readability.
	Object attributes are similarly aligned.
	EOF
  gem.email = "aks@stebbens.org"
  gem.authors = ["Alan Stebbens"]
  gem.files   = ["lib/show_data.rb", 
		 'test/test_show_data.rb',
	         'LICENSE.txt',
		 'README.md'
		]
  gem.extra_rdoc_files = ['README.md']
  gem.test_files = ['test/test_show_data.rb']
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "show_data #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
