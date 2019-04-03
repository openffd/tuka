lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tuka/version'

Gem::Specification.new do |spec|
  spec.name          = 'tuka'
  spec.version       = Tuka::VERSION
  spec.authors       = ['F']
  spec.email         = ['fdelacruz.mail@gmail.com']
  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.license       = 'MIT'
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'CFPropertyList'
  spec.add_dependency 'colored2'
  spec.add_dependency 'lolcat'
  spec.add_dependency 'thor', '~> 0.20'
  spec.add_dependency 'xcodeproj', '~> 1.7.0'
end
