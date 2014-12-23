## Enhanced Map Switcher Widget ##
This widget is a modification on the standard Map Switcher Widget available in the standard **ESRI ArcGIS Viewer for Flex**.  This widget allows users to switch base map services/dynamic layers on and off.  A slider has been added to the basemap switcher to allow user to alter the transparency of the basemap.

**Developed by:**	Edward Correro, (Horizons Regional Council)  
**Source:**  This widget are based on the code from the Map Switcher Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.6



## Features ##
- The Map Switcher widget primarily enables end users to easily switch between basemaps in the ArcGIS Viewer for Flex application.
- Basemaps can be displayed as a gallery picker which displays icons for each map, or as a button bar listing only the basemap names.  If no basemaps other than the one in the map are included, the button to show the basemap gallery will be hidden.
- A TOC control can be configured to be displayed as a popup off a button on this widget. 
- Slider control added to the basemap picker popup that allows user to change the transparency of the currently displayed basemap.  


## Widget Config File Tag Reference ##

**<layerlist\>**  
Contains layers. It can have the following attributes and child tags:  

- visible : Determines if the operational layers control is visible in the Viewer user interface (UI). The basemaps will still display if there is more than one basemap. Boolean value (default is true).  
 

**<excludelayer\>**  
When a layer is specified (by its name, which should match the layer name in the Viewer application's main configuration file), it will not display in the Map Switcher widget. Multiple excludelayer tags can be specified if you want to exclude multiple layers.
**Example for excluding layers from Map Switcher widget:**

	In the main configuration file:
	<layer label="thelayername".../>
	
	In the widget configuration file:
	<layerlist visible="true" >
	  <excludelayer>Fires</excludelayer>
	</layerlist>


**<expandlayeritems\>**  
If true, the widget expands all the individual items in the tree. The default is false. [Added in 2.5]

**<includelegenditems\>**  
Boolean value indicating whether symbols are displayed. Default value is 'true'. [Added in 3.2]

**<showthumbnails\>**  
By default, this is set to true. The basemaps display in a gallery/icon view. If you don't want it to display like this, set the property to 'false'. [Added in 3.0]


----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.

- **<basemapslabel\>**
Label of the basemap UI button control (default for English is 'Basemap').
- **<layerlistlabel\>**
Label of the operational layers UI button control (default for English is 'More...'). 
- **<transparencysliderlabel\>**
Label of the transparency UI slider control (default for English is 'Transparency'). 


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
<tr><td>Edward Correro (HRC)</td><td>10 July 2010</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Iain Campion(ECan)</td><td>10 October 2010</td><td><ul><li>Flex Viewer Port 2.1 API and 2.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>11 January 2011</td><td><ul><li>Flex Viewer Port 2.2 API and 2.2 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>28 March 2011</td><td><ul><li>Changes for adding special graphics layers (like the drawing widget layer) to the map</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>17 June 2011</td><td><ul><li>Flex Viewer Port 2.3.1 API and 2.3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>9 January 2012</td><td><ul><li>Flex Viewer Port 2.5 API and 2.5 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>26 January 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li><li>Code updated to use 3.1 format.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>29 May 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li><li>TOC changed to use extended TOC2.</li><li>Transparency slider for base maps added to the basemap picker.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>7 June 2014</td><td><ul><li>Bug fix for issue where the layer list not visible config setting was not being honoured.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>4 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li><li>Custom TOC not ported - standard TOC reinstated. Users were bypassing the TOC in this widget and using the Manage Layers widget by default.</li><li>Manage button removed as TOC panel generally configured not to show.</li><li>Code to inject basemaps removed in favour of change to Core ConfigManager to inject basemaps only when web map is loaded.</li></ul></td></tr>
</tbody>
</table>
