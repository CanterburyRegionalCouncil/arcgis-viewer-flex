## Add Excel Widget ##
This widget allows the user to create layers of features on the map from a table stored in the Microsoft Excel Spreadsheets as local datasets.  

It assumes that the coordinates stored in two specific fields in the spreadsheet (as configured by the admin) utilise the same coordinate system as the map they are being loaded into.   

It includes the addition of a help link in the widget title bar.  

**Developed by:**	Developed for Otago Regional Council by the e-Spatial   Additional changes added by Ryan Elley (Environment Canterbury)  
**Source:**  N/A  
**ArcGIS API for Flex version:**  3.7



## Features ##

- Configurable Help button in the widget title bar that can be used to link to a web page for this widget.  If no url is specified in the widget config file, the button will not be displayed.  


## Widget Config File Tag Reference ##

**<xfield\>**  
[String] Name of the field in the spreadsheet that contains the x coordinate value. 

**<yfield\>**  
[String] Name of the field in the spreadsheet that contains the y coordinate value. 

**<titlefield\>**  
[String] Name of the field in the spreadsheet that contains the text to be used as the primary display field.

**<linkfield\>**  
[String] Text to be displayed as the label for to be used as link on the popup. for the loaded feature.

**<linkalias\>**  
[String] Text to be displayed as the label for links on the popup.

**<zoomscale\>**  
[Number] Scale to zoom the map to when an item is clicked on the list of features.

**<message\>**  
[String] Instruction message on how to use the widget.

**<helplocationurl\>**  
Url of the web page that can be called from the help button that is added to the titlebar.  If no url is specified or the tag is blank, the button will not be displayed. 

----------

**<labels\>**  
The following tags can be used to set the label text displayed on the widget.

- **<helplabel\>**
Tooltip for the third title bar button (default for English is 'Help')


### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
	    <xfield>X Coord</xfield>
		<yfield>Y Coord</yfield>
		<titlefield>Title</titlefield>
		<linkfield></linkfield>
		<linkalias></linkalias>
		<zoomscale>10000</zoomscale>
		<message>The .xls file must have at least two columns &#13; with the headings 'X Coord' and 'Y Coord' on the first Worksheet. &#13; A heading labelled 'Title' is optional.</message>

		<labels>
			<helplabel>Help</helplabel>
		</labels>
	
		<helplocationurl>http://somewebsite.com/widgethelp.html</helplocationurl>
	</configuration>

## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Ryan Elley (ECan)</td><td>21 May 2014</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>24 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>23 December 2014</td><td><ul><li>Flex Viewer Port 3.7 API and 3.7 viewer</li></ul></td></tr>
</tbody>
</table>
