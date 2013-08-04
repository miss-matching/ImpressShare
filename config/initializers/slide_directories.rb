markdown_destination_dir = 'public/' +  ImpressShareRails::Application.config.markdown_destination_directory_path
git_slide_destination_dir = 'public/' +  ImpressShareRails::Application.config.git_destination_directory_path
preview_dir = 'public/' +  ImpressShareRails::Application.config.preview_path

Dir::mkdir( markdown_destination_dir ) unless File.exists?( markdown_destination_dir )
Dir::mkdir( git_slide_destination_dir ) unless File.exists?( git_slide_destination_dir )
Dir::mkdir( preview_dir ) unless File.exists?( preview_dir )

markdown_work_dir = ImpressShareRails::Application.config.preview_work_path
Dir::mkdir( markdown_work_dir ) unless File.exists?( markdown_work_dir )







