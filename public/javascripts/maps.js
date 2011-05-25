var markers;
function bootComplete() {
  x.gs.setSearchCompleteCallback(null, searchComplete);
  if ($('#issue_location_name').val() != "") {
    x.execute($('#issue_location_name').val());
  }
  if (l) {
    x.idleGmap.setCenter(l);
    m = createMarker(l, null);
    x.idleGmap.addOverlay(m);

  }
}

function createMarker(point, myHtml) {
  var marker = new GMarker(point);
  GEvent.addListener(marker, "click", function() {
		       x.idleGmap.openInfoWindowHtml(point, myHtml);
		     });
  return marker;
}
function searchComplete() {
  $('#results').html('');
  markers = [];
  i = 0;
  _m = 0;
  $.each(x.gs.results, function() {
           m = createMarker(new GLatLng(this.lat, this.lng), this.titleNoFormatting);
           markers.push(m);
           link = '<a href="#" onclick="setLatLng(' + (markers.length - 1) + '); return false">' + this.titleNoFormatting + "</a><br>";
           $('#results').append(link);
           x.idleGmap.addOverlay(m);
	   if (this.lat + "" == $('#building_lat').val() && this.lng + "" == $('#building_lng').val()) {
	     _m = i;
	   }
	 });
  setLatLng(_m);
}

function setLatLng(marker_index) {
  pt = markers[marker_index].getLatLng();
  x.idleGmap.setCenter(pt);
  GEvent.trigger(markers[marker_index],"click");
  $('#issue_location_lat').val(pt.lat());
  $('#issue_location_lng').val(pt.lng());
}

function LoadMapSearchControl() {

  var options = {
    zoomControl : GSmapSearchControl.ZOOM_CONTROL_ENABLE_ALL,
    title : "",
    url : "http://www.google.com/corporate/index.html",
    idleMapZoom : GSmapSearchControl.ACTIVE_MAP_ZOOM,
    activeMapZoom : GSmapSearchControl.ACTIVE_MAP_ZOOM,
    showResultList : document.getElementById("results"),
    onBootComplete: bootComplete
  }

  x = new GSmapSearchControl(
    document.getElementById("mapsearch"),
    "Pune",
    options
  );

}
// arrange for this function to be called during body.onload
// event processing
GSearch.setOnLoadCallback(LoadMapSearchControl);
