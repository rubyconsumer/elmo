require 'RMagick'
require 'rubygems'

class ImagesController < ApplicationController
  caches_page :index, :new

  # GET /images
  # GET /images.json
  def index
    @images = Image.find(:all,:limit =>20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @images }
    end
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
    generate_image('blue',0.75)
    @image = Image.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, :notice=> 'Image was successfully created.' }
        format.json { render :json=> @image, :status=> :created, :location=> @image }
      else
        format.html { render :action=> "new" }
        format.json { render :json=> @image.errors, :status=> :unprocessable_entity }
      end
    end
    expire_page :action => :index
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, :notice=> 'Image was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action=> "edit" }
        format.json { render :json=> @image.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :ok }
    end
 end
 def generate_image(color,opacity)
    canvas = Magick::ImageList.new
    canvas.new_image(250,250,Magick::HatchFill.new('white','gray90'))
    circle = Magick::Draw.new
    circle.stroke(color)
    circle.fill_opacity(0)
    circle.stroke_opacity(opacity)
    circle.stroke_width(3)
    circle.stroke_linecap('round')
    circle.stroke_linejoin('round')
    circle.ellipse(canvas.rows/2,canvas.columns/2,80,80,0,315)
    circle.polyline(180,70, 173,78, 190,78, 191,62)
    circle.draw(canvas)
    canvas.write(color+".gif")
    canvas.display
    exit
 end

end
