## Enhanced Attribute Table Widget ##
This widget is a modification on the standard Attribute Table Widget available in the standard **ESRI ArcGIS Viewer for Flex**.  It includes the addition of a help link in the widget title bar.

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Attribute Table Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.7



## Features ##

- Configurable Help button in the widget title bar that can be used to link to a web page for this widget.  If no url is specified in the widget config file, the button will not be displayed.  

- The spatial reference is now added to locally saved bookmarks and can be specified in the config settings.  When a bookmark is opened on a map that has a different coordinate system, the extent is projected to match the map coordinate system.  An error message is displayed if projection is not possible. 



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
		<!-- Option to specify whether the widget should check dynamic layers to see if they include editable feature services [values: true/false] -->
		<checkForEditableDynamicLayers>false</checkForEditableDynamicLayers>
	
		<!-- Label Settings -->
		<labels>
			<!-- Attribute table labels and tool tips -->
			<zoomallbuttonlabel>Zoom to all features</zoomallbuttonlabel>
			<zoomallbuttontooltip>Click to show all of the features of the current tab</zoomallbuttontooltip>
			<exporttocsvbuttonlabel>Export features to CSV</exporttocsvbuttonlabel>
			<exporttocsvbuttontooltip>Click to export the selected features of the current tab to CSV</exporttocsvbuttontooltip>
			
			<!-- Warnings -->
			<exporttocsvrecordcountwarning>You are currently only viewing a subset of the total records.  Pressing 'OK' will export only those records currently displayed in the table.  If you wish to export all of the records associated with this layer, click 'Cancel', zoom to the full extent of the records and try again.</exporttocsvrecordcountwarning>
		</labels>
	
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
<tr><td>Ryan Elley (ECan)</td><td>13 June 2013</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>27 August 2013</td><td><ul><li>Change to get "zoom to all features" button to be enabled when features are out of visible extent.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>26 September 2013</td><td><ul><li>Alteration to make the create featurelayers from dynamic layers functionality optional.  There is now a "checkDynamicLayers" option in the configXML parser.  If true, the dynamic layers will be checked as per original widget.  Default is false.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>4 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>23 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li></ul></td></tr>
</tbody>
</table>
