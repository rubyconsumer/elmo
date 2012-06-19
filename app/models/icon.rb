class Icon < ActiveRecord::Base        
  
   def self.generate(color)
     file_path = "tmp/icons/"+color+".png"
     if !FileTest.exists?(file_path)
       marker = Magick::Image.read("public/images/icons/marker.png")
       colored = marker[0].color_floodfill(5, 5, color)     
       colored.write(file_path)
     end                     
     return file_path
  end  
  
end
