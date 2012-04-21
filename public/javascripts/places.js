function lookup_places(class_name) {
  // show loading indicator
  $('#place_lookup_results').html("<div class=\"loader\">Loading suggestions...</div>");

  // send ajax request
  $.get('/places/lookup', {query: $('#place_lookup_query').val(), class_name: class_name }, function(data) {
    $('#place_lookup_results').html(data);
  });
}

function show_place_lookup_form() {
  $('#place_lookup_form').show();
  try {$('#place_lookup_instructions').show();} catch (e) {}
}



function initializeMap() {
  var map;
  // passed in json should be ordered with
  // polygon region objects first, then markers
  var regions = [
    {
      type: "region",
      name: "Coordinates 1", 
      shape: [ 
        [-12, 12], 
        [-15.774252,12],
        [-20, 15],
        [-15,21],
        [-8,16]
      ],
      content: "Coordinates 1 data",
      refvalue: 100,
    }, 
    {
      type: "region",
      name: "Coordinates 2", 
      shape: [
        [-9,12], 
        [-6.774252,12],
        [-6,15],
        [-7,9],
      ],
      content: "Coordinates 2 data",
      refvalue: 100,
    },
    {
      type: "marker",
      content: "This is a marker",
      latitude: "-6",
      longitude: "15",
      refvalue: 100
    },    
    {
      type: "marker3",
      content: "This is a marker",
      latitude: "-21",
      longitude: "15",
      refvalue: 100
    }
  ];

  //corresponding data for polygon regions
  var data = [25, 45,3,5];
  
  // two color arrays for legend and presenting data values 
  var color1 = [200,0,4];
  var color2 = [0,58,130];
  
  // create a LatLngBounds object
  var bounds = new google.maps.LatLngBounds();

  // create the map
  var myOptions = {
    center: new google.maps.LatLng(0, 0),    
    zoom: 5   ,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };          


  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);  

  // create the color gradient legend
  createLegend(color1,color2);
  
  // for each region in Json object, plot the polygon coordinates 
  // on map with associated content and color from the data
  for (var r in regions) {
    if (regions[r].type == "region") {
      var percent = data[r]/regions[r].refvalue;
      
      // find the color by passing in a percentage as a string
      var color = colorize(percent,color1,color2);

      // this function creates the polygon region with the coordinates, the content, color
      setRegionPolygon(regions[r].shape,regions[r].content,color,percent);
      
      // extend the bounds of the map by each coordinate given
      // in coordinates array of polygon
      for (var e in regions[r].shape) {
        var coordinate = new google.maps.LatLng(regions[r].shape[e][0],regions[r].shape[e][1]);
        bounds.extend(coordinate);
      }
    }else if (regions[r].type == "marker") {

      var  marker = new google.maps.Marker({
        position: new google.maps.LatLng(regions[r].latitude,regions[r].longitude),
        title: regions[r].content,
        icon: new google.maps.MarkerImage('http://timboh.menocu.com/surfpaddle.png')
      });
      marker.setMap(map);

      // add the listener for clicks
      google.maps.event.addListener(marker, 'click', function() {
        var infowindow = new google.maps.InfoWindow({
          content: regions[r].content
        });
        infowindow.open(map,marker);
      });
    }
  }
  map.fitBounds(bounds);
}

// function createLegend creates color gradient by
// inserting div tags with corresponding colors for background.
function createLegend(color1,color2){
  var divs = "";
 
  // n is the margin from the top between each box used in CSS styling
  var n = 20;
  for (var i = 0; i < 8; i++) {
    var currcolor = colorize((i/8),color1,color2); 
    var append_string = '<div style="position: absolute; right: 7px; top: '+n+'px; background-color: '+currcolor+';  width: 40px; height: 40px" >' +(i/8)*100+'% </div> ';
    divs = divs + append_string;
    n = n + 40;
  }
  var bodyhtml = $('body').html();
  $('body').append(divs);
}

// colorize returns a color in hex as a string
// it takes arrays, color1 and color 2 which consist 
// of numbers 0-255 in "red,green,blue" format
function colorize(percent,color1,color2){
    var red1 = color1[0];
    var green1 = color1[1];
    var blue1 = color1[2];
    var red2 = color2[0];
    var green2 = color2[1];
    var blue2 = color2[2];
    var fred = red1 + (red2 - red1)*percent;
    var fgreen = green1 + (green2 - green1)*percent;
    var fblue = blue1 + (blue2 - blue1)*percent;

    //convert the floats to integers, return RGB string
    return "RGB("+parseInt(fred)+","+parseInt(fgreen)+","+parseInt(fblue)+")";
    //return "#"+ (parseInt(percent*256)+(parseInt((1-percent)*256)*256*256)).toString(16);
}

// function avgLatLng finds the average of all coordinates in a polygon 
// returns a google.maps.latlong object
function avgLatLng(latlong){
  var latavg = 0;
  var longavg = 0;
  for (var ll in latlong) {
   latavg = latlong[ll][0]+latavg;
   longavg = latlong[ll][1]+longavg;
  }
  latavg = latavg/latlong.length;
  longavg = longavg/latlong.length;
  var pos = new google.maps.LatLng(latavg,longavg);
  return pos;
}

// function setRegionPoly plots a polygon region on map 
// with given color (as a string in hex), content of infowindow box when
// mouseover, an array of latlong objects for plotting the border, color for opacity   
function setRegionPolygon(latlong,content,color,percent){
  var regionCoords = [];
  // for each coordinate, create a new lat long object and store in array
  for (var l in latlong) {
    regionCoords.push(new google.maps.LatLng(latlong[l][0],latlong[l][1]));
  }
  // create new polygons with latlng objects array
  var regionpoly = new google.maps.Polygon({
    paths: regionCoords,
    strokeColor: color,
    strokeOpacity: 0.9,
    strokeWeight: 2,
    fillColor: color,
    fillOpacity: .5,
    clickable: true
  });
  // create info window for region
  var regioninfowindow = new google.maps.InfoWindow();      
  // on mouseover, recenter map, and create info window at new center
  google.maps.event.addListener(regionpoly, 'mouseover', function (KmlMouseEvent) {
    var latlng = avgLatLng(latlong);
    regioninfowindow = new google.maps.InfoWindow({
      content: content,
      position: latlng
    });
    regioninfowindow.open(map);
  });
  
  // on mouseout, close info window
  google.maps.event.addListener(regionpoly, 'mouseout', function (KmlMouseEvent) {
    regioninfowindow.close();
  });
  regionpoly.setMap(map);
}                     
