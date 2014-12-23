## Coordinate Capture Widget ##
This widget allows users to interactively capture point coordinates from the map.  It has been optimised for use with New Zealand coordinate mapping systems.  The users can capture coordinates in the following coordinates systems NZTM, NZMG, WSG84, & Web Mercator and copy these to the clipboard.

**Developed by:**	Iain Campion, (Environment Canterbury Regional Council)  
**Source:**  The majority of this code is based on code from Auckland Regional Council (ARC), and  Environment Canterbury Regional Council (ECAN).

Other sections were modified from default draw widget in the ESRI ArcGIS Viewer for flex.  
**ArcGIS API for Flex version:**  3.7



## Features ##
- The Coordinate Capture Widget allows users to display the map coordinates of a point location.
- The coordinates can be displayed in one of 4 projected or geographic coordinate system values - NZTM, NZMG, WSG84, & Web Mercator.
- For NZMG and NZTM coordinates, teh widget can output the values as either X (easting) and Y (northing) values, or as map sheet grid reference (NZMS 260 map sheets for NZMG coordinates, or NZ Topo50 sheets for NZTM coordinates).
- When displaying WGS84 coordinates, the user can choose to output the values in decimal degrees or in degrees minutes seconds.
- Users can copy the coordinates text to the system clipboard for any of the individual coordinate options or as a copy of all the currently configured coordinates. 
  

## Widget Config File Tag Reference ##

**<clickicon\>**  
File name of the image file to use to display the target point clicked by the user.  This file needs to be located in the assets/images folder of the widget's folder.  

**<clipboardicon\>**  
File name of the image file to used on the copy buttons in the widget.  This file needs to be located in the assets/images folder of the widget's folder.  
 
**<graphicsLayerName\>**  
Name used for the graphics layer that the capture features are recorded in.  This should be a unique name not used by other widgets or as the name of a base or operational layer. The default value used is 'CoordinateCaptureGraphicsLayer'.  It has the following attribute:  

- alias : Display name used for graphics layer. 

**<geometryservice\>**  
URL for the geometry service end point.  Optional if the URL is specified in the main viewer configuration file.  

**<projNumDecPlace\>**  
Format for the number of decimal places to be displayed for projected coordinate values.  The default value is 2.

**<wgs84NumDecPlace\>**  
Format for the number of decimal places to be displayed for decimal degree coordinate values.  The default value is 6.

**<helplocationurl\>**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

----------

**<WSG84\>** 
The following tags are related to the capture and display of WGS84 coordinates.

-  **<enable\>** Boolean: Set to true to display the WGS84 Lat-long coordinates output section.  The default setting is false.

----------

**<WebMercator\>** 
The following tags are related to the capture and display of Web Mercator coordinates.

-  **<enable\>** Boolean: Set to true to display the Web Mercator coordinates output section. The default setting is false.

----------

**<NZTM\>** 
The following tags are related to the capture and display of NZTM coordinates and grid references.  Grid references require the gridrefs tag be populated with the bounding coordinates for each of the NZ Topo50 Map sheets within the area of interest (see below)

-  **<enable\>** Boolean: Set to true to display the NZTM coordinates output section. The default setting is false.   
-  **<gridrefs\>** Container of NZ Topo50 Map Sheet details used in the grid reference conversion process.  It has one child tag: (<gridref\>)
-  **<gridref\>** Each NZ Topo50 map sheet has its own <griderf> tag. The minimum x,y and maximum x,y coordinates that define the map sheet's spatial extent are defined as attributes, as is the sheet's name.  It has the following attribute:

- xmin : The minimum x bounding coordinate of the map sheet  
- xmax : The maximum x bounding coordinate of the map sheet.  
- ymin : The minimum y bounding coordinate of the map sheet.  
- ymax : The maximum y bounding coordinate of the map sheet.  
- sheet : the short name of the sheet e.g. AS21

----------

**<NZMG\>** 
The following tags are related to the capture and display of NZMG coordinates and grid references.  Grid references require the gridrefs tag be populated with the bounding coordinates for each of the NZMS 260 Map sheets within the area of interest (see below)

-  **<enable\>** Boolean: Set to true to display the NZMG coordinates output section. The default setting is false.   
-  **<gridrefs\>** Container of NZMS 260 Map Sheet details used in the grid reference conversion process.  It has one child tag: (<gridref\>)
-  <gridref\> Each NZMS 260 map sheet has its own <griderf> tag. The minimum x,y and maximum x,y coordinates that define the map sheet's spatial extent are defined as attributes, as is the sheet's name.  It has the following attribute:

- xmin : The minimum x bounding coordinate of the map sheet.
- xmax : The maximum x bounding coordinate of the map sheet.
- ymin : The minimum y bounding coordinate of the map sheet.
- ymax : The maximum y bounding coordinate of the map sheet.
- sheet : the short name of the sheet e.g. M35  

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.

- **<descriptionlabel\>**
Instruction label displayed at the top of the widget (default for English is 'Use the map coordinate tool to identify coordinates on the map:').
- **<pointlabel\>**
Tooltip on the Draw Point UI button control (default for English is 'Click for Coordinate'). 
- **<coordEmptylabel\>**
Default label displayed in each of the UI label areas where coordinate results are displayed.  Set to this value when the widget is reset (default for English is '-click on the map-'). 
- **<clipboardlabel\>**
Tooltip on each of the Copy UI button controls (default for English is 'This Button will copy the current captured coordinates to the clipboard'). 
- **<clearlabel\>**
Tooltip on the Reset UI button control (default for English is 'Clear'). 
- **<locationError\>**
Instruction label displayed as a message when there is a problem with the location clicked (default for English is 'Your location coordinates are invalid or outside the region.').


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
    	<layerlist visible="true">
			<excludelayer>Fires</excludelayer>
    	</layerlist>
		<expandlayeritems>true</expandlayeritems>
		<showthumbnails>false</showthumbnails> 
	</configuration>


## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Iain Campion (ECan)</td><td>1 June 2010</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Iain Campion (ECan)</td><td>1 July 2010</td><td><ul><li>Flex Viewer Port</li></ul></td></tr>
<tr><td>Iain Campion(ECan)</td><td>19 July 2010</td><td><ul><li>Forward Ported Edward Correro (HRC) changes of 18 July rev 154 - NZTM basemap related bug fixes</li></ul></td></tr>
<tr><td>Iain Campion (ECan)</td><td>24 September 2010</td><td><ul><li>Flex Viewer Port 2.1 API and 2.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>10 December 2010</td><td><ul><li>Fix of projection to NZMG bug when viewer is in other coordinate system</li></ul></td></tr>
<tr><td>Iain Campion (ECan)</td><td>10 January 2011</td><td><ul><li>Flex Viewer Port 2.2 API and 2.2 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>17 June 2011</td><td><ul><li>Flex Viewer Port 2.3.1 API and 2.3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>9 January 2012</td><td><ul><li>Flex Viewer Port 2.5 API and 2.5 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>26 January 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li><li>Change to fully use AGS 10.1 Project Task.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>21 May 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li><li>Tweak to make help button optional - if no help location url in config file, button is not included.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>5 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>23 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li></ul></td></tr>
</tbody>
</table>
