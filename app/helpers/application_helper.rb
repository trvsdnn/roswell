module ApplicationHelper

  def link_to_with_selected(name, path, options = {})
    if options[:pattern]
      path_regexp = options[:pattern]
    elsif options[:anchored]
      path_regexp = Regexp.new("\\A#{path}\\z", true)
      options.delete(:anchored)
    else
      path_regexp = Regexp.new("\\A#{path}", true)
    end

    selected = request.path =~ path_regexp

    if options.has_key?(:class) && selected
      options[:class] << ' selected'
    elsif selected
      options[:class] = 'selected'
    end

    link_to name, path, options
  end

  def active_class_if(path, options = {})
    if options[:anchored]
      path_regexp = Regexp.new("\\A#{path}\\z", true)
    else
      path_regexp = Regexp.new("\\A#{path}", true)
    end

    'class="active"'.html_safe if request.path =~ path_regexp
  end

  def fmt_datetime(datetime)
    datetime.nil? ? 'nil' : datetime.strftime('%b %e, %l:%M %p')
  end

end
