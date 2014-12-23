## Enhanced Locate Widget ##
This widget is a modification on the standard Locate Widget available in the standard **ESRI ArcGIS Viewer for Flex**.  This widget allows users to interactively locate and zoom to point coordinates from the map.  They can locate these coordinates in the following coordinates systems NZTM, NZMG, WSG84, WGS84 in degrees & minutes, WGS84 in degrees & minutes & seconds, NZMapGrid, NZTMGrid and zoomto on the map. It includes the addition of a help link in the widget title bar.

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Bookmark Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.6



## Features ##

- Configurable Help button in the widget title bar that can be used to link to a web page for this widget.  If no url is specified in the widget config file, the button will not be displayed.  



## Widget Config File Tag Reference ##

**<addbookmarks\>**  
Boolean. Determines whether user defined bookmarks can be added. Default value is 'true'.  User defined bookmarks are saved in flash cookies (local shared objects) on the computer where they are created.    

**<bookmarks\>**  
Container of spatial bookmarks for the Viewer application. It has one child tag: (<bookmark\>)

**<bookmark\>**  
Each bookmark has its own <bookmark> tag. The minimum x,y and maximum x,y coordinates that define the bookmark spatial extent must be in the same spatial reference as the map unless the wkid number for the spatial reference of the bookmark is added as 5th value . If using the Viewer default configuration, these values can be obtained using the Extent Helper application. It has the following attribute:

- name : Name of the bookmark.

**<helplocationurl\>**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.

