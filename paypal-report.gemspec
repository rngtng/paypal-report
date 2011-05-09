# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "paypal-report/version"

Gem::Specification.new do |s|
  s.name        = "paypal-report"
  s.version     = File.read("VERSION").to_s
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["SoundCloud", "Tobias Bielohlawek"]
  s.email       = %q{tobi@soundcloud.com}    
  s.homepage    = "http://github.com/rngtng/paypal-report"
  s.summary     = %q{Lightweight wrapper for Paypal's Report API.}
  s.description = %q{TODO: Write a gem description}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
