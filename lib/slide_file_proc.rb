#coding: utf-8
# ----------------------------- 
# とりあえずファイルの操作は
# ここに閉じ込めておこう
# ----------------------------- 
module SlideFileProc

  def missing_slide_file?( slide )
    return !File.exists?("#{slide_file_dir_path(slide)}index.html")
  end

  def slide_file_dir_path( slide )
    slide_path = "public/#{slide.slide_dir_path}"
  end

  def owner_dir_path( slide )
    user_path = "public/#{slide.owner_dir_path}" 
  end

  def git_clone_with_refresh( slide )
    raise 'damedame' unless slide.is_github_slide?
    raise 'user_id無しってちょっと' unless slide.user_id.present?

    # generate path for git clone
    user_path = owner_dir_path( slide )
    slide_path = slide_file_dir_path( slide )
    system("rm -rf #{slide_path}")

    # clean up the directory
    Dir::mkdir( user_path ) unless File.exists?( user_path )
    system( "rm -rf #{slide_path}" ) if File.exists?( slide_path )

    # execute git clone
    p "start git clone #{Time.now}"
    system( "git clone #{slide.github_url} #{slide_path}" ) 
    p "complete git clone #{Time.now}"

  end

  def markdown2impress( slide )
    raise 'akann!' unless slide.is_markdown_slide?

    # create working dir
    Dir::mkdir( slide.owner_working_path ) unless File.exists?( slide.owner_working_path )
    working_file = slide.slide_working_file_path + Time.now.strftime("%s") + rand.to_s

    system( "rm #{working_file}" )

    # write down markdown to working file
    foo = File.open(working_file,'w')
    foo.puts slide.markdown_content
    foo.close

    # generate path for git clone
    user_path = owner_dir_path( slide )
    slide_path = slide_file_dir_path( slide )

    Dir::mkdir( user_path ) unless File.exists?( user_path )
    Dir::mkdir( slide_path ) unless File.exists?( slide_path )

    # kick the markdown
    system("markdown2impress.pl #{working_file} --outputdir=#{slide_path}")

    # delete working file
    system( "rm #{working_file}" )

  end

  def markdown2impress_from_content( content )


    master_preview_wrk_path = ImpressShareRails::Application.config.preview_work_path
    preview_wrk_path = master_preview_wrk_path + UUIDTools::UUID.random_create + "/"
    work_file_name = Time.now.strftime("%s") + rand.to_s
    working_file = preview_wrk_path + work_file_name

    # write down markdown to working file
    Dir::mkdir( preview_wrk_path ) unless File.exists?( preview_wrk_path )
    foo = File.open(working_file,'w')
    foo.puts content
    foo.close



    master_preview_path = ImpressShareRails::Application.config.preview_path
    preview_path = master_preview_path + UUIDTools::UUID.random_create + "/"
    preview_dir_path = "public/#{preview_path}"

    Dir::mkdir( preview_dir_path ) unless File.exists?( preview_dir_path )

    # kick the markdown
    system("markdown2impress.pl #{working_file} --outputdir=#{preview_dir_path}")

    # delete working file
    # TODO
    system( "find #{master_preview_path} -mmin -5 -ls" )
    
    "/" + preview_path + "index.html"


  end

  module_function :git_clone_with_refresh
  module_function :owner_dir_path
  module_function :slide_file_dir_path
  module_function :missing_slide_file?
  module_function :markdown2impress
  module_function :markdown2impress_from_content

end
