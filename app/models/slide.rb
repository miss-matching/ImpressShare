class Slide < ActiveRecord::Base
  belongs_to :user
  attr_accessible :command_options, :description, :github_url, :image_url, :kind, :markdown_content, :title,
    :identifier

  validates :identifier, presence: true, uniqueness: true

  KIND_GITHUB = '0'
  KIND_MARKDOWN = '1'

  def is_markdown_slide?
    self.kind == KIND_MARKDOWN
  end

  def is_github_slide?
    self.kind == KIND_GITHUB
  end

  def owner_dir_path
    master_dir = master_dir_path
    "#{master_dir}#{self.user_id}/"
  end

  def slide_dir_path
    "#{owner_dir_path}#{self.identifier}/"
  end

  def master_dir_path
    case self.kind
      when Slide::KIND_GITHUB then ImpressShareRails::Application.config.git_destination_directory_path
      when Slide::KIND_MARKDOWN then ImpressShareRails::Application.config.markdown_destination_directory_path
    end
  end

  def owner_working_path
    "tmp/#{ImpressShareRails::Application.config.markdown_work_directory_path}#{self.user_id}/"
  end
  def slide_working_file_path
    "#{owner_working_path}#{self.identifier}.md"
  end


end
