package widgets.supportClasses.utils
{
	import com.esri.ags.geometry.MapPoint;

	public class MapGridUtil
	{
		
		/* Util Variables
		-------------------------------------------------------------------- */

		protected var _mapGridSheets:XMLList;
		protected var _mapGridFormat:String = "{0}:{1}-{2}";
		protected var _mapGridPrecision:Number = 3;


		/* Map Grid Sheets List Property
		-------------------------------------------------------------------- */

		/**
		 * XMLList of the grid sheet definitions.
		 */
		public function get MapGridData():XMLList
		{
			return _mapGridSheets;
		}
		
		public function set MapGridData(value:XMLList):void
		{
			_mapGridSheets = value;			
		}
		
		
		/* Map Grid Format Property
		-------------------------------------------------------------------- */
		
		/**
		 * Format string to display the map grid in.
		 */
		public function get MapGridFormat():String
		{
			return _mapGridFormat;
		}
		
		public function set MapGridFormat(value:String):void
		{
			if(value == null)
			{
				_mapGridFormat = "{0}:{1}-{2}";
			} 
			else
			{
				_mapGridFormat = value;
			}
		}
		
		
		/* Map Grid Format Property
		-------------------------------------------------------------------- */
		
		/**
		 * Number of digits to display.
		 */
		public function get MapGridPrecision():int
		{
			return _mapGridPrecision;
		}
		
		public function set MapGridPrecision(value:int):void
		{
			if (value < 3)
			{
				_mapGridPrecision = 3;
			}
			else if (value > 5)
			{
				_mapGridPrecision = 5;
			}
			else
			{
				_mapGridPrecision = value;		
			}
		}
		
		
		/* Util Constructor
		-------------------------------------------------------------------- */
		
		public function MapGridUtil()
		{
		}

		/**
		 * Generates a map grid reference for the given point;
		 */ 
		public function getMapReference(pt:MapPoint):String
		{
			var gridref:String = "";
			
			if (pt && _mapGridSheets)
			{
				var x:Number = pt.x;
				var y:Number = pt.y;
				
				// Find the mapsheet
				var sheets:XMLList = _mapGridSheets.(@xmin <= x && @xmax >= x && @ymin <= y && @ymax >= y);
				
				if(sheets.length() > 0)
				{
					var mapsheet:String = sheets[0].@sheet;
					var xpart:String = int(x).toString().substr(2,_mapGridPrecision);
					var ypart:String = int(y).toString().substr(2,_mapGridPrecision);
					
					gridref = _mapGridFormat.replace("{0}",mapsheet).replace("{1}",xpart).replace("{2}",ypart);
				}
			}
			return gridref;
		}

	
	}
}