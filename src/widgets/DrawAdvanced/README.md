## Advanced Drawing and Measurement Widget ##
This widget is a custom tool to allow users to add mark up drawings and text to maps using the **ESRI ArcGIS Viewer for Flex**.  The tool allows the user to add and later modify the shapes and symbology used for the drawn shapes.  Its also includes tools related to adding text to the map.  Users can save any mark up they create to file and reload it again at a later stage.  It also stores the user's default symbol settings in local storage so that the user does not have to reset the defaults each time.  

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Drawing Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.7

**Requirements:** Utilises the following custom components:  

- GraphicsUtil (supportClasses/utils/GraphicsUtil - *Note This is not the standard GraphicsUtil class utilised by the API, but a version that references the same methods*).  
- GeometryUtil (supportClasses/utils/GeometryUtil)  
- SymbolUtil (supportClasses/utils/SymbolUtil)



## Features ##

- Configurable Help button in the widget title bar that can be used to link to a web page for this widget.  If no url is specified in the widget config file, the button will not be displayed.
- A list of currently displayed graphics, including the type of symbology being used.  Users can highlight a graphic by clicking its entry on the list, and chose to start a modify process or remove (delete) the graphic  
- Users can interactively add graphic features to the map including points, lines, polygons and text.  
- Users can manipulate the properties of the graphics (symbology colour	and style, font size, transparency, etc.).  
- Users can define default settings to use for graphics. 
- Users can save any captured graphics to text file and reload at a later stage.  The graphics are saved using the current spatial reference.  Future enhancements will include re-projecting loaded graphics to match the current map's spatial reference if they do not match.
- Default graphic settings are saved to local storage.  Any changes made by the user are updated to the local storage object so that the user's preferences can be persisted.



## Widget Config File Tag Reference ##

**<geometryservice\>**  
URL for the geometry service end point.  Optional if the URL is specified in the main viewer configuration file.     

**<graphicsLayerName\>**  
Name used for the graphics layer that the drawn graphic features are recorded in.  This should be a unique name not used by other widgets or as the name of a base or operational layer. The default value used is 'RedLiningGraphicsLayer'.  It has the following attribute:  

- alias : Display name used for graphics layer.  The default value used is 'RedLining Graphics' 

**<labelsLayerName\>**  
Name used for the graphics layer that the dynamic labels for measurements and label text are recorded in.  This should be a unique name not used by other widgets or as the name of a base or operational layer. The default value used is 'RedLiningLabelGraphicsLayer'.  It has the following attribute:  

- alias : Display name used for graphics layer.  The default value used is 'RedLining Labels' 

**<toolbarvisible\>**  
Boolean: Specifies whether the graphics tools toolbar is displayed within the widget.  The Default if not specified is 'true'. 

**<toolbarcutvisible\>**  
Boolean: Specifies whether cut tool button is displayed in the graphics tools toolbar within the widget.  Requires the toolbar be visible. The Default if not specified is 'true'. 

**<toolbarreshapevisible\>**  
Boolean: Specifies whether reshape tool button is displayed in the graphics tools toolbar within the widget.  Requires the toolbar be visible. The Default if not specified is 'true'. 

**<toolbarmergevisible\>**  
Boolean: Specifies whether merge tool button is displayed in the graphics tools toolbar within the widget.  Requires the toolbar be visible. The Default if not specified is 'true'. 

**<createoptions\>**
Specifies the available edit options in the widget. It has the following child tags:  

**<polygondrawtools\>**  
Tools available for creating polygons:  

- polygon : Create polygon tool.  
- freehandpolygon : Create polygon with freehand drawing tool.    
- extent : Create extent polygon tool.   
- circle : Create circle tool.  
- ellipse : Create ellipse tool.  


**<polylinedrawtools\>**  
Tools available for creating polylines:  

- polyline : Create polygonline tool.
- freehandpolyline : Create polyline with freehand drawing tool.
- line : Create line tool.

**<defaultGraphicsMode\>**  
Boolean: Specifies what the default action is when clicking on a drawing graphic when the drawing tools widget is open.  It has two modes - 'normal' which means the details view of graphic inspector is displayed, or 'edit' which means the graphic inspector is opened in edit mode, and the settings fro the graphic can be updated straight away. The default value if not specified is 'edit'. 

**<distanceunits\>**  
Container of distance units for the drawing tools measurement settings. It has one child tag: (<distanceunit\>)

**<distanceunit\>**  
Each distance unit has its own <distanceunit\> tag. The value of this tag is used as the display name on the distance unit selection tools. It has the following attributes:

- abbr : Abbreviation for the distance unit.  This is used as part of labels when displayed on screen and in the graphic properties inspector. e.g. 'm' for metres.
- conversion : Multiplication factor that will be used to convert the map's distance units to this distance unit. e.g. for 'metres' on a map displayed in metres the conversion factor is 1, while for 'feet' an approx conversion factor is 3.2808.
- precision : The number of decimal places to round the distance measurements to when using this distance unit.  e.g. If you wish to round to the nearest meter, set a precision value to 0.   

**<defaultdistanceunit\>**  
This value defines which distance unit should be used by default in the widget.  Specify the index of one of the configured distance units to use.  0 = the first distance unit in the file, 1 the second, and so on.  

**<areaunits\>**  
Container of area units for the drawing tools measurement settings. It has one child tag: (<areaunit\>)

**<areaunit\>**  
Each area unit has its own <areaunit\> tag. The value of this tag is used as the display name on the area unit selection tools. It has the following attributes:

- abbr : Abbreviation for the area unit.  This is used as part of labels when displayed on screen and in the graphic properties inspector. e.g. 'm²' for square metres.
- conversion : Multiplication factor that will be used to convert the map's area units to this distance unit. e.g. for 'square metres' on a map displayed in metres the conversion factor is 1, while for 'square feet' an approx conversion factor is 10.763910417.
- precision : The number of decimal places to round the area measurements to when using this distance unit.  e.g. If you wish to round to the nearest square meter, set a precision value to 0.   

**<defaultareaunit\>**  
This value defines which area unit should be used by default in the widget.  Specify the index of one of the configured area units to use.  0 = the first area unit in the file, 1 the second, and so on. 

**<bufferranges\>**  
Container of buffer units for as default choices for buffering in the drawing tool. The custom unit setting is appended to the end automatically during widget loading.  It has one child tag: (<bufferrange\>)

**<bufferrange\>**  
Each buffer range has its own <bufferrange\> tag. The value of this tag is used as the display name on the buffer range selection tools. It has the following attributes:

- distance : Numerical value in measurement units to be used as the buffer value. e.g. '50' for a buffer of 50 metres.
- unit : Name of the distance unit from the distance units list that will be used to calculate the buffer distance.  e.g. if 'Kilometers' is specified the tool will use the conversion settings for what is specified against 'kilometers' in the distance units list.    

**<defaultbufferindex\>**  
This value defines which buffer range should be used by default in the widget.  Specify the index of one of the configured buffer range to use.  0 = the first buffer range in the file, 1 the second, and so on. 

**<helplocationurl\>**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.

- **<drawlabel\>**
ToolTip for the show drawing tools title bar button (default for English is 'Draw').
- **<measurementoptionslabel\>**
ToolTip for the show measurement options and buffer tools title bar button (default for English is 'Measurement Options').
- **<graphicslistlabel\>**
ToolTip for the show graphics list title bar button (default for English is 'Map Graphics List') 
- **<openlabel\>**
ToolTip for the load saved graphics file title bar button (default for English is 'Load Saved Graphics'). 
- **<savelabel\>**
ToolTip for the save graphics file title bar button (default for English is 'Save Current Graphics') 
- **<clearfeaturelabel\>**
ToolTip for the clear graphics title bar button and on the clear features button (default for English is 'Clear') 
- **<zoomtoextenttooltip\>**
ToolTip for the zoom to the etxnt of all drawn graphics button (default for English is 'Zoom to extent of all drawn graphics') 




