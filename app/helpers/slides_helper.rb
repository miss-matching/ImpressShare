#coding: utf-8
module SlidesHelper

  def convert_profile_image_url_to_the_origin_size( normal_size_image_url )
    return '' if normal_size_image_url.blank?
    normal_size_image_url.sub( "_normal","" )

  end

  def kind_options
    [ [ 'Github / Gist', Slide::KIND_GITHUB ],
      [ 'Markdown',Slide::KIND_MARKDOWN]]
  end

  def path_for_iframe( slide )
    "#{root_path}#{slide.slide_dir_path}index.html"
  end

  def sign_for_slide_kind( slide )
    { Slide::KIND_GITHUB => 'github',
      Slide::KIND_MARKDOWN => 'markdown'}[slide.kind]
  end

  def sign_for_slide_kind_class( slide )
    { Slide::KIND_GITHUB => 'icon-github',
      Slide::KIND_MARKDOWN => 'icon-circle-arrow-down'}[slide.kind]
  end

end
