package widgets.LocatePoint.components
{
	import mx.validators.ValidationResult;
	import mx.validators.Validator;
	
	public class GridCoordinateValidator extends Validator
	{
		public function GridCoordinateValidator()
		{
			super();
		}
	
		public static const GridXCoordinate:String = "gridXCoordinate";	
		public static const GridYCoordinate:String = "gridYCoordinate";	
		

		// Coordinate Range Object Property

		private var _coordinateRange:Object;
		
		public function get coordinateRange():Object
		{
			return _coordinateRange;
		}
		
		public function set coordinateRange(value:Object):void
		{
			_coordinateRange = value;
		}

		
		// Coordinate Type Property
		
		private var _coordinateType:String = GridXCoordinate;
		
		public function get coordinateType():String
		{
			return _coordinateType;
		}
		
		[Inspectable (category="General",defaultValue="gridXCoordinate", enumeration="gridXCoordinate,gridYCoordinate")]
		public function set coordinateType(value:String):void
		{
			_coordinateType = value;
		}
		
		/* --------------------------------------------------------------------
		Validation functions
		-------------------------------------------------------------------- */

		override protected function doValidation(value:Object):Array
		{
			var resultArray:Array = [];  
			
			// Check for a null value
			if(value == null || _coordinateRange == null)  
			{  
				resultArray.push(new ValidationResult(true, "", "", "Validation Failed"));  
			}  
			else if (!validateCoordinate(value as String))
			{
				// Check for a valid range value
				resultArray.push(new ValidationResult(true, "", "", "Value out of Valid Range"));  
			}

			return resultArray;
		}
		
		private function validateCoordinate(value:String):Boolean
		{
			var result:Boolean = true;
			
			var minText:String;
			var maxText:String;
			
			if (_coordinateType == GridXCoordinate)
			{
				// Get the x values
				minText = String(_coordinateRange.@xmin).substr(2,5);
				maxText = String(_coordinateRange.@xmax).substr(2,5);
			}
			else
			{
				// Get the y values
				minText = String(_coordinateRange.@ymin).substr(2,5);
				maxText = String(_coordinateRange.@ymax).substr(2,5);
			}
			
			// Convert to numbers
			var minVal:Number = Number(minText);
			var maxVal:Number = Number(maxText);
			
			// Check for a split value i.e. the range extends over 100000.
			var isSplit:Boolean = (maxVal < minVal);
			
			// Format the text to validate
			var checkText:String = value as String;
			
			// Pad out to 5 digits
			while (checkText.length < 5)
			{
				checkText += "0";	
			}
			
			// Convert to number
			var checkVal:Number = Number(checkText);
			
			// Validate the value
			if (isSplit)
			{
				if ((minVal <= checkVal && checkVal <= 100000) ||
					(0 <= checkVal && checkVal <= maxVal))
				{
					// Do nothing - valid range 					
				}
				else
				{
					result = false;
				}
			}
			else
			{
				if (minVal >= checkVal || checkVal >= maxVal)
				{
					result = false;
				}
			}
			
			return result;
		}
		
	}
}