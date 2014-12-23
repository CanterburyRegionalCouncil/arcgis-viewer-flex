## Add Shapefile Widget ##

The ShapeFiles Widget for Flex Viewer 3.x is a widget that allows you to add shapefiles to the viewer from the client machine if they are zipped. Shapefiles are made up of multiple file (i.e. xyz.shp, xyz.dbf, xyz.shx, xyz.prj, etc). The fact that a shapefile is made up of these multiple files is the reason that they need to be zipped. Flash Player allows the client to upload one file at a time. The minimum files necessary in the zipped file are the .shp and .dbf, it is also advisable to include the .prj file as well. This widget takes the initial work of Abdul Mannan Mohammed, the mods of Wesley Chow and Iain Campion and enhance then with the following features.
 
This widget allows the user to add ESRI shapefile format layers to the map as local datasets.  It includes the addition of a help link in the widget title bar.  Renamed from Shapefiles to AddShapefile.

**Developed by:**	Abdul Mannan Mohammed, Wesley Chow, Iain Campion.  Enhanced, sparked, localized and maintained by Robert Scheitlin.  Additional changes added by Ryan Elley (Environment Canterbury)  
**Source:**  Majority of code based on Robert Scheitlin's Shapefile widget ([http://www.arcgis.com/home/item.html?id=2e9096c5d5044d39a264df759611686f](http://www.arcgis.com/home/item.html?id=2e9096c5d5044d39a264df759611686f)) .  
**ArcGIS API for Flex version:**  3.7
**Requirements:**  
- The ArcGIS Flex API 3.1 or greater swc. Download it here:  [http://resources.esri.com/arcgisserver/apis/flex/index.cfm?fa=downloadDisclaimer](http://resources.esri.com/arcgisserver/apis/flex/index.cfm?fa=downloadDisclaimer)  
- Internet access to the ArcGIS Online servers  
- Web Server to deploy the application  
- Flash Player 11 or greater  
- You must point your ArcGIS Viewer for Flex to a ArcGIS Server 10 or greater GeometryService for shapefile re-projection to work!  If you use [http://tasks.arcgisonline.com/ArcGIS/rest/services/Geometry/GeometryServer](http://tasks.arcgisonline.com/ArcGIS/rest/services/Geometry/GeometryServer) (which is the default when you download the viewer), you will be fine. Do not use your own GeometryService if its version is less than 10.0.                                                                                                                                   


## Features ##

- ESRI Shapefiles can be added to the map as local datasets.  This requires the shapefile component files (specifically the "shp" and "dbf" files, but optionally the "prj" file) be contained in a ".zip" file which is loaded by the widget.  
- This zip file being loaded may contain more than one shapefile as long as each is uniquely named and contains the requisite "shp" and "dbf" files.  
- All shapefiles in the zip file will be loaded as separate, non-editable feature layers.
- Shapefiles that are stored in a coordinate system other than the one used by the current map will be projected to the map's coordinate system by using the project task of an arcgis server.  If the shapefile does not include a "prj" file, the widget will assume that the coordinates system used by the layer is the same as the map's coordinate system.
- Configurable Help button in the widget title bar that can be used to link to a web page for this widget.  If no url is specified in the widget config file, the button will not be displayed.  
- Adding labeling based on the first string field in the shapefile is optional and will be added as a seperate FeatureLayer.
- Each Shapefile is added as a FeatureLayer so that it appears in the LayerList Widget, TOC Widget, MapSwitcher Widget.
- The widget has been localized so that all text in the widget can be changed to the users locale.
- The widget has a ShapeFiles.xml that allows for widget options to be configured.
- Each added shapefile is displayed in the widgets results and has a remove button.
- When the widget is closed the shapefiles remain in the map (unless you choose to remove them using the widget).
- Options for symbology and labeling are now very extensive.  Default symbology for point, line and polygon shapefiles is captured in the widget config file.  Users may choose to specify thier own symbology settings as part of the loading process.
- When a shapefile is removed and it has been labeled, the corresponding labels are also removed.


## Widget Config File Tag Reference ##

**<labelbydefault\>**  
Boolean. Determines whether loaded shapefiles should be labelled with first text filed in the attribute table.    

**<defaultlabelplacement\>**  
String. Determines how labels are placed when the label features option is used.  The options are:  

- above : Places the label above the point.  
- below : Places the label below the point.  
- end : Places the label so that the text ends at the point, that is, places the label to the left of the point.  
- middle : Places the label centered on the point. (this is the default option).
- start : Places the label so that the text starts at the point, that is, places the label to the right of the point.  

**<autozoom\>**  
Boolean. Determines whether the map will zoom to the extent of the loaded features after the shapefiles have been loaded.   

**<symbols\>**  
Container of symbol settings used by the widget to apply to the loaded features. It has one child tag set for the point, line, polygon and text symbol settings: (<simplefillsymbol\>,<simplemarkersymbol\>,<simplelinesymbol\> and <TextSymbol\>)

**<simplefillsymbol\>**  
Symbol settings for the default fill symbols used to symbolise polygon based layers.  See [https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/SimpleFillSymbol.html](https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/SimpleFillSymbol.html) for the specific property options.  It has the following attributes:

- color : [Hex Code] Colour value to use for the fill symbol.
- alpha : [Number] Fill symbol alpha (transparency). Possible values range from 0.0 (invisible, fully transparent) to 1.0 (opaque, fully visible).
- style : [String] Fill symbol style.  Possible values include backwarddiagonal, cross, diagonalcross, forwarddiagonal, horizontal, null (for no fill i.e. outline only), solid, vertical.

**<simplelinesymbol\>**  
Symbol settings for the default line symbols used to symbolise line based layers.  See [https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/SimpleLineSymbol.html](https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/SimpleLineSymbol.html) for the specific property options.  It has the following attributes:

- color : [Hex Code] Colour value to use for the fill symbol.
- alpha : [Number] Fill symbol alpha (transparency). Possible values range from 0.0 (invisible, fully transparent) to 1.0 (opaque, fully visible).
- style : [String] Line symbol style.  Possible values include dash, dashdot, dashdotdot, dot, null (for no outline), solid.
- width : [Number] Width of the line.

**<simplemarkersymbol\>**  
Symbol settings for the default marker symbols used to symbolise point based layers.  See [https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/SimpleMarkerSymbol.html](https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/SimpleMarkerSymbol.html) for the specific property options.  It has the following attributes:

- color : [Hex Code] Colour value to use for the fill of the marker symbol.
- alpha : [Number] Marker symbol alpha (transparency). Possible values range from 0.0 (invisible, fully transparent) to 1.0 (opaque, fully visible).
- style : [String] Marker symbol style.  Possible values include circle, cross, diamond, square, triangle, square .
- size : [Number] Size of the marker symbol.
- 
**<outline\>**  
Simple fill and marker symbols have a sub-tag for the outline symbol settings. The outline tag applies to marker symbols of type "circle", "diamond", "square" and "triangle". It has the following attributes:

- color : [Hex Code] Colour value to use for the line symbol.
- alpha : [Number] Line symbol alpha (transparency). Possible values range from 0.0 (invisible, fully transparent) to 1.0 (opaque, fully visible).
- style : [String] Line symbol style.  Possible values include dash, dashdot, dashdotdot, dot, null (for no outline), solid.
- width : [Number] Width of the line.
 
**<TextSymbol\>**  
Symbol settings for the default symbol used to label features.  See [https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/TextSymbol.html](https://developers.arcgis.com/flex/api-reference/com/esri/ags/symbols/TextSymbol.html) and [http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormat.html](http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextFormat.html) for the specific property options.  It has the following attributes:

- color : [Hex Code] Colour value to use for the text.
- bold : [Boolean] Specifies whether to use the bold setting for the font.
- italic : [Boolean] Specifies whether to use the italics setting for the font.
- underline : [Boolean] Specifies whether to use the underline setting for the font.
- font : [String] Name of the font to use.
- size : [Number] Size of the font.

**<spatialreferences\>** 
Container of spatial reference settings. It has one child tag: (<spatialreference\>) 

**<spatialreference\>**  
Used when projecting features to match the  map coordinate system which requires getting the wkid number for the wkt value stored in the shapefile's prj file. It has the following attribute:

- wkt : [String] Well known text representation of the spatial reference.
- wkid : [Number] Well known ID number of the spatial reference

**<helplocationurl\>**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.

- **<textplacementmiddle\>**
Label text for the middle text label placement option (default for English is 'Middle').
- **<textplacementabove\>**
Label text for the above text label placement option (default for English is 'Above').
- **<textplacementbelow\>**
Label text for the below text label placement option (default for English is 'Below').
- **<textplacementstart\>**
Label text for the start of line text label placement option (default for English is 'Start').
- **<textplacementend\>**
Label text for the end of line text label placement option (default for English is 'End').
- **<textboldlabel\>**
Label text for the end of bold option (default for English is 'B').
- **<textboldtooltip\>**
ToolTip for the bold option button (default for English is 'Bold').
- **<textitaliclabel\>**
Label text for the end of italics option (default for English is 'I').
- **<textitalictooltip\>**
ToolTip for the italics option button (default for English is 'Italics').
- **<textunderlinelabel\>**
Label text for the end of underline option (default for English is 'U').
- **<textunderlinetooltip\>**
ToolTip for the underline option button (default for English is 'Underline').
- **<instructions\>**
Instruction text on how to use the Tool.  Note that if using special characters this text must be html safe (i.e. encoded) (default for English is 'To load a shapefile the files must be zipped.&#13;&#13;At a minimum there must be 2 files in the zip, 1 .shp, 1 .dbf, and an optional .prj file.&#13;&#13;Click the button below to upload a shapefile from your computer.&#13;&#13;To change symbology and other preferences click on the wrench icon above.').
- **<loadbutton\>**
Label for the load button (default for English is 'Load Local Shapefile...').
- **<addbutton\>**
Label for the load button (default for English is 'Load Shapefile').
- **<optionsbutton\>**
Label for the load option settings button (default for English is 'Preferences').
- **<readingmessage\>**
Message text displayed when reading the files (default for English is 'Reading shapefile') 
- **<projectingmessage\>**
Message text displayed when reprojecting the features to match the map's coordinate system (default for English is 'Reprojecting') 
- **<numberoffeaturesmessage\>**
Label for the number of features loaded (default for English is 'Number of Features:') 
- **<addedmessage\>**
Label for the list of added shapefiles (default for English is 'Added Shapefiles:') 
- **<addlabels\>**
Label for label features option on the preferences screen (default for English is 'Add Labels from the first text field in the shapefile') 
- **<labelplacement\>**
Label for label placement option on the preferences screen (default for English is 'Label placement') 
- **<includeoutline\>**
Label for include outline option on the preferences screen (default for English is 'Include Outline') 
- **<labelstexttoadd\>**
This is the text that is appended to the beginning of the zipfile name to indicate the shapefiles labels in the TOC (default for English is 'Labels') 

- **<helplabel\>**
Tooltip for the third title bar button (default for English is 'Help')


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
		<labelbydefault>false</labelbydefault>
		<defaultlabelplacement>middle</defaultlabelplacement>
		<autozoom>true</autozoom>
		<symbols>
			<simplefillsymbol color="0x4dfe45" alpha="0.6" style="solid">
				<outline color="0x088802" alpha="0.8" width="1" style="solid"/>
			</simplefillsymbol>
			<simplemarkersymbol style="circle" size="15" color="0x4dfe45" alpha="0.6" angle="0">
				<outline color="0x088802" alpha="0.8" width="1" style="solid"/>
			</simplemarkersymbol>
			<simplelinesymbol color="0x088802" alpha="0.8" width="2" style="solid"/>
			<TextSymbol color="0x000000" size="12" bold="false" italics="false" underline="false" font="Verdana"/>
		</symbols>
		<spatialreferences>
			<spatialreference wkt='PROJCS["NZGD_2000_New_Zealand_Transverse_Mercator",GEOGCS["GCS_NZGD_2000",DATUM["D_NZGD_2000",SPHEROID["GRS_1980",6378137.0,298.257222101]],PRIMEM["Greenwich",0.0],UNIT["Degree",0.0174532925199433]],PROJECTION["Transverse_Mercator"],PARAMETER["False_Easting",1600000.0],PARAMETER["False_Northing",10000000.0],PARAMETER["Central_Meridian",173.0],PARAMETER["Scale_Factor",0.9996],PARAMETER["Latitude_Of_Origin",0.0],UNIT["Meter",1.0]]' wkid="2193" />
		</spatialreferences>
		<labels>
			<textplacementmiddle>Middle</textplacementmiddle>
			<textplacementabove>Above</textplacementabove>
			<textplacementbelow>Below</textplacementbelow>
			<textplacementend>End</textplacementend>
			<textplacementstart>Start</textplacementstart>
			<textboldlabel>B</textboldlabel>
			<textboldtooltip>Bold</textboldtooltip>
			<textitaliclabel>I</textitaliclabel>
			<textitalictooltip>Italics</textitalictooltip>
			<textunderlinelabel>U</textunderlinelabel>
			<textunderlinetooltip>Underline</textunderlinetooltip>
			<instructions>To load a shapefile the files must be zipped.&#13;&#13;At a minimum there must be 2 files in the zip, 1 .shp, 1 .dbf, and an optional .prj file.&#13;&#13;Click the button below to upload a shapefile from your computer.&#13;&#13;To change symbology and other preferences click on the wrench icon above.</instructions>
			<loadbutton>Load Local Shapefile...</loadbutton>
			<addbutton>Load Shapefile</addbutton>
			<optionsbutton>Preferences</optionsbutton>
			<readingmessage>Reading shapefile</readingmessage>
			<reprojectingmessage>Reprojecting</reprojectingmessage>
			<numberoffeaturesmessage>Number of Features:</numberoffeaturesmessage>
			<addedmessage>Added Shapefiles:</addedmessage>
			<addlabels>Add Labels from the first text field in the shapefile</addlabels>
			<labelplacement>Label placement</labelplacement>
			<includeoutline>Include Outline</includeoutline>
			<!-- This is the text that is appended to the beginning of the zipfile name to indicate the shapefiles labels in the TOC -->
			<labelstexttoadd>Labels</labelstexttoadd>
			
			<!-- Help label settings -->
			<helplabel>Help</helplabel>
		</labels>
		
		<!-- Help Location Settings -->
		<helplocationurl>http://somewebsite.com/widgethelp.html</helplocationurl>

		<labels>
			<bookmarkslabel>Bookmarks</bookmarkslabel>
			<addbookmarkslabel>Add Bookmark</addbookmarkslabel>
			<addlabel>Add current extent as a bookmark named</addlabel>
			<submitlabel>Add Bookmark</submitlabel>
			<errorlabel>Please enter a name for the bookmark</errorlabel>
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
<tr><td>Ryan Elley (ECan)</td><td>4 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>22 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li></ul></td></tr>
</tbody>
</table>
