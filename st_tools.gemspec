# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'st_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "st_tools"
  spec.version       = StTools::VERSION
  spec.authors       = ["Stan Zhuravlev"]
  spec.email         = ["stan@post-api.ru"]

  spec.summary       = %q{Методы общего назначения}
  spec.description   = %q{Библиотека содержит функции, реализующие:
- преобразование строк с учетом русского языка
- формирования человеко-удобной информации
- получения разных системных характеристик CLI-приложений
- управление прогресс-баром CLI-приложений}
  spec.homepage      = "https://github.com/StanZhuravlev/st_tools"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  # http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/
  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files         = Dir.glob("{bin,lib,test}/**/*") + %w(LICENSE.txt README.md)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "lib/st_tools"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "ruby-progressbar", "~> 0"
  spec.add_development_dependency "i18n", "~> 0"
end
