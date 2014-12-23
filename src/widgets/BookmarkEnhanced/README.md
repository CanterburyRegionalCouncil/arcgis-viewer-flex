## Enhanced Bookmark Widget ##
This widget is a modification on the standard Bookmark Widget available in the standard **ESRI ArcGIS Viewer for Flex**.  It includes the addition of a help link in the widget title bar.

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Bookmark Widget supplied with the ArcGIS Viewer for Flex.  
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
<tr><td>Ryan Elley (ECan)</td><td>05 March 2013</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>21 May 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>4 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li><li>Change to allow bookmarks for maps using different coordinate systems to be projected to the current map coordinate system.  Displays an error message if the coordinates are not readily projectable.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>22 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li></ul></td></tr>
</tbody>
</table>
