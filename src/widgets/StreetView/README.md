## Google Street-view Widget ##
This Google Street View Widget allows you to view Google Street View Panoramas in a popup window. Use of this widget requires a Google Maps API Key, Obtain an API Key.

This widget has been modified to function with non-web mercator map services.

**Developed by:** Robert Scheitlin (Calhoun County).  Portions modified by Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  Based on Robert Scheitlin's Google Streetview Widget
**ArcGIS API for Flex version:**  3.6



## Features ##

- The Widget is equipped with a cross browser popup blocker detector to warn the user if they have a popup blocker enabled. 
- The widget use Google Maps API Version 3 and has almost all the API options for the Street View Panorama that are available in the API configurable in the widgets xml. 
- A lot of attention has gone into the UI (User Inferface) and UX (User Experience) of this widget and a lot of cross browser testing has been done. 
- Tested on Safari for windows 5.1.7, Internet Explorer 9, Opera 12.15, FireFox 21.0, and Chrome 27.0.1453.110 m.
   



## Widget Config File Tag Reference ##

**<hidestreetviewvwidowwhenminimized \>**  
This is a true or false value and determines if the graphic on the map and the Google Street View window are hidden when the widget is minimized.  

**<width \>**  
The width of the popup widow that is opened.

**<height \>**  
The height of the popup widow that is opened.

**<apikey \>**  
The Google Maps API Key that you must obtain to use this widget. https://developers.google.com/maps/documentation/javascript/tutorial#api_key

**<addresscontrol\>**  
is a true or false value and determines if the Google Street View Address Control is visible.  It has an attribute of controlposition that defines where in the popup window the control is placed. See controlposition constants for acceptable values.

**<clicktogo \>** 
is a true or false value and determines if the Google Street View will move to the location clicked.

**<disabledoubleclickzoom \>** 
is a true or false value and determines if the Google Street View will zoom into the location on the panorama where the user double clicks.

**<imagedatecontrol \>** 
is a true or false value and determines if the Google Street View will display the date of the panorama image was taken along the bottom of the window with the copyright info.

**<linkscontrol \>** 
is a true or false value and determines if the Google Street View will display the movement arrows and street names on the panorama for navigation purposes.

**<pancontrol \>** 
is a true or false value and determines if the Google Street View pan Control is visible.  It has an attribute of controlposition that defines where in the popup window the control is placed.

**<zoomcontrol \>** 
is a true or false value and determines if the Google Street View zoom Control is visible.  It has an attribute of controlposition that defines where in the popup window the control is placed and a controlstyle attribute that determines the size of the control.

**<helplocationurl\> [Used in the ID Widget only.]**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

controlposition constants:

    BOTTOM_CENTER 	Elements are positioned in the center of the bottom row.
    BOTTOM_LEFT 	Elements are positioned in the bottom left and flow towards the middle. Elements are positioned to the right of the Google logo.
    BOTTOM_RIGHT 	Elements are positioned in the bottom right and flow towards the middle. Elements are positioned to the left of the copyrights.
    LEFT_BOTTOM 	Elements are positioned on the left, above bottom-left elements, and flow upwards.
    LEFT_CENTER 	Elements are positioned in the center of the left side.
    LEFT_TOP 		Elements are positioned on the left, below top-left elements, and flow downwards.
    RIGHT_BOTTOM 	Elements are positioned on the right, above bottom-right elements, and flow upwards.
    RIGHT_CENTER 	Elements are positioned in the center of the right side.
    RIGHT_TOP 		Elements are positioned on the right, below top-right elements, and flow downwards.
    TOP_CENTER 		Elements are positioned in the center of the top row.
    TOP_LEFT 		Elements are positioned in the top left and flow towards the middle.
    TOP_RIGHT 		Elements are positioned in the top right and flow towards the middle.

zoomcontrol - controlstyle constants:

    DEFAULT 	The default zoom control. The control which DEFAULT maps to will vary according to map size and other factors. It may change in future versions of the API.
    LARGE 	The larger control, with the zoom slider in addition to +/- buttons.
    SMALL 	A small control with buttons to zoom in and out.

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.


- **<helplabel\>**
Tooltip for the third title bar button (default for English is 'Help')


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
	    <hidestreetviewvwidowwhenminimized>true</hidestreetviewvwidowwhenminimized>
	    <width>500</width>
	    <height>600</height>
	    <apikey>[PUT API KEY HERE]</apikey>
	    <clientid/>
	    <streetviewpanoramaoptions>
	        <addresscontrol controlposition="TOP_CENTER">true</addresscontrol>
	        <clicktogo>true</clicktogo>
	        <disabledoubleclickzoom>true</disabledoubleclickzoom>
	        <imagedatecontrol>true</imagedatecontrol>
	        <linkscontrol>true</linkscontrol>
	        <pancontrol controlposition="TOP_LEFT">true</pancontrol>
	        <zoomcontrol controlposition="TOP_LEFT" controlstyle="SMALL">true</zoomcontrol>
	    </streetviewpanoramaoptions>
	    
	   	<!-- Help Location Settings -->
		<helplocationurl>http://google.com</helplocationurl>
	    
	    <labels>
	        <clearlabel>Clear</clearlabel>
	        <status>Show Google Street View</status>
	        <nostreetviewimageavailablemsg>No Street View Image Available&lt;br /&gt;or you have not yet dragged the Google&#174; Street View man&lt;br /&gt;onto the map to set your location.</nostreetviewimageavailablemsg>
	        <instructions>Drag the Google® Street View man onto the street you want to see a panorama for. You can also drag the street view man around on the map once he has been placed.</instructions>
	        <operamsg>Because you are using Opera as your web browser you may need to perform the following steps</operamsg>
	        <operamsgtitle>Opera Browser Detected</operamsgtitle>
	        <popupblockermsg>This widget uses a popup window to show Google Street View panoramas. You need to enable popups in your browser.</popupblockermsg>
	        <popupblockererrortitle>Popup Blocker Detected</popupblockererrortitle>
	
			<!-- Help -->
			<helplabel>Help</helplabel>
	    </labels>
	</configuration>


## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Ryan Elley (ECan)</td><td>09 July 2014</td><td><ul><li>Initial Development</li></ul></td></tr>
</tbody>
</table>
