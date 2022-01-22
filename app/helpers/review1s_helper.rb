module Review1sHelper
      def current_book
          @current_book ||= Book.find_by(title: :title)
  end
end
