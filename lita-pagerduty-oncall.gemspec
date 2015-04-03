Gem::Specification.new do |spec|
  spec.name          = "lita-pagerduty-oncall"
  spec.version       = "0.0.2"
  spec.authors       = ["Ben Rockwood", "Garfield Carneiro"]
  spec.email         = ["gary.carneiro@gmail.com"]
  spec.description   = %q{Calls pager duty api to find who is oncall}
  spec.summary       = %q{Lita Pager Duty plugin}
  spec.homepage      = "https://github.com/GaryCarneiro/lita-pagerduty-oncall"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
end
