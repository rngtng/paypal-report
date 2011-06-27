# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "paypal-report"
  s.version       = File.read("VERSION").to_s
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["SoundCloud", "Tobias Bielohlawek"]
  s.email         = %q{tobi@soundcloud.com}
  s.homepage      = "http://github.com/rngtng/paypal-report"
  s.summary       = %q{A little lightweight wrapper for Paypal's Report API.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  ['builder >=2.1.2'].each do |gem|
    s.add_dependency *gem.split(' ')
  end
end
