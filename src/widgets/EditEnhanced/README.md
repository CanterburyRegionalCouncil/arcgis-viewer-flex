## Enhanced Edit Widget ##
The Enhanced Edit widget is a modified version of the standard Edit Widget.   It includes functionality for moving features by coordinate entry and offsets, exploding multi-part features, create circles by coordinate entry and radius, and provides interactive measurements while drawing.  Additional functionality for populating attributes based on URL parameters has also been included. 

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  Parts of this widget are based on the code from the Edit Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.7



## Features ##

- Features can be copied from any feature layer or configured graphics layer in the map.
- Features can be moved by offset or to a particular location using a dialog driven from the popup menu for the feature. 

- To be filled in.

## Widget Config File Tag Reference ##

**<createoptions\>**  
To be filled in.

**<polygondrawtools\>**  
To be filled in.
   
**<polylinedrawtools\>**  
To be filled in.

**<layersettings\>**  
Container of editable layer settings beyond what is configured in the feature template settings. It has one child tag: (<layer\>)

**<layer\>**  
Each layer can have its own <layer> tag. layer tags can have several child tags.  The layer tag has the following attributes:

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
	<!-- If compiling this widget, make sure to add -keep-all-type-selectors=true to your compiler arguments in the FB project properties. -->
	<configuration>
	    <createoptions>
	        <polygondrawtools>polygon,freehandpolygon,extent,autocomplete</polygondrawtools>
	        <polylinedrawtools>polyline,freehandpolyline,line</polylinedrawtools>
	    </createoptions>
	
		<!-- Tool Bar Settings -->    
	    <toolbarvisible>true</toolbarvisible>
	    <toolbarcutvisible>true</toolbarcutvisible>
	    <toolbarmergevisible>true</toolbarmergevisible>
	    <toolbarreshapevisible>true</toolbarreshapevisible>   
	
	    <toolbarexplodemultipart>true</toolbarexplodemultipart>
		<toolbarcreatepointxy>true</toolbarcreatepointxy>
		<toolbarcreatecirclexyradius>true</toolbarcreatecirclexyradius>
		<toolbarmovefeaturebyXY>true</toolbarmovefeaturebyXY>
	    <toolbarcopyfeatures>true</toolbarcopyfeatures>  
	    <toolbarshowattributes>true</toolbarshowattributes>
	      
	    
		<!-- Edit Capability Settings -->    
	    <addfeatures>true</addfeatures>
	    <deletefeatures>true</deletefeatures>
	    <updategeometry>true</updategeometry>
	    <updateattributes>true</updateattributes>
		<checkForEditableDynamicLayers>false</checkForEditableDynamicLayers>
		
		<!-- Editable Layer Settings -->    
		<layersettings>
			<!-- 
			<layer id="testpol" name="Test Edit Poly" url="http://somearcgisserver/ArcGIS/rest/services/Editable_Layers/FeatureServer/1" keyfield="Feature_Type" >
			
				<fields>
					<field name="OBJECTID" alias="Object ID" tooltip="Ob Tooltip" visible="false" editable="false" value="" />
					<field name="Data_Originator" alias="Data Originator" tooltip="Set the data editor" visible="false" editable="true" value="" />
					<field name="Feature_Type" alias="Feature Type" tooltip="Specify the code of record" visible="true" editable="true" value="" />
					<field name="Feature_Type_Desc" alias="Feature Type Description" tooltip="Set the feature type description" visible="true" editable="true" value="" />
					<field name="Date_" alias="Capture Date" tooltip="The date of last edit" visible="true" editable="false" value="DATE" />
					<field name="Approx_Age" alias="Approximate Age" tooltip="Enter the age of the feature" visible="true" editable="true" value="" />
					<field name="Comments" alias="Comments" tooltip="Enter any relevant comments" visible="true" editable="true" value="" />
					<field name="GlobalID" alias="Global ID" tooltip="Record unique id" visible="false" editable="false" value="" />
				</fields>
	
				<showobjectid>false</showobjectid>
				<showglobalid>false</showglobalid>
				<formfieldsorder>fields</formfieldsorder>
				<singletomultilinethreshold>50</singletomultilinethreshold>
			</layer>
	
			<layer id="testpol" name="Test Edit Line" url="http://somearcgisserver/ArcGIS/rest/services/Editable_Layers/FeatureServer/4" keyfield="Feature_Type" >
			
				<fields>
					<field name="OBJECTID" alias="Object ID" tooltip="Ob Tooltip" visible="false" editable="false" value="" />
					<field name="Data_Originator" alias="Data Originator" tooltip="Set the data editor" visible="false" editable="true" value="" />
					<field name="Feature_Type" alias="Feature Type" tooltip="Specify the code of record" visible="true" editable="true" value="" />
					<field name="Feature_Type_Desc" alias="Feature Type Description" tooltip="Set the feature type description" visible="true" editable="true" value="" />
					<field name="Date_" alias="Capture Date" tooltip="The date of last edit" visible="true" editable="false" value="DATE" />
					<field name="Approx_Age" alias="Approximate Age" tooltip="Enter the age of the feature" visible="true" editable="true" value="" />
					<field name="Comments" alias="Comments" tooltip="Enter any relevant comments" visible="true" editable="true" value="" />
					<field name="GlobalID" alias="Global ID" tooltip="Record unique id" visible="false" editable="false" value="" />
				</fields>
	
				<showobjectid>false</showobjectid>
				<showglobalid>false</showglobalid>
				<formfieldsorder>fields</formfieldsorder>
				<singletomultilinethreshold>50</singletomultilinethreshold>
			</layer>
			-->
			
		</layersettings>
	
		<!-- Graphic Layer Sources - Graphic layers in the map that can be used as data sources for the copy dalog -->
		<graphiclayers>
			<graphiclayer name="Drawn Graphics" type="Graphics" />
			<graphiclayer name="Search Results" type="Features" />
			<graphiclayer name="SelectBufferFindResultsLayer" type="Features" />
		</graphiclayers>
	
		<!-- Notify Service Integration - Adds ability to tell a listening service that an edit session has been completed -->
		<notifyServices>
			<notifyService url="http://ecan.govt.nz/{param1}" responsetype="confirm" label="Commit Changes" message="Please confirm you wish to commit the changes back to application X." redirectbrowser="true" >
				<parameter name="param1" source="url" value="SESSION" />
			</notifyService> 
			<notifyService url="http://www.google.com/?SESSION={param1}" responsetype="" label="Cancel Transaction" redirectbrowser="false" >
				<parameter name="param1" source="url" value="SESSION" />
			</notifyService> 
		</notifyServices>
	
		<!-- Interactive Measurement Settings -->
		<interactivemeasurement>
			<area precision="1" conversion="1" unitlabel="m²" />
			<distance precision="1" conversion="1" unitlabel="m" />
		</interactivemeasurement>
	
		<!-- Label Settings -->    
	    <labels>
	    	<!-- Create Point Tool Labels -->
	    	<createpointlabel>Point</createpointlabel>
	    
	    	<!-- Create Line Tool Labels -->
	    	<createlinelabel>Straight Line</createlinelabel>
	    	<createpointtopointlinelabel>Point to Point Line</createpointtopointlinelabel>
	    	<createfreehandlinelabel>Freehand Line</createfreehandlinelabel>
	    
	    	<!-- Create Polygon Tool Labels -->
	    	<createpointtopointpolygonlabel>Point to Point Polygon</createpointtopointpolygonlabel>
	    	<createfreehandpolygonlabel>Freehand Polygon</createfreehandpolygonlabel>
	    	<createcirclelabel>Circle</createcirclelabel>
	    	<createellipselabel>Ellipse</createellipselabel>
	    	<createextentlabel>Rectangle</createextentlabel>
	    
	    	<!-- Modify Tool Labels -->
		    <autocompletelabel>Autocomplete Polygon</autocompletelabel>
		    <cutlabel>Cut</cutlabel>
		    <mergelabel>Merge</mergelabel>
			<reshapelabel>Reshape</reshapelabel>
			<copylabel>Copy Features</copylabel>
			<createpointXYlabel>Create Point by XY</createpointXYlabel>
			<createcirclexyradiuslabel>Create Circle by XY &amp; Radius</createcirclexyradiuslabel>
			<movefeaturesbyxylabel>Move Features by XY</movefeaturesbyxylabel>
			
			<!-- Mode Instruction Labels -->
			<createfeaturesoptionbuttonlabel>Create Features</createfeaturesoptionbuttonlabel>
			<modifyfeaturesoptionbuttonlabel>Modify Features</modifyfeaturesoptionbuttonlabel>
			<templateselectionlabel>Select template to create feature</templateselectionlabel>
			<modifytoolslabel>Select the feature to modify</modifytoolslabel>		
			
			<!-- Copy Features Dialog -->
			<copydialogtitle>Copy Features</copydialogtitle>
			<copydialogsourcelayerlabel>Source Layer:</copydialogsourcelayerlabel>
			<copydialogsourcelayerdropdowntooltip>Select the data source to copy features from</copydialogsourcelayerdropdowntooltip>
			<copydialogfeaturesgridfeaturetypeheadertext>Feature Type</copydialogfeaturesgridfeaturetypeheadertext>
			<copydialogfeaturesgridfeatureidheadertext>Feature</copydialogfeaturesgridfeatureidheadertext>
			<copydialogselectallfeaturesbuttonlabel>Select All</copydialogselectallfeaturesbuttonlabel>
			<copydialogselectnonebuttonlabel>Select None</copydialogselectnonebuttonlabel>
			<copydialogrecordcountlabel>Record Count:</copydialogrecordcountlabel>
			<copydialogcopyattributescheckboxlabel>Copy Attributes:</copydialogcopyattributescheckboxlabel>
			<copydialogcopyattributescheckboxtooltip>Check to copy all attributes from the data source features that match attributes in the target layer</copydialogcopyattributescheckboxtooltip>
			<copydialogcancelbuttonlabel>Cancel</copydialogcancelbuttonlabel>
			<copydialogcancelbuttontooltip>Click to cancel copy action and close dialog</copydialogcancelbuttontooltip>
			<copydialogcreatecopybuttonlabel>Create Copy</copydialogcreatecopybuttonlabel>
			<copydialogcreatecopybuttontooltip>Click to create a copy of the selected feature in the target layer</copydialogcreatecopybuttontooltip>
	    
			<!-- Create Point by XY Dialog -->
			<createpointdialogtitle>Create Point by XY</createpointdialogtitle>
			<createpointdialoginstructionlabel>Enter the point coordinates and press "Create Point".</createpointdialoginstructionlabel>
			<createpointdialogxcoordinateinputlabel>X Coordinate:</createpointdialogxcoordinateinputlabel>
			<createpointdialogycoordinateinputlabel>Y Coordinate:</createpointdialogycoordinateinputlabel>
			<createpointdialogcoordinatesystemwarninglabel>Note:  The XY coordinates you enter must be in the local map coodinate system currently being displayed.</createpointdialogcoordinatesystemwarninglabel>
			<createpointdialogrequiredfieldlabel>Required</createpointdialogrequiredfieldlabel>
			<createpointdialoginvalidcharlabel>Invalid Character</createpointdialoginvalidcharlabel>
			<createpointdialogcancelbuttonlabel>Cancel</createpointdialogcancelbuttonlabel>
			<createpointdialogcancelbuttontooltip>Click to cancel the create point action and close dialog</createpointdialogcancelbuttontooltip>
	    	<createpointdialogcreatepointbuttonlabel>Create Point</createpointdialogcreatepointbuttonlabel>
	    	<createpointdialogcreatepointbuttontooltip>Click to create a point feature and close dialog</createpointdialogcreatepointbuttontooltip>
	
			<!-- Create Circle by XY Radius Dialog -->
			<createcircledialogtitle>Create Circle by XY &amp; Radius</createcircledialogtitle>
			<createcircledialoginstructionlabel>Enter the centre point and radius of the circle and press "Create Circle".</createcircledialoginstructionlabel>
			<createcircledialogxcoordinateinputlabel>X Coordinate:</createcircledialogxcoordinateinputlabel>
			<createcircledialogycoordinateinputlabel>Y Coordinate:</createcircledialogycoordinateinputlabel>
			<createcircledialogradiusinputlabel>Radius</createcircledialogradiusinputlabel>
			<createcircledialogcoordinatesystemwarninglabel>Note:  The XY coordinates you enter must be in the local map coodinate system currently being displayed.</createcircledialogcoordinatesystemwarninglabel>
			<createpointcirclerequiredfieldlabel>Required</createpointcirclerequiredfieldlabel>
			<createcircledialoginvalidcharlabel>Invalid Character</createcircledialoginvalidcharlabel>
			<createcircledialognegativeradiuslabel>Radius values must be positive</createcircledialognegativeradiuslabel>
			<createcircledialogcancelbuttonlabel>Cancel</createcircledialogcancelbuttonlabel>
			<createcircledialogcancelbuttontooltip>Click to cancel the create circle action and close dialog</createcircledialogcancelbuttontooltip>
			<createcircledialogcreatecirclebuttonlabel>Create Cirlce</createcircledialogcreatecirclebuttonlabel>
			<createcircledialogcreatecirclebuttontooltip>Click to create a circle feature and close dialog</createcircledialogcreatecirclebuttontooltip>
	
			<!-- Move Dialog -->
			<movedialogcancelbuttonlabel>Cancel</movedialogcancelbuttonlabel>
			<movedialogcancelbuttontooltip>Click to cancel the move action and close dialog</movedialogcancelbuttontooltip>
			<movedialogtmovebuttonlabel>Move</movedialogtmovebuttonlabel>
			<movedialogmovebuttontooltip>Click to move the feature and close dialog</movedialogmovebuttontooltip>
			<movedialogtmoveinstructionlabel>Enter the X and Y coordinates to move this feature to and press MOVE.</movedialogtmoveinstructionlabel>
			<movedialogoffsetinstructionlabel>Enter the X and Y offsets to move this feature by and press MOVE.</movedialogoffsetinstructionlabel>
			<movedialogmovexytogglebuttonlabel>Move to XY</movedialogmovexytogglebuttonlabel>
			<movedialogmovexytogglebuttontooltip>Click to toggle to 'Move to XY' mode</movedialogmovexytogglebuttontooltip>
			<movedialogoffsetxytogglebuttonlabel>Move by XY Offset</movedialogoffsetxytogglebuttonlabel>
			<movedialogoffsetxytogglebuttontooltip>Click to toggle to 'Offset by XY' mode</movedialogoffsetxytogglebuttontooltip>
			<movedialogrequiredfieldlabel>Required</movedialogrequiredfieldlabel>
			<movedialogxcoordinateinputlabel>X Coordinate:</movedialogxcoordinateinputlabel>
			<movedialogycoordinateinputlabel>Y Coordinate:</movedialogycoordinateinputlabel>
			<movedialogxoffsetinputlabel>Offset X:</movedialogxoffsetinputlabel>
			<movedialogyoffsetinputlabel>Offset Y:</movedialogyoffsetinputlabel>
			<movedialogtitle>Move Feature</movedialogtitle>
			
			<!-- Interactive Measurement Labels -->
			<arealabel>Area:</arealabel>
			<lengthlabel>Length:</lengthlabel>
			<perimeterlabel>Perimeter:</perimeterlabel>
			<radiuslabel>Radius:</radiuslabel>
			<widthlabel>Width:</widthlabel>
			<heightlabel>Height:</heightlabel>
			<segmentlengthlabel>Segment Length:</segmentlengthlabel>
			
			<!-- Help -->
			<helplabel>Help</helplabel>
	    </labels>
	    
	   	<!-- Help Location Settings -->
		<helplocationurl>http://somewebsite.com/HelpForThisWidget</helplocationurl>
	</configuration>

## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Ryan Elley (ECan)</td><td>01 December 2010</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>17 January 2011</td><td><ul><li>Flex Viewer Port 2.2 API and 2.2 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>17 June 2011</td><td><ul><li>Flex Viewer Port 2.3.1 API and 2.3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>03 November 2011</td><td><ul>
<li>Flex Viewer Port 2.4 API and 2.4 viewer</li>
<li>File structure changes</li>
<li>Enhancements to editing process tools.</li>
<li>Addition of notify service functionality.</li>
</ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>14 January 2012</td><td><ul><li>Flex Viewer Port 2.5 API and 2.5 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>28 March 2012</td><td><ul><li>Bug fix for Merge features triggering the confirm delete function.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>22 June 2013</td><td><ul>
<li>Flex Viewer Port 3.3 API and 3.3 viewer</li>
<li>Reworked to split create functionality from modify functionality</li>
<li>Dialogs and skins refreshed</li>
</ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>07 August 2013</td><td><ul><li>Bug fix to stop keyvalue filter code from firing when no value supplied.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>17 September 2013</td><td><ul>
<li>Tweak to attribute update from URL code.</li>
<li>Adjustment to zoom to exnt on selected features.  Now using ZoomTo method of map rather than setting extent.</li>
<li>Change to OpenWidget handler on KeyValue URL parameter method.  Was activating EditMode un-nessecesarily.</li>
<li>Removal of centre map on feature functionality in copy dialog.  Was causing copy to fail by preventing features from being selected.</li>
<li>Addition of code to disable edit mode if another widget such as the drawing widget activates a draw tool.</li>
</ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>26 September 2013</td><td><ul><li>Alteration to make the create featurelayers from dynamic layers functionality optional.  There is now a "checkDynamicLayers" option in the configXML parser.  If true, the dynamic layers will be checked as per original widget.  Default is false.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>15 March 2014</td><td><ul><li>Bug fix for loading feature layers that do not have layerDetails or capabilities settings</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>30 September 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>23 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li>
<li>Check added for self-intersecting polygons before applying edits on adds and updates.</li></ul></td></tr>
</tr>
<tr><td>Ryan Elley (ECan)</td><td>17 August 2015</td><td><ul><li>Bug fix for Edit Widget URL Parameter control</li>
</ul></td></tr>
</tbody>
</table>
