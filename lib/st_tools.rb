$LOAD_PATH.unshift File.join(__dir__, *%w[.. lib])

require "st_tools/version"

require 'ruby-progressbar'

module StTools
  require 'st_tools/common'
  require 'st_tools/system'
  require 'st_tools/human'
  require 'st_tools/fias'
  require 'st_tools/string'
  require 'st_tools/progress_bar'

  require 'modules/string'
  require 'modules/integer'
  require 'modules/time'
  require 'modules/fias'

  class Setup

    def self.setup(locale)
      self.setup_locale(locale)
    end

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
