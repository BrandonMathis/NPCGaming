# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def navigation_menu
    content_tag(:ul, id: 'menu')do
      menu_items.collect do |text, url|
        concat(content_tag(:li, link_to(text, url), class: active_tab(url)? 'active' : nil))
      end
    end
  end

  def active_tab(url)
    request.fullpath =~ /^#{url}/ ||
    (url == content_posts_path && request.fullpath == '/')
  end

  def nav_pill(name, path)
    haml_tag :li, :class => "#{'active' if request.fullpath == path}" do
      haml_tag link_to name, path
    end
  end

  def menu_items
    [
      [ 'Posts', content_posts_path ],
      [ 'Archive', post_archive_path]
    ]
  end
end
