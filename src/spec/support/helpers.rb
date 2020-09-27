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
end