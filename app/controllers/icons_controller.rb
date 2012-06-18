class IconsController < ApplicationController

  caches_page :index, :new

  def show
      image_url = generate_image("#" + params[:color])
      response.headers['Content-Type'] = 'image/gif'
      response.headers['Content-Disposition'] = 'inline'
      render :text => open(image_url).read        
      
  end
  def generate_image(color)
    file_path = "tmp/icons/"+color+".png"
    if !FileTest.exists?(file_path)
      marker = Magick::Image.read("public/images/icons/marker.png")
      colored = marker[0].color_floodfill(5, 5, color)     
      colored.write(file_path)
    end                     
    return file_path
 end

end
