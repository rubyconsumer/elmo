class IconsController < ApplicationController

  caches_page :index, :new

  def show
      image_url = Icon.generate("#" + params[:color])
      response.headers['Content-Type'] = 'image/gif'
      response.headers['Content-Disposition'] = 'inline'
      render :text => open(image_url).read        
      
  end


end
