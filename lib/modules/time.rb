module StTools
  module Module
    module Time

      def human_date(type = :full)
        ::StTools::Human.format_time(self, :date, type)
      end

      def human_time(type = :full)
        ::StTools::Human.format_time(self, :time, type)
      end

      def human_datetime(type = :full)
        ::StTools::Human.format_time(self, :full, type)
      end

      def human_ago(ago = true)
        ::StTools::Human.ago_in_words(self, ago)
      end

    end
  end
end
