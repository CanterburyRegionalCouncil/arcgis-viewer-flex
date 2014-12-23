## Enhanced Data Extract Widget ##
This widget is a modification on the standard Data Extract Widget available in the standard **ESRI ArcGIS Viewer for Flex**.  It includes the addition of a help link in the widget title bar, and the ability to limit the maximum number of layers that can be extracted in a single process. 

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Data Extract Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.7



## Features ##

- Configurable Help button in the widget title bar that can be used to link to a web page for this widget.  If no url is specified in the widget config file, the button will not be displayed.  

- The maximum number of layers that are allowed to be extracted can be set in the widget configuration file.  If not specified, or set to a value of 0 or less, then the user will be allowed to selected all layers.  If set to a number higher than 1, the users will see a message when more than that number of layer are checked in the layer selection list, and the execute button will be disabled until the number of selected layers is less than the set limit.
- The styling on the widget has been altered slightly for better layout.



## Widget Config File Tag Reference ##

**<dataextractionservice\>**  
The uniform resource locator (URL) to the geoprocessing service from which data will be extracted. This should be a geoprocessing service based on the Data Extract task.    

**<outputfilename\>**  
String value of the base name of the created file (minus the file extension). Default is 'extractedData'.

**<useproxy\>**  
Enables the widget to use a proxy server for data layers. If this is set to 'true', the widget uses the proxy server specified by the <httpproxy> tag in the Viewer application configuration file. See using a [proxy page](http://resources.arcgis.com/en/help/flex-viewer/concepts/index.html#//01m30000000w000000 "Using a Proxy Page") for more information on this.

**<aioselectionmethod\>**  
Defines how the AOI is set. Valid values are 'extent' and 'draw'. The 'extent' option uses the current map extent as the area boundary from which to extract data. When set to 'draw', end users define the AOI to extract from with the area boundary creation tools. The default is 'draw'.

**<excludelayer\>**  
When a layer is specified, it will not display in the Data Extract widget, and therefore, will not be downloadable. Multiple <excludelayer> tags can be specified to exclude multiple layers.

**<extractlayerlimit\>**  
Number.  Maximum number of layers that are allowed to be selected.  If omitted or set to -1, all layers will be selectable.

**<helplocationurl\>**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.

- **<desclabel\>**
Instruction label for the widget.  (default for English is 'Extract data and download zip file').
- **<step1label\>**
Instruction label for the first step in the data extract process (default for English is '1. Select area:').
- **<polygonlabel\>** ToolTip for the Draw Polygon tool (default for English is 'Draw Polygon'). 
- **<freehandpolygonlabel\>** ToolTip for the Draw Freehand Polygon tool (default for English is 'Draw Freehand Polygon').
- **<rectanglelabel\>** ToolTip for the Draw Rectangle tool (default for English is 'Draw Rectangle'). 
- **<circlelabel\>** ToolTip for the Draw Circle tool (default for English is 'Draw Circle'). 
- **<ellipselabel\>** ToolTip for the Draw Ellipse tool (default for English is 'Draw Ellipse'). 
- **<clearlabel\>** Label for the Clear Drawing tool (default for English is 'Clear'). 
- **<datacurrentextentlabel\>**
Label for instruction when using current visible extent (default for English is 'Data will be extracted from your current extent.').
- **<step2label\>**
Instruction label for the second step in the data extract process (default for English is '2. Select layers to extract:').
- **<step3label\>**
Instruction label for the third step in the data extract process (default for English is '3. Select file format:').
- **<step4label\>**
Instruction label for the fourth step in the data extract process (default for English is '4. Select raster format:').
- **<selectalllabel\>**
Label for select all option on the layer selection list (default for English is 'Select all').
- **<deselectalllabel\>**
Label for deselect all option on the layer selection list (default for English is 'Deselect all').
- **<step5label\>**
Instruction label for the fifth step in the data extract process (default for English is '5. SpatialReference:').
- **<step6label\>**
Instruction label for the sixth step in the data extract process (default for English is 'Email To').
- **<successfulemaillabel\>**
Message text displayed when the email results option is successful (default for English is 'Email sent successfully').
- **<unsuccessfulemaillabel\>**
Message text displayed when there is a problem using the email results option (default for English is 'Problem sending email').
- **<extractbuttonlabel\>**
Label for the launch process button (default for English is 'Extract').
- **<step1errorlabel\>**
Error message reported for the step 1 process (default for English is 'Please select layers to extract.') 
- **<step2errorlabel\>**
Error message reported for the step 2 process (default for English is 'Please select an area of interest.') 
- **<emptyresultslabel\>**
Error message reported for the extract process does not find any data to extract (default for English is 'Task completed but didn't return any results') 
- **<savedatafilelabel\>**
Message reported for the extract process has produced a file result (default for English is 'Data file created. Would you like to save it?') 
- **<layerlimitlabel\>**
Message reported when more layers have been selected that the ayer limit setting. (default for English is 'Maximum number of layers to extract reached.') 
- **<helplabel\>**
Tooltip for the third title bar button (default for English is 'Help')


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration label="Extract incident data">
    	<dataextractionservice>http://sampleserver4.arcgisonline.com/ArcGIS/rest/services/HomelandSecurity/Incident_Data_Extraction/GPServer/Extract%20Data%20Task</dataextractionservice>
    	<aioselectionmethod>draw</aioselectionmethod>

		<!-- Maximum number of layers to be allowed to extract - set to -1 if allowing all layers to be selected. -->
		<extractlayerlimit>10</extractlayerlimit>
	
		<!-- Labels -->
		<labels>
			<step2label>2. Select layers to extract (max. 10)</step2label>
			<layerlimitlabel>Maximum number of layers to extract reached.</layerlimitlabel>
		</labels>
	
		<!-- Help Location Settings -->
		<helplocationurl>start.html?helpfile=help/CoordinatesWidget.html</helplocationurl>
	</configuration>


## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Ryan Elley (ECan)</td><td>09 April 2013</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>21 May 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>13 March 2014</td><td><ul><li>Configurable limit to the number of layers allowed to be extracted added.  Defaults to all layers.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>12 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li><li>Updated to match 3.6 code.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>23 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li></ul></td></tr>
</tbody>
</table>
