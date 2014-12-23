## Enhanced Coordinate Widget ##
This widget is a modification on the standard Coordinate Widget available in the standard **ESRI ArcGIS Viewer for Flex**.  Modifications have been made to allow administrator alter/specify the way the coordinate text is displayed, including the style.  Also the current scale of the map can be optionally displayed as part of the text.

**Developed by:**	Iain Campion (Environment Canterbury Regional Council)  
**Source:**  This widget are based on the code from the Coordinate Widget supplied with the ArcGIS Viewer for Flex.  
**ArcGIS API for Flex version:**  3.6



## Features ##

- Configurable option to display the current map scale as part of the widget text.  
- Secondary precision setting for number formatting when displaying geographic coordinates.   Allows the widget to function correctly when switching between web maps that don't utilise web mercator coordinates and those that do without having to specify a different map config file.  


## Widget Config File Tag Reference ##

**<outputunit\>**  
The measurement unit to display; supported values are 'geo' (Geographic), 'dms' (Degrees, Minutes, Seconds), and 'mercator' (Web Mercator). The default is 'geo'.    

**<numberformatter\>**  
Determines the precision formatting of the displayed coordinate values. It has the following attributes:

- *decimalseparator* : Represents the decimal value separator (default value is a period '.').
- *thousandsseparator* : Represents the thousands value separator (default value is a period '.').
- *usethousandsseparator* : Determines whether or not the thousands separator is used (default value is 'true').
- *precision* : Determines the level of precision shown in the Viewer (default value is '-1'). For more information about formatting numerical values in Adobe ActionScript, see NumberFormatter.
- *precisiongeo* : Determines the level of precision shown in the Viewer when displaying geographic coordinates i.e. decimal degrees (default value is '6'). For more information about formatting numerical values in Adobe ActionScript, see NumberFormatter.
- *rounding* : Determines if numerical values will be rounded; in other words, replaced by another value(s) that is approximately equal but has a shorter, simpler, or more explicit representation (default value is 'none').

**<labelstyle\>**  
Determines the style settings for the widget's label. It has the following attributes. 

- *color* : Font color for the x and y coordinate values (default value is' 0x000000' -black).
- *fontfamily* : Font style for the x and y coordinate values (default style is 'Verdana').
- *fontsize* : Font size for the x and y coordinate values (default value is '9').
- *fontweight* : Font weight for the x and y coordinate values (default weight is 'bold').

### Example Configuration File ###
	<?xml version="1.0" ?>
	<configuration>
    	<outputunit>geo</outputunit>
    	<numberformatter precision="6"/>
    	<labelstyle color="0x000000" fontfamily="Verdana" fontsize="9" fontweight="bold"/>
    
		<labels>
    	    <template>Latitude:{1} Longitude:{0}</template>
    	</labels> 
	</configuration>


## Change Log ##
The following lists the history of changes/updates made.  
<table>
<thead>
<tr><th>Change By</th><th>Change Date</th><th>Change Description</th></tr>
</thead>
<tbody>
<tr><td>Iain Campion (ECan)</td><td>15 November 2010</td><td><ul><li>Initial Development</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>10 January 2011</td><td><ul><li>Flex Viewer Port 2.2 API and 2.2 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>10 June 2011</td><td><ul><li>Flex Viewer Port 2.3.1 API and 2.3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>9 January 2012</td><td><ul><li>Flex Viewer Port 2.5 API and 2.5 viewer</li><li>Display of scale, number format and template are now configurable.</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>26 January 2013</td><td><ul><li>Flex Viewer Port 3.1 API and 3.1 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>21 May 2013</td><td><ul><li>Flex Viewer Port 3.3 API and 3.3 viewer</li></ul></td></tr>
<tr><td>Ryan Elley (ECan)</td><td>4 July 2014</td><td><ul><li>Flex Viewer Port 3.6 API and 3.6 viewer</li><li>Change to configure the precision of the number formatter separately for geographic coordinates.</li></ul></td></tr>
</tbody>
</table>
