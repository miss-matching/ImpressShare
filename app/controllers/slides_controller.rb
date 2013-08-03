#coding: utf-8
class SlidesController < ApplicationController
  before_filter :login_required, only: ['create', 'new', 'edit', 'update', 'destroy' ]


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
  def show
    @slide = Slide.find(params[:id])

    respond_to do |format|
      format.html do
        if needs_git_clone? 
          # TODO: ここはパラレルを考えないとだめ
          SlideFileProc.git_clone_with_refresh(@slide)
        end
        if needs_markdown2impress? 
          # TODO: ここはパラレルを考えないとだめ
          SlideFileProc.markdown2impress(@slide)
        end

      end# show.html.erb
      format.json { render json: @slide }
    end
  end



  def preview

    @slide = Slide.find_by_identifier( params[:id])
    slide_path = SlideFileProc.markdown2impress_from_content( params[:content] )

    #slide_path = "/markdown/1/wawa/index.html"
    status = 'ok'

    render json: { slide_path: slide_path, status: status }

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
    @slide = Slide.find(params[:id])
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
    @slide = Slide.find(params[:id])

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
    @slide = Slide.find(params[:id])
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
end
