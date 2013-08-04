#coding: utf-8
class SlidesController < ApplicationController
  before_filter :login_required, only: ['create', 'new', 'edit', 'update', 'destroy' ]
  before_filter :default_fetch
  before_filter :login_required_strict, only: [ :edit ]


  # GET /slides
  # GET /slides.json
  def index
    @slides = Slide.includes( :user ).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end

  # GET /slides/1
  # GET /slides/1.json
  def presentation

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide }
    end

  end
  # GET /slides/1
  # GET /slides/1.json
  def show

    respond_to do |format|
      format.html do
        if needs_git_clone? 
          SlideFileProc.git_clone_with_refresh(@slide)
        end
        if needs_markdown2impress? 
          SlideFileProc.markdown2impress(@slide)
        end

      end# show.html.erb
      format.json { render json: @slide }
    end
  end



  # POST /slides/preview
  # params
  #   content   : markdownの文字列  
  #   location  : iframeのlocation.hrefの中身
  def preview

    preview_dir_name = params[:location].
      sub( root_url + "preview/" , "" ).
      sub( /\/\#.*/ , "" ).
      sub(/\/index.*/, "")  if params[:location] && params[:location] != root_url + "dummy_slide.html"
    page_uri = params[:location].scan( /\#.*/ )

    slide_path = SlideFileProc.markdown2impress_from_content(  { preview_dir_name: preview_dir_name, content: params[:content]} )
    page = "#{slide_path}/#{page_uri[0]}" if page_uri.present?

    render json: { slide_path: slide_path, page: page }

  end


  # GET /slides/new
  # GET /slides/new.json
  def new
    @slide = Slide.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/1/edit
  def edit
  end

  # POST /slides
  # POST /slides.json
  def create
    @slide = Slide.new(params[:slide])
    @slide.user_id = @current_user.id


    respond_to do |format|
      if @slide.save

        if @slide.is_github_slide?
          SlideFileProc.git_clone_with_refresh( @slide )
        end

        if @slide.is_markdown_slide?
          SlideFileProc.markdown2impress( @slide )
        end

        format.html { redirect_to @slide, notice: 'Slide was successfully created.' }
        format.json { render json: @slide, status: :created, location: @slide }
      else
        format.html { render action: "new" }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slides/1
  # PUT /slides/1.json
  def update

    respond_to do |format|
      if @slide.update_attributes(params[:slide])

        if @slide.is_github_slide?
          SlideFileProc.git_clone_with_refresh( @slide )
        end
        if @slide.is_markdown_slide?
          SlideFileProc.markdown2impress( @slide )
        end
        format.html { redirect_to @slide, notice: 'Slide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide.destroy

    respond_to do |format|
      format.html { redirect_to slides_url }
      format.json { head :no_content }
    end
  end

  private
  def needs_git_clone?
    @slide.is_github_slide? && SlideFileProc.missing_slide_file?(@slide)
  end
  def needs_markdown2impress?
    @slide.is_markdown_slide? && SlideFileProc.missing_slide_file?(@slide)
  end



  def default_fetch
    @slide = Slide.find( params[:id] ) if params[:id].present?
  end
  def login_required_strict
    raise StandardError.new( 'さわらないで' ) if  @slide.user_id != @current_user.id 
  end


end
