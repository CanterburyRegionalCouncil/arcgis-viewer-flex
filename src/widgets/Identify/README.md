## ID and Identify Widget ##
These widgets allows users to identify features in dynamic layers, tiled layers, feature service layers, and image service layers.  In the Identify widget, these results are displayed in an interactive inspector shown in the map popup window.  The ID widget displays the same content, but in a more traditional widget.

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  Parts of this widget are based on the code from the Draw Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.6



## Features ##

- Can identify features within ArcGIS Tiled, Dynamic and Feature layers (both linked and based on feature collections).
- Can identify Image Service layers.
- Has capability to id specific layers from the map, all currently visible layers (taking into account scale) and all layers in the map.
- Layers and map services can be configured to include or exclude some or all sublayers in ArcGIS Tiled and Dynamic map services currently within the map.    



## Widget Config File Tag Reference ##

**<searchWidgetName\>**  
Name of the Enhanced Search Widget (as listed in the viewer main config file).  If specified, an option to send identified results to search widget will be available on the result inspector.    

**<graphicsLayerName\>**  
Name used for the graphics layer that the identify result features are recorded in.  This should be a unique name not used by other widgets or as the name of a base or operational layer. The default value used is 'IdentifyResultGraphicsLayer'.  It has the following attribute:  

- alias : Display name used for graphics layer.  The default value used is 'Identification Results' 

**<drawnGraphicsLayerName\>**  
Name used for the graphics layer that the drawn graphic features are recorded in.  This should match the name used in the advanced drawing widget's config file.  This should be a unique name not used by other widgets or as the name of a base or operational layer. The default value used is 'IdentifyResultGraphicsLayer'.  It has the following attribute:  

- alias : Display name used for graphics layer.  The default value used is 'Draw Features' 

**<mapLayers\>**  
Container of identifiable layer settings for the ID and Identify widgets. It has one child tag: (<mapLayer\>)

**<mapLayer\>**  
Each mapLayer can have its own <mapLayer> tag. mapLayer tags can have 1 child tag: (<idLayers>).  The mapLayer tage has the following attributes:

- url : URL to the base ArcGIS map or imagery service.  If feature layers are listed, use only the base URL here, and then list the id number of the layer in the idLayers tag (or set it to all).  



**<helplocationurl\> [Used in the ID Widget only.]**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.


- **<helplabel\>**
Tooltip for the third title bar button (default for English is 'Help')


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
		<!-- Name of graphics layer that will be used to display results -->
		<graphicsLayerName alias="Identification Results">IdentifyResultGraphicsLayer</graphicsLayerName>
	
		<!-- Name of graphics layer that will be used to display results -->
		<drawnGraphicsLayerName alias="Draw Features">Draw Features</drawnGraphicsLayerName>
	
	 	<!-- Setting to allow search results to be sent to the search widget -->
	 	<allowSearchPropagation>true</allowSearchPropagation> 
	
		<!-- Enter the name of the search widget as shown in the main application config.xml.  This is used to allow search functionality 
			 to open the Search Widget and initiate a search, based on the suggestions class type.  If this tag is left empty, the search 
			 functionality will centre the map on the selected suggestion location and will place a label on the map (providing the suggestion 
			 contains spatial info). -->
		<searchWidgetName>Enhanced Search</searchWidgetName>
	
		<!-- Search Layer Settings -->
		<mapLayers>
	
			<mapLayer url="http://gis.ecan.govt.nz/ArcGIS/rest/services/Public/Region_Base/MapServer" >
				<idLayers type="exclude">5,6</idLayers>
				<layerSummaryFields>
					<layer id="5" layerName="Roads" >name,other_names,territorial_authority</layer>
					<layer id="6" layername="Land Parcels" >Valuation_No,Appellation,Calc_Area</layer>
				</layerSummaryFields> 
				<layerLinks>
					<layer id="6" layername="Land Parcels" linkField="Link" linkButtonLabel="Show Details">http://reportingservices/ReportServer/Pages/ReportViewer.aspx?%2fGIS-Reports%2fValuation.Summary&amp;rs:Command=Render&amp;rc:Parameters=false&amp;ValuationNo=[value]</layer>
				</layerLinks>
				<imageLinks>
					<!--<layer id="6" layername="Land Parcels" linkField="VALUATION_NO" >http://www.scificool.com/images/2008/04/stargate-universe-tv-series.jpg</layer> -->
				</imageLinks>
				<layerSortFields>
					<layer id="5" layername="Roads" varType="String" sortOrder="ASC" >name</layer>
					<layer id="6" layername="Land Parcels" varType="String" sortOrder="ASC" >Valuation_No</layer>
				</layerSortFields>
			</mapLayer>
	
			...
	
			<mapLayer url="http://arcgis.ecan.govt.nz/ArcGIS/rest/services/Public/No_Background/MapServer" >
				<idLayers type="exclude">all</idLayers>		
			</mapLayer>
	
		</mapLayers>
	
		<!-- Result formatting settings -->
		<formats>
			<date>dd MMM yyyy</date>
		</formats>
	
		<!-- Label settings -->
		<labels>
			<!-- Help label settings -->
			<helplabel>Help</helplabel>
		</labels>
	
		<!-- Help Location Settings -->
		<helplocationurl>http://ecan.govt.nz</helplocationurl>
	</configuration>


## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Ryan Elley (ECan)</td><td>09 July 2011</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>29 January 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li><li>Addition of toggle button to keep ID tool active after an ID is performed</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>18 April 2013</td><td><ul><li>FChange to display point generation for search results</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>14 June 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>02 November 2013</td><td><ul><li>Bug fix for "all layers" and "visible layers" option when using proxied or token layers</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>15 March 2014</td><td><ul><li>Bug fix for loading feature layers that do not have layerDetails or capabilities settings</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>21 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li><li>Change to allow ID of Feature layers based on Feature Collections.</li></ul></td></tr>
</tbody>
</table>
