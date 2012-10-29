module Roswell
  module ApplicationHelpers

    def title(page_title)
      content_for(:title) { page_title }
    end

    def description(desc)
      content_for(:description) { desc }
    end

  end
end