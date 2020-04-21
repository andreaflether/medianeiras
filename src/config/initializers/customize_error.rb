ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = ''
  form_fields = %w(textarea input select)
  tag_elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')

  tag_elements.each do |e|

    if e.node_name.eql? 'label'
      html = %(#{e}).html_safe
    elsif form_fields.include? e.node_name
      e['class'] = %(#{e['class']} is-invalid)
      e['style'] = %(border-right: 1px solid #dc3545 !important;)
      if instance.error_message.kind_of?(Array)
        field_error_message = instance.error_message.uniq.join(', ')
      else
        field_error_message = instance.error_message
      end
      html = %(#{e}<script>$(document).ready(function(){
      $('##{e['id']}').closest('.input-group').removeClass('mb-3').after('<span class="invalid-feedback d-inline-block mt-1 mb-3">#{field_error_message}</span>');
      });</script>).html_safe
    end
  end

  html

end
