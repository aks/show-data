Gem::Specification.new do |s|
  s.name = "show_data"
  s.version = "1.0.0"
  s.summary = 'Format or pretty-print Ruby data'
  s.description = <<-EOF
	Format or pretty-print Ruby data, including arrays, hashes, and structs.
	The keys ond values f the arrays and hashes are aligned for easy readability.
	Object attributes are similarly aligned.
	EOF
  s.author     = "Alan K. Stebbens"
  s.email      = 'aks@stebbens.org'
  s.license    = 'GPL'
  s.homepage   = 'https://github.com/aks/show-data'
  s.files      = ["lib/show_data.rb", 
		  'test/test_show_data.rb',
	          'GNU-LICENSE',
		  'README.md'
		 ]
  s.extra_rdoc_files = ['README.md']
  s.test_files = ['test/test_show_data.rb']

  #s.add_runtime_dependency 'somename', ['>= 1.1.0']
  #s.add_development_dependency 'name', [">= 0"]
end
