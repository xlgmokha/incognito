
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "incognito/version"

Gem::Specification.new do |spec|
  spec.name          = "incognito"
  spec.version       = Incognito::VERSION
  spec.authors       = ["mokha"]
  spec.email         = ["mo@mokhan.ca"]

  spec.summary       = %q{Anon.}
  spec.description   = %q{Anon.}
  spec.homepage      = "https://www.mokhan.ca"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "twilio-ruby", "~> 5.8"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
