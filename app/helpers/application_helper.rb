module ApplicationHelper
  include TagsHelper

  def if_admin?
    yield if current_user && current_user.has_role?('admin')
  end
  
  def main_tab_for(name, options = {})
      link_to_unless_current(name, options) do
        "<li class=\"active\"><strong>#{name}</strong></li>"
      end
  end

  def first_item(index)
    index == 0 ? '.item.first' : '.item'
  end
  
  def navigation(*links)
      items = []
      links.each do |link|
        if (controller.controller_name.to_sym == link)
          items << content_tag(:li, "<strong>#{link.to_s}</strong>", :class => "active")
        else
          items << content_tag(:li, link_to("#{link.to_s}", link))
        end
      end
      content_tag :ul, items
  end   

end
