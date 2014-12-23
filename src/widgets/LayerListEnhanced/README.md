## Enhanced Layer List Widget ##
This widget is a modification on the standard Layer List Widget available in the standard **ESRI ArcGIS Viewer for Flex**.  It includes the addition of a help link in the widget title bar, the ability to add and remove layers and map services, and an enhanced TOC which can display specified Graphics layers. 

**Developed by:**	Edward Correro, (Horizons Regional Council) & Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Layer List Widget supplied with the ArcGIS Viewer for Flex.  Certain sections of code from  LiveMapsWidget by Robert Scheitlin.  
**ArcGIS API for Flex version:**  3.6



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
		<addbookmarks>true</addbookmarks>
        <bookmarks>
            ...
            <bookmark> name="Victoria, BC, Canada">-13740900 6174200 -13722700 6181400 102100 </bookmark>
            <bookmark> name="Vancouver, BC, Canada">-13734100 6307700 -13661500 6336500 102100 </bookmark>
            ...
        </bookmarks>
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
<tr><td>Edward Correro (HRC)</td><td>16 June 2010</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Iain Campion (ECan)</td><td>10 August 2010</td><td><ul><li>Flex Viewer Port</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>12 January 2011</td><td><ul><li>Flex Viewer Port 2.2 API and 2.2 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>17 June 2011</td><td><ul><li>Flex Viewer Port 2.3.1 API and 2.3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>30 July 2011</td><td><ul><li>Flex Viewer Port 2.4 API and 2.4 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>19 December 2011</td><td><ul><li>Bug fix for feature layers not showing up in the remove layers list</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>10 January 2012</td><td><ul><li>Flex Viewer Port 2.5 API and 2.5 viewer.</li><li>Change to use a custom Legend skin to fix issue with extra space showing up if map services use multiple nested groups of layers.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>2 July 2012</td><td><ul><li>Bug fix to applying proxy settings.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>1 October 2012</td><td><ul><li>Bug fix for transparency slider firing when scroll button on mouse is used to zoom in on map.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>28 January 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>21 May 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>13 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
</tbody>
</table>
