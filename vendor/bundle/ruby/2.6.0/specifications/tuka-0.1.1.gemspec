# -*- encoding: utf-8 -*-
# stub: tuka 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "tuka".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["F".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-06-23"
  s.description = "Write a longer description or delete this line.".freeze
  s.email = ["fdelacruz.mail@gmail.com".freeze]
  s.executables = ["tuka".freeze]
  s.files = ["exe/tuka".freeze]
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Write a short summary, because RubyGems requires one.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<awesome_print>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<CFPropertyList>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<colored2>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<curb>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<lolcat>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<thor>.freeze, ["~> 0.20"])
      s.add_runtime_dependency(%q<whirly>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<xcodeproj>.freeze, ["~> 1.7.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    else
      s.add_dependency(%q<awesome_print>.freeze, [">= 0"])
      s.add_dependency(%q<CFPropertyList>.freeze, [">= 0"])
      s.add_dependency(%q<colored2>.freeze, [">= 0"])
      s.add_dependency(%q<curb>.freeze, [">= 0"])
      s.add_dependency(%q<lolcat>.freeze, [">= 0"])
      s.add_dependency(%q<thor>.freeze, ["~> 0.20"])
      s.add_dependency(%q<whirly>.freeze, [">= 0"])
      s.add_dependency(%q<xcodeproj>.freeze, ["~> 1.7.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<awesome_print>.freeze, [">= 0"])
    s.add_dependency(%q<CFPropertyList>.freeze, [">= 0"])
    s.add_dependency(%q<colored2>.freeze, [">= 0"])
    s.add_dependency(%q<curb>.freeze, [">= 0"])
    s.add_dependency(%q<lolcat>.freeze, [">= 0"])
    s.add_dependency(%q<thor>.freeze, ["~> 0.20"])
    s.add_dependency(%q<whirly>.freeze, [">= 0"])
    s.add_dependency(%q<xcodeproj>.freeze, ["~> 1.7.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  end
end
