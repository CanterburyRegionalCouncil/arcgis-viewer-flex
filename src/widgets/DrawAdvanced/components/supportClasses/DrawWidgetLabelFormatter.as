package widgets.DrawAdvanced.components.supportClasses
{
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.*;
	
	import spark.formatters.NumberFormatter;
	
	public class DrawWidgetLabelFormatter
	{
		/** 
		 * Geographic coordinate WKID number;
		 */
		public static const EPSG_GEOGRAPHIC:Number = 4326;
		
		
		/**
		 * Formats the coordinate postion measurement into a string to displayed on the map.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>point [MapPoint]: </i>The map point that represents the location whose coordinates should be labelled.</li>
		 * <li><i>numberFormatter [NumberFormatter]: </i>Spark number formatter to use to format the area number into text to be displayed.</li>
		 * </ul>
		 * </p>
		 */
		public static function createPointMeasurementLabel(point:MapPoint, numberFormatter:NumberFormatter = null):String
		{
			// Check for a supplied number formatter
			if (!numberFormatter)
			{
				// A number formatter was not supplied - create a new one with default settings
				numberFormatter = new NumberFormatter();
				numberFormatter.groupingSeparator = ",";
				numberFormatter.useGrouping = true;
			}

			// Check for geographic coordinates
			var wkid:Number = point.spatialReference.wkid;
			if (wkid == EPSG_GEOGRAPHIC)
			{
				numberFormatter.fractionalDigits = 6;
				return "Longitude: " + numberFormatter.format(point.x) +
					"\n" + "Latitude: " + numberFormatter.format(point.y);
			}
			else
			{
				numberFormatter.fractionalDigits = 0;
				return "X: " + numberFormatter.format(point.x) +
					"\n" + "Y: " + numberFormatter.format(point.y);
			}
		}

		/**
		 * Formats the X coordinate of a point postion measurement into a string to displayed on the map.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>point [MapPoint]: </i>The map point that represents the location whose coordinates should be labelled.</li>
		 * <li><i>numberFormatter [NumberFormatter]: </i>Spark number formatter to use to format the area number into text to be displayed.</li>
		 * </ul>
		 * </p>
		 */
		public static function createPointXMeasurementLabel(point:MapPoint, numberFormatter:NumberFormatter = null):String
		{
			// Check for a supplied number formatter
			if (!numberFormatter)
			{
				// A number formatter was not supplied - create a new one with default settings
				numberFormatter = new NumberFormatter();
				numberFormatter.groupingSeparator = ",";
				numberFormatter.useGrouping = true;
			}
			
			// Check for geographic coordinates
			var wkid:Number = point.spatialReference.wkid;
			if (wkid == EPSG_GEOGRAPHIC)
			{
				numberFormatter.fractionalDigits = 6;
				return numberFormatter.format(point.x);
			}
			else
			{
				numberFormatter.fractionalDigits = 0;
				return numberFormatter.format(point.x);
			}
		}

		/**
		 * Formats the Y coordinate of a point postion measurement into a string to displayed on the map.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>point [MapPoint]: </i>The map point that represents the location whose coordinates should be labelled.</li>
		 * <li><i>numberFormatter [NumberFormatter]: </i>Spark number formatter to use to format the area number into text to be displayed.</li>
		 * </ul>
		 * </p>
		 */
		public static function createPointYMeasurementLabel(point:MapPoint, numberFormatter:NumberFormatter = null):String
		{
			// Check for a supplied number formatter
			if (!numberFormatter)
			{
				// A number formatter was not supplied - create a new one with default settings
				numberFormatter = new NumberFormatter();
				numberFormatter.groupingSeparator = ",";
				numberFormatter.useGrouping = true;
			}
			
			// Check for geographic coordinates
			var wkid:Number = point.spatialReference.wkid;
			if (wkid == EPSG_GEOGRAPHIC)
			{
				numberFormatter.fractionalDigits = 6;
				return numberFormatter.format(point.y);
			}
			else
			{
				numberFormatter.fractionalDigits = 0;
				return numberFormatter.format(point.y);
			}
		}
		
		/**
		 * Formats the area and length measurements into a string to displayed on the map.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>area [Number]: Area value to be displayed in the label.</i></li>
		 * <li><i>areaLabel [String]: Text to include in the label immediately before the area value.</i></li>
		 * <li><i>areaUnitText [String]: Text to describe the units of measurement to include in the label immediately after the area value.</i></li>
		 * <li><i>areaPrecision [Number]: Number of digits after the decimal point to display in the area value.</i></li>
		 * <li><i>length [Number]: Length (perimeter) value to be displayed in the label.</i></li>
		 * <li><i>lengthLabel [String]: Text to include in the label immediately before the length value.</i></li>
		 * <li><i>lengthUnitText [String]: Text to describe the units of measurement to include in the label immediately after the length value.</i></li>
		 * <li><i>lengthPrecision [Number]: Number of digits after the decimal point to display in the length value.</i></li>
		 * <li><i>numberFormatter [NumberFormatter]: </i>Spark number formatter to use to format the area and length numbers into text to be displayed.</li>
		 * </ul>
		 * </p>
		 */
		public static function createAreasAndLengthsLabel(area:Number, areaLabel:String, areaUnitText:String, areaPrecision:Number,
													length:Number, lengthLabel:String, lengthUnitText:String, lengthPrecision:Number, 
													numberFormatter:NumberFormatter = null):String
		{
			// Check for a supplied number formatter
			if (!numberFormatter) 
			{
				// A number formatter was not supplied - create a new one with default settings
				numberFormatter = new NumberFormatter();
				numberFormatter.groupingSeparator = ",";
				numberFormatter.useGrouping = true;
			}

			// Prepare label string to return
			var label:String = "";
			
			// Check if area value was supplied
			if (area && area > 0)
			{
				// Set area units precisions
				numberFormatter.fractionalDigits = areaPrecision;
				
				// Format area label
				label = areaLabel + " " + numberFormatter.format(area) + " " + areaUnitText;
			}

			// Check if length value was supplied
			if (length && length > 0)
			{
				// Set length units precisions
				numberFormatter.fractionalDigits = lengthPrecision;

				// Add a linebreak if an area value has been supplied
				if (label.length > 0)
				{
					label += "\n";
				}
				
				// Format length label
				label += lengthLabel + " " + numberFormatter.format(length) + " " + lengthUnitText;
			}
			
			return label;
		}
		
		/**
		 * Formats the length measurement into a string to displayed on the map.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>length [Number]: Length (perimeter) value to be displayed in the label.</i></li>
		 * <li><i>lengthLabel [String]: Text to include in the label immediately before the length value.</i></li>
		 * <li><i>lengthUnitText [String]: Text to describe the units of measurement to include in the label immediately after the length value.</i></li>
		 * <li><i>lengthPrecision [Number]: Number of digits after the decimal point to display in the length value.</i></li>
		 * <li><i>numberFormatter [NumberFormatter]: </i>Spark number formatter to use to format the length number into text to be displayed.</li>
		 * </ul>
		 * </p>
		 */
		public static function createLengthsLabel(length:Number, lengthLabel:String, lengthUnitText:String, lengthPrecision:Number, 
											numberFormatter:NumberFormatter = null):String
		{
			// Check for a supplied number formatter
			if (!numberFormatter)
			{
				// A number formatter was not supplied - create a new one with default settings
				numberFormatter = new NumberFormatter();
				numberFormatter.groupingSeparator = ",";
				numberFormatter.useGrouping = true;
			}

			// Set length units precisions
			numberFormatter.fractionalDigits = lengthPrecision;
			return lengthLabel + " " + numberFormatter.format(length) + " " + lengthUnitText;
		}
	}
}