require 'RMagick'
require 'rubygems'
include Magick


class IconsController < ApplicationController

  caches_page :index, :new

  # GET /icons
  # GET /icons.json
  def index
    @icons = Icon.find(:all, :limit=>20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @icons }
    end
  end

  # GET /icons/1
  # GET /icons/1.json
  def show
    @icon = Icon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @icon }
    end
  end

  # GET /icons/new
  # GET /icons/new.json
  def new

  end

  # GET /icons/1/edit
  def edit
    @icon = Icon.find(params[:id])
  end

  # POST /icons
  # POST /icons.json
  def create
    @icon = Icon.new(params[:icon])

    respond_to do |format|
      if @icon.save
        format.html { redirect_to @icon, :notice => 'Icon was successfully created.' }
        format.json { render :json => @icon, :status => :created, :location => @icon }
      else
        format.html { render :action => "new" }
        format.json { render :json => @icon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /icons/1
  # PUT /icons/1.json
  def update
    @icon = Icon.find(params[:id])

    respond_to do |format|
      if @icon.update_attributes(params[:icon])
        format.html { redirect_to @icon, :notice => 'Icon was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @icon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /icons/1
  # DELETE /icons/1.json
  def destroy
    @icon = Icon.find(params[:id])
    @icon.destroy

    respond_to do |format|
      format.html { redirect_to icons_url }
      format.json { head :ok }
    end
  end

   def generate_image(color,opacity)
    file_path = "public/images/icons/"+color+".gif"
    if FileTest.exists?(file_path)
      render :text => file_path
      return file_path
    else
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
      canvas.write file_path
      canvas.display
      return file_path
    end
 end

end
