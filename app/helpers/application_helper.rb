module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def awesome(icon, tip = nil)
    icon = "icon-#{icon}"
    if tip
      content_tag(:i, '', class: icon, data_tooltip: '', title: tip)
    else
      content_tag(:i, '', class: icon)
    end
  end

  # https://github.com/slim-template/slim/issues/151#issuecomment-15882033 
  def dom_attrs(record)
    { id: dom_id(record), class: dom_class(record) }
  end
end