- **<helplabel\>**
Tooltip for the third title bar button (default for English is 'Help')


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
	    <!-- Map and geometry service settings -->
	    <geometryservice>http://sampleserver6.arcgisonline.com/arcgis/rest/services/Utilities/Geometry/GeometryServer</geometryservice>
	    
	    <!-- Graphic layer names -->
	    <graphicsLayerName alias="Drawn Graphics" >RedLiningGraphicsLayer</graphicsLayerName>
	    <labelsLayerName alias="Graphic Labels" >RedLiningLabelGraphicsLayer</labelsLayerName>
	    
	    <!-- Feature creation functionality -->
	    <createoptions>
	        <polygondrawtools>polygon,freehandpolygon,extent,autoComplete,circle,ellipse</polygondrawtools>
	        <polylinedrawtools>polyline,freehandpolyline,line</polylinedrawtools>
	    </createoptions>
	    
	    <!-- Toolbar functionality -->
	    <toolbarvisible>true</toolbarvisible>
	    <toolbarcutvisible>true</toolbarcutvisible>
	    <toolbarmergevisible>true</toolbarmergevisible>
	    <toolbarreshapevisible>true</toolbarreshapevisible>   
	    
	    <!-- Distance units used for measurement unit conversion -->
	    <distanceunits>
	        <distanceunit abbr="m" conversion="1" precision="0">Meters</distanceunit>
	        <distanceunit abbr="km" conversion=".001" precision="3">Kilometers</distanceunit>
	        <distanceunit abbr="ft" conversion="3.2808" precision="0">Feet</distanceunit>
	        <distanceunit abbr="mi" conversion="0.000621" precision="3">Miles</distanceunit>
	    </distanceunits>
	    <defaultdistanceunit>0</defaultdistanceunit>
	
	    <!-- Area units used for measurement unit conversion -->
	    <areaunits>
	        <areaunit abbr="m²" conversion="1" precision="0">Square Meters</areaunit>
	        <areaunit abbr="km²" conversion="0.000001" precision="3">Square Kilometers</areaunit>
	        <areaunit abbr="ft²" conversion="10.763910417" precision="0">Square Feet</areaunit>
	        <areaunit abbr="mi²" conversion="0.0000003861021" precision="3">Square Miles</areaunit>
	        <areaunit abbr="ac" conversion="0.00024710538147" precision="0">Acres</areaunit>
	        <areaunit abbr="ha" conversion="0.0001" precision="0">Hectares</areaunit>
	    </areaunits>
	    <defaultareaunit>0</defaultareaunit>
	
	    <!-- Buffer units used for buffer generation -->
		<bufferranges>
			<bufferrange distance="50" unit="Meters" >50 metres</bufferrange>
			<bufferrange distance="100" unit="Meters" >100 metres</bufferrange>
			<bufferrange distance="500" unit="Meters" >500 metres</bufferrange>
			<bufferrange distance="1000" unit="Meters" >1000 metres</bufferrange>
			<bufferrange distance="5" unit="Kilometers" >5 kilometres</bufferrange>
		</bufferranges>	
		<defaultbufferindex>3</defaultbufferindex>
	
	    <!-- Widget labels -->
		<labels>
		    <!-- Widget menu labels -->
			<drawlabel>Drawing Tools</drawlabel>
			<measurementoptionslabel>Measurement and Buffer Settings</measurementoptionslabel>
			<selectedgraphicslabel>Selected Graphics</selectedgraphicslabel>
			<graphicslistlabel>Map Graphics List</graphicslistlabel>
			<openlabel>Open Saved Graphics Layer</openlabel>
			<savelabel>Save Graphics Layer</savelabel>
			<clearfeaturelabel>Delete Feature</clearfeaturelabel>
			<zoomtoextenttooltip>Zoom to extent of all drawn graphics</zoomtoextenttooltip>
			
			<!-- Measurement option labels --> 
			<measurementslabel>Measurement Settings</measurementslabel>
			<showmeasurementslabel>Show Measurements with Graphics:</showmeasurementslabel>
			<distanceunitslabel>Distance Units:</distanceunitslabel>
			<distanceunitstooltip>Choose measurements units to display distances in</distanceunitstooltip>
			<areaunitslabel>Area Units:</areaunitslabel>
			<areaunitstooltip>Choose measurements units to display areas in</areaunitstooltip>
			
			<!-- Measurement type labels -->
			<arealabel>Area: </arealabel>
			<perimeterlabel>Perimeter: </perimeterlabel>	
			<lengthlabel>Length: </lengthlabel>
	
			<!-- Interactive measurement label settings -->
			<segmentlengthlabel>Line segment length:</segmentlengthlabel>
			<totallengthlabel>Total line length:</totallengthlabel>
		
			<!-- Buffer option labels --> 
			<bufferslabel>Buffer Settings</bufferslabel>
			<showbufferslabel>Generate buffers for drawn features</showbufferslabel>
			<bufferdistancelabel>Distance:</bufferdistancelabel>
			<bufferdistancetooltip>Specify the exact distance you wish to use when generating buffer rings</bufferdistancetooltip>
			<bufferunitlabel>Buffer:</bufferunitlabel>
			<bufferunittooltip>Select distance to buffer graphics by</bufferunittooltip>
			<buffernumberlabel>No of Rings:</buffernumberlabel>
			<buffernumbertooltip>Choose the number of buffer rings to generate</buffernumbertooltip>
			<generatebufferlabel>Generate Buffers with Graphics:</generatebufferlabel>
			<unionbufferslabel>Merge buffers together:</unionbufferslabel>
			<unionbufferstooltip>Tick to merge together the boundaries of the generated buffered shapes</unionbufferstooltip>
			
			<!-- Toolbar tooltips -->
			<selecttooltooltip>Click to activate the graphic selection tool</selecttooltooltip>
			<clearselectiontooltip>Click to clear the current graphic selection</clearselectiontooltip>
			<generatebufferstooltip></generatebufferstooltip>
			<showmeasurementsontooltip>Click to add measurement labels to all new graphics as they are added to the map.</showmeasurementsontooltip>
			<showmeasurementsofftooltip>Click to toggle off automatically adding measurement labels.</showmeasurementsofftooltip>
		
			<!-- Reorder graphics tooltips - These tooltips are used on the reorder graphic buttons -->
			<reordergraphicsuptooltip>Move selected graphics up one place in order</reordergraphicsuptooltip>
			<reordergraphicsdowntooltip>Move selected graphics down one place in order</reordergraphicsdowntooltip>
			<reordergraphicstotoptooltip>Move selected graphics to the top of the order</reordergraphicstotoptooltip>
			<reordergraphicstobottomtooltip>Move selected graphics to the bottom of the order</reordergraphicstobottomtooltip>
		
			<!-- Graphic Inspector Label Settings -->
			<graphicInspectorZoomLabel>Zoom</graphicInspectorZoomLabel>
			<graphicInspectorLinkLabel>Link</graphicInspectorLinkLabel>
			<graphicInspectorEditLabel>Edit</graphicInspectorEditLabel>
			<graphicInspectorDeleteLabel>Delete</graphicInspectorDeleteLabel>
			<graphicInspectorApplyLabel>Apply</graphicInspectorApplyLabel>
			<graphicInspectorCancelLabel>Cancel</graphicInspectorCancelLabel>
			
			<!-- Graphic Inspector Tooltip Settings -->
			<graphicInspectorZoomTooltip>Click to zoom to extent of the graphic</graphicInspectorZoomTooltip>
			<graphicInspectorLinkTooltip>Click to open the link in a new browser window</graphicInspectorLinkTooltip>
			<graphicInspectorEditTooltip>Click to edit the symbology, shape and properties of the graphic</graphicInspectorEditTooltip>
			<graphicInspectorDeleteTooltip>Click to remove this graphic from the map</graphicInspectorDeleteTooltip>
			<graphicInspectorApplyTooltip>Click to apply the symbology and property changes to this graphic</graphicInspectorApplyTooltip>
			<graphicInspectorCancelTooltip>Click to cancel the symbology and property changes to this graphic and revert to the original settings</graphicInspectorCancelTooltip>
			<graphicInspectorMeasurementTooltip>Click to show the measurements associated with graphics</graphicInspectorMeasurementTooltip>
		</labels>
		
		<!-- Symbol Templates -->
		<defaulttemplates>
			<!-- Simple Marker Templates -->
			<template name="Circle" description="Basic circle marker" groupname="Basic Markers" drawingtool="mappoint" type="marker" style="circle" alpha="1" colour="0xFF0000" size="15" angle="0" xoffset="0" yoffset="0" outlinewidth="2" outlinecolour="0xFFFFFF" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Triangle" description="Basic triangle marker" groupname="Basic Markers" drawingtool="mappoint" type="marker" style="triangle" alpha="1" colour="0x0000FF" size="15" angle="0" xoffset="0" yoffset="0" outlinewidth="2" outlinecolour="0xFFFFFF" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Square" description="Basic square marker" groupname="Basic Markers" drawingtool="mappoint" type="marker" style="square" alpha="1" colour="0x33CCEE" size="15" angle="0" xoffset="0" yoffset="0" outlinewidth="2" outlinecolour="0x000000" outlinestyle="solid" outlinealpha="1" /> 
		
			<!-- Simple Line Templates -->
			<template name="Red Line" description="Basic red line" groupname="Basic Lines" drawingtool="freehandLine" type="line" style="solid" alpha="1" colour="0xFF0000" width="1" /> 
			<template name="Blue Line" description="Basic blue line" groupname="Basic Lines" drawingtool="pointToPointLine" type="line" style="solid" alpha="1" colour="0x0000FF" width="1" /> 
			<template name="Green Line" description="Basic green line" groupname="Basic Lines" drawingtool="freehandLine" type="line" style="solid" alpha="1" colour="0x008000" width="1" /> 
			<template name="White Line" description="Basic white line" groupname="Basic Lines" drawingtool="pointToPointLine" type="line" style="solid" alpha="1" colour="0xFFFFFF" width="2" /> 
			<template name="Dashed Line" description="Basic dashed black line" groupname="Basic Lines" drawingtool="freehandLine" type="line" style="dash" alpha="1" colour="0x000033" width="2" /> 
			<template name="Dotted Line" description="Basic dotted black line" groupname="Basic Lines" drawingtool="pointToPointLine" type="line" style="dot" alpha="1" colour="0x000033" width="2" /> 
	
			<!-- Simple Fill Templates -->
			<template name="Hollow" description="Outline only" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="null" alpha="0" colour="0x000000" outlinewidth="1" outlinecolour="0x000000" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Green" description="Partially transparent green fill with no outline" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="solid" alpha="0.6" colour="0x008B00" outlinewidth="0" outlinecolour="0xFFFFFF" outlinestyle="none" outlinealpha="0" /> 
			<template name="Rose" description="Pale red fill" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="solid" alpha="1" colour="0xE33638" outlinewidth="1" outlinecolour="0x000000" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Beige" description="Beige fill" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="solid" alpha="1" colour="0xF5F5DC" outlinewidth="1" outlinecolour="0x000000" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Lilac" description="Lilac fill" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="solid" alpha="1" colour="0xFFBEE8" outlinewidth="1" outlinecolour="0x000000" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Lake" description="Pale blue fill with dark blue outline" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="solid" alpha="1" colour="0x7EC0EE" outlinewidth="1" outlinecolour="0x4876FF" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Gray" description="Gray fill" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="solid" alpha="1" colour="0xC2C2C2" outlinewidth="1" outlinecolour="0x000000" outlinestyle="solid" outlinealpha="1" /> 
			<template name="Crosshatch" description="Black diagonally crosshatched fill" groupname="Basic Areas" drawingtool="pointToPointPolygon" type="fill" style="diagonalcross" alpha="1" colour="0x000033" outlinewidth="1" outlinecolour="0x000033" outlinestyle="solid" outlinealpha="1" /> 
	
			<!-- Text Templates -->
			<template name="Simple Black" description="Basic black font label" groupname="Basic Text" drawingtool="text" type="text" font="Arial" fontsize="11" alpha="1" bold="true" italic="false" underline="false" colour="0x000000" border="false" borderColour="0x000000" background="false" 
				backgroundColour="0x000000" placement="middle" angle="0" xoffset="0" yoffset="0" leftmargin="0" rightmargin="0" align="center" />
	
		</defaulttemplates>
		
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
<tr><td>Ryan Elley (ECan)</td><td>02 June 2011</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>4 December 2011</td><td><ul><li>Flex Viewer Port 2.5 API and 2.5 viewer</li><li>Changes to use graphic inspector.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>18 February 2012</td><td><ul><li>Addition of GPX loading support</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>02 July 2012</td><td><ul><li>Bug fix to loading local templates</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>07 July 2012</td><td><ul><li>Change to multiline text editor</li><li>Fix to previews in template picker and graphic editor to cater for background and borders around text labels</li><li>Bug fix to symbolutil saving and loading routines</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>15 July 2012</td><td><ul><li>Bug fix preventing multiline edits in graphic inspector</li><li>Change to make edit mode default</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>29 January 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li><li>DrawTool Update event used to update the interactive measurement details</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>27 May 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li><li>Reworked to not use Graphic Properties Item</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>3 September 2013</td><td><ul><li>Bug fix for null/0 length text entry when adding text symbols</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>8 September 2013</td><td><ul><li>Bug fix in preparing graphics added to the drawing layer.  Polylines and polygons with no extent are dropped from the graphics layer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>4 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>6 November 2014</td><td><ul><li>Tweak to code to prevent invalid geometry without spatial reference being loaded as a drawing graphic.  Will now default to assigning it the map's spatial reference.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>23 December 2014</td><td><ul>
<li>Flex Viewer Port 3.7 API and 3.7 viewer</li>
<li>Bug fix for copy feature not creating a clone but referencing the original graphic's geometry.</li>
</ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>05 March 2015</td><td><ul>
<li>Bug fix/enhancement for loading saved graphics or graphics from GPX files.  The graphic data group now implements a bulk loading setting that prevents the data update from being displayed when graphics are added or removed.  This has increased performance when large numbers of graphics are added (previously the screen would update after each graphic is added, which caused progressively slower performance).</li>
</ul></td></tr></tbody>
</table>
