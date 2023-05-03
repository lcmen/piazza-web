ActionView::Base.field_error_proc = lambda do |html_tag, instance|
  return html_tag if html_tag =~ /^<label/

  html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
  html.children.add_class('is-danger')
  html_tag = html.to_s
  error_tag = "<p class='help is-danger'>#{instance.error_message.to_sentence}</p>"

  "#{html_tag}#{error_tag}".html_safe
end
