include SoManyDevices::DownloadsHelper

module Helpers
  def click_and_wait(button_name)
    click_button(button_name)
    wait_for_download
  end 

  def parse_file
    file = Yomu.new download
    file_text = file.text.tr("\n", "")
  end 

  def select2(values)
    values.each do |val|
      if page.has_no_css? '.select2-dropdown'   
        find('span.select2').click 
      end
      within(:css, '#select2-q_location_id_in-results') do 
        first('li.select2-results__option', text: val).click
      end 
    end
  end
end