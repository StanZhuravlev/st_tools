$LOAD_PATH.unshift File.join(__dir__, *%w[.. lib])

require "st_tools/version"

require 'ruby-progressbar'
require 'yaml'
require 'i18n'

module StTools
  require "st_tools/common"
  require 'st_tools/system'
  require 'st_tools/human'
  require 'st_tools/fias'
  require 'st_tools/countries'
  require 'st_tools/string'
  require 'st_tools/progress_bar'

  require 'modules/string'
  require 'modules/integer'
  require 'modules/time'
  require 'modules/fias'

  # Use tutorial https://robots.thoughtbot.com/mygem-configure-block
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_reader :locale

    def initialize
      locale = :ru
    end

    def locale=(val)
      ::I18n.load_path += Dir[File.join(File.dirname(__dir__), '/lib/i18n/*.yml')]
      ::I18n.backend.load_translations
      case val.to_sym
        when :ru, :en
          @locale = val.to_sym
        else
          @locale = :ru
      end
    end
  end

  class Setup
    # Метод загрузки файлов локализации для методов форматирования времени. Принимает значения [:en, :ru]
    #
    # @param [Object] locale - язык локализации, поддерживается :ru, :en. Если передена неизвестная локализация
    #   по умолчанию будет использована :ru
    # @return [Object] нет
    def self.setup(locale)
      locale = :ru unless [:ru, :en].include?(locale)
      self.setup_locale(locale)
      warn "[DEPRECATION] setup is will deprecated."
    end

    private

    def self.setup_locale(locale)
      require 'i18n'
      ::I18n.load_path += Dir[File.dirname(File.expand_path(__FILE__)) + '/i18n/**/*.yml']
      ::I18n.backend.load_translations
      ::I18n.available_locales = [:ru, :en]
      ::I18n.locale = locale
      ::I18n.default_locale = locale
    end

  end
end
