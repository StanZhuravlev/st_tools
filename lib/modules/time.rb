module StTools
  module Module
    module Time

      def human_date
        ::StTools::Human.format_time(self, :date)
      end

      def human_time
        ::StTools::Human.format_time(self, :time)
      end

      def human_datetime
        ::StTools::Human.format_time(self, :full)
      end

      def human_ago(ago = true)
        ::StTools::Human.ago_in_words(self, ago)
      end

    end
  end
end
