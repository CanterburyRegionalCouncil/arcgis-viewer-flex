## Enhanced Header Controller Widget ##
This widget is a modification on the standard Header Controller Widget available in the standard **ESRI ArcGIS Viewer for Flex**.

**Developed by:**	Ryan Elley (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Header Controller Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.6



## Features ##

- The geocoder has been replaced with an autocomplete search component that calls a custom search service.  
- Results from the autocomplete component are linked to the Enhanced Search Widget's configurations.  If a layer is found that matches the search class property of the selected search suggestion, it will open the search widget and send a search request to it using the supplied properties.  Otherwise it displays the returned result on the map. 
- If the spatial reference of the map does not match the coordinates of the selected search suggestion, those coordinates are  projected to the map spatial reference before being displayed on the map. 
- A group of links can be configured to be displayed as another group on the header.
- A clear results button that other custom widgets can listen for can be configured to be displayed in the controller.


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
<tr><td>Ryan Elley (ECan)</td><td>29 September 2011</td><td><ul><li>Initial Development based on Enhanced Search Predictive Search Widget, reworked to function with the Advanced Search Widget.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>06 January 2012</td><td><ul><li>Flex Viewer Port 2.5 API and 2.5 viewer</li><li> Predictive search element separated from the widget into a standalone component for reuse in multiple widgets.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>06 February 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>12 June 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>20 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li><li>Legacy mode code for calling the predictive service as a soap call removed.  Now only uses JSon Task call to rest service.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>23 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li></ul></td></tr>
</tbody>
</table>
