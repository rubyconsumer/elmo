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
      image_url = generate_image("#" + params[:color])
      response.headers['Content-Type'] = 'image/gif'
      response.headers['Content-Disposition'] = 'inline'
      render :text => open(image_url).read        
      
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

   def generate_image(color)          
     Rails.logger.debug("GENERATING IMAGE")
    file_path = "public/images/icons/"+color+".png"
    if !FileTest.exists?(file_path)
      marker = Magick::Image.read("public/images/icons/marker.png")
      colored = marker[0].color_floodfill(10, 10, color)     
      colored.write(file_path)
    end                     
    return file_path
 end

end