- **<bookmarkslabel\>**
ToolTip for the first title bar button (default for English is 'Bookmarks').
- **<addbookmarkslabel\>**
ToolTip for the second title bar button (default for English is 'Add Bookmark').
- **<addlabel\>**
Label for the Add Bookmark input window (default for English is 'Add current extent as a bookmark named').
- **<submitlabel\>**
Label for the custom bookmark creation button (default for English is 'Add Bookmark').
- **<errorlabel\>**
Error message reported when creating a custom bookmark fails (default for English is 'Please enter a name for the bookmark') 
- **<helplabel\>**
Tooltip for the third title bar button (default for English is 'Help')


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
		<!-- Default zoom scale to send map to when the user clicks on a point -->
		<zoomscale>4000</zoomscale>
		
		<!-- Add geometry server URL below -->
		<geometryservice>http://arcgis.ecan.govt.nz/ArcGIS/rest/services/Geometry/GeometryServer</geometryservice>
			
		<!-- Name to use for the graphics lay that will be used to display the coordinate markers.
			 This should be a unique name not used by other widgets or as the name of a base or
			 operational layer-->
		<graphicsLayerName alias="Locate Point Graphics" >LocatePointGraphicsLayer</graphicsLayerName>
		
		<!-- Result number formatting settings -->
		<projNumDecPlace>2</projNumDecPlace>
		<wgs84NumDecPlace>6</wgs84NumDecPlace> <!-- 10cms at 6th dp -->
	
		<!-- Initial data entry view setting.  Allowable values are:
			nzmg = New Zealand Map Grid XY Entry
			nztm = New Zealand Transverse Mercator XY Entry
			nzms260 = New Zealand Map System 260 Map Reference Entry
			nztopo50 = New Zealand Topo 50 Map Reference Entry
			wgs84dms = WGS84 Lat-Long Entry in Degrees-Minutes-Seconds
			wgs84dm = WGS84 Lat-Long Entry in Degrees-Decimal Minutes
			wgs84dm = WGS84 Lat-Long Entry in Decimal Degrees -->
		<initialview>nztm</initialview>
	
		<!-- Label settings -->	
		<labels>
			<instructionlabel>Use the locate tool to zoom to coordinates on the map:</instructionlabel>
			<modelabel>Click the button to set the coordinate entry mode.</modelabel>
			<sheetlabel>Sheet:</sheetlabel>
			<xlabel>Easting:</xlabel>
			<ylabel>Northing:</ylabel>
			<longitudelabel>Longitude:</longitudelabel>
			<latitudelabel>Latitude:</latitudelabel>			
			
			<!-- Buttons -->
			<resetLabel>Reset</resetLabel>
			<clearLabel>Clear</clearLabel>
			<submitLabel>Locate</submitLabel>
			
			<!-- Example labels for coordinates -->
			<exampleNZMS260SheetLabel>Pick a sheet from the list e.g. M35</exampleNZMS260SheetLabel>
			<exampleNZTopo50SheetLabel>Pick a sheet from the list e.g. BM25</exampleNZTopo50SheetLabel>
			<exampleNZTMXLabel>e.g. 1570292</exampleNZTMXLabel>
			<exampleNZTMYLabel>e.g. 5180600</exampleNZTMYLabel>
			<exampleNZMGXLabel>e.g. 2480293</exampleNZMGXLabel>
			<exampleNZMGYLabel>e.g. 5742212</exampleNZMGYLabel>
			<exampleWGS84LongitudeLabel>e.g. 172.632377</exampleWGS84LongitudeLabel>
			<exampleWGS84DMLongitudeLabel>e.g. 172° 29.814199′</exampleWGS84DMLongitudeLabel>
			<exampleWGS84DMSLongitudeLabel>e.g. 172° 29′ 48.85″</exampleWGS84DMSLongitudeLabel>
			<exampleWGS84LatitudeLabel>e.g. -43.526945</exampleWGS84LatitudeLabel>
			<exampleWGS84DMLatitudeLabel>e.g. -43° 28.999′</exampleWGS84DMLatitudeLabel>
			<exampleWGS84DMSLatitudeLabel>e.g. -43° 28′ 59.94″</exampleWGS84DMSLatitudeLabel>
			<webmercatorXExampleLabel>e.g. 19217347</webmercatorXExampleLabel>
			<webmercatorYExampleLabel>e.g. -5392526</webmercatorYExampleLabel>
			
			<!-- Prompt labels -->
			<promptXValue>Enter X Value</promptXValue>
			<promptYValue>Enter Y Value</promptYValue>
			<promptDegrees>Enter Degrees</promptDegrees>		
			<promptMinutes>Enter Minutes</promptMinutes>		
			<promptSeconds>Enter Seconds</promptSeconds>
		</labels>
		
		<!-- Widget message settings -->
		<messages>
			<locationError>Your location reference is invalid or outside the region.</locationError>
			<extentError>Your location reference is outside the region.</extentError>
			<validationError>There were problems with your values entered.</validationError>
		</messages>
		
		<!-- Extent check settings: used to make sure input coordinates are within a valid range 
				"initial" = valid points are within starting extent of map
				"full" = valid points are within full extent of map
				"" = don't perform an extent check -->
		<extentCheckSetting></extentCheckSetting>
		
		<!-- Coordinate systems to include and display -->
		<NZTM>
			<enable>true</enable>
			<enablenztopo50>true</enablenztopo50>
			<gridrefs>
				<gridref xmin="1492000" xmax="1516000" ymin="6198000" ymax="6234000" sheet="AS21" />
				...
				<gridref xmin="1180000" xmax="1204000" ymin="4722000" ymax="4758000" sheet="CK08" />
			</gridrefs>
		</NZTM>
		
		<NZMG>
			<enable>true</enable>
			<enablenzms260>true</enablenzms260>
			<gridrefs>
				<gridref xmin="2410000" xmax="2450000" ymin="6760000" ymax="6772604" sheet="L1" />
				...
				<gridref xmin="2090000" xmax="2130000" ymin="5290000" ymax="5320000" sheet="D50" />
			</gridrefs>
		</NZMG>
		
		<WGS84>
			<enable>true</enable>
			<enabledm>true</enabledm>
			<enabledms>true</enabledms>
		</WGS84>
		
		<webmercator>
			<enable>true</enable>
		</webmercator>
		
		<!-- Help Location Settings -->
		<helplocationurl>http://somewebsite.com</helplocationurl>
	</configuration>


## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Ryan Elley (ECan)</td><td>07 January 2012</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>27 January 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li><li>Change to fully use AGS 10.1 Project Task</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>08 June 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>28 July 2013</td><td><ul><li>Modification to include web mercator aux sphere XY coordinate input (for use with Bing/ArcGIS Online basemaps)</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>20 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
</tbody>
</table>
