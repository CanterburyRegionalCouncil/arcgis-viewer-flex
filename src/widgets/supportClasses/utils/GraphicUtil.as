package widgets.supportClasses.utils
{
	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.*;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.ags.layers.Layer;
	import com.esri.ags.layers.supportClasses.Field;
	import com.esri.ags.layers.supportClasses.LayerDetails;
	import com.esri.ags.layers.supportClasses.LayerInfo;
	import com.esri.ags.utils.GraphicUtil;
	
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.utils.ObjectUtil;
	
	import widgets.supportClasses.*;
	 
	public class GraphicUtil extends com.esri.ags.utils.GraphicUtil
	{
		public function GraphicUtil()
		{
			super();
		}
		
		/**
		 * Reconstitutes a serialised graphic. 
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>object [Object]: </i>Generic object to be deserialised back into a graphic.  Must have been created using the GraphicToSerialObject function.</li>
		 * </ul>
		 * </p> 
		 */
		public static function SerialObjectToGraphic(object:Object):Graphic
		{
			// Create a new graphic
			var graphic:Graphic = new Graphic();
			
			// Check that an object was passed through
			if (object)
			{
				// Check the object for a geometry object
				if (object.geometry)
				{
					graphic.geometry = GeometryUtil.ObjectToGeometry(object.geometry);
				}
				
				// Check the object for a symbol object
				if (object.symbol)
				{
					graphic.symbol = SymbolUtil.SerialObjectToSymbol(object.symbol);
				}
				
				// Check the object for an attributes object
				if (object.attributes)
				{
					graphic.attributes = object.attributes;
				} 
				else
				{
					graphic.attributes = {};
				}
			}
			return graphic;
		}
		
		/**
		 * Serialises a graphic to an object that can be saved. 
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>graphic [Graphic]: </i>Graphic to be serialised.</li>
		 * </ul>
		 * </p> 
		 */
		public static function GraphicToSerialObject(graphic:Graphic):Object
		{
			var object:Object = {};
			object.geometry = GeometryUtil.GeometryToObject(graphic.geometry);
			object.attributes = graphic.attributes;
			object.symbol = SymbolUtil.SymbolToSerialObject(graphic.symbol);
			return object;			
		}
		
		/**
		 * Makes an exact copy of an existing graphic
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>graphic [Graphic]: </i>Graphic to be duplicated.</li>
		 * </ul>
		 * </p> 
		 */ 
		public static function CopyGraphic(copyGraphic:Graphic):Graphic
		{
			// Copy the graphic
			var graphic:Graphic = new Graphic();
			graphic.geometry = GeometryUtil.DuplicateGeometry(copyGraphic.geometry);
			graphic.symbol = SymbolUtil.DuplicateSymbol(copyGraphic.symbol);
			var attributes:Object = {};
			for (var fieldname:String in copyGraphic.attributes)
			{
				attributes[fieldname] = copyGraphic.attributes[fieldname];
			}
			graphic.attributes = attributes; //copyGraphic.attributes;
			return graphic;			
		}
		
		/**
		 * Returns the combined extent of all the graphics in the supplied collection.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>graphics [ArrayCollection]: </i>Array collection of graphics.  
		 * The graphics should all utilise the same spatial reference</li>
		 * <li><i>pointTolerance [int]: </i>Distance in map units to apply to 
		 * point geometry to generate an extent to use in this function</li>
		 * </ul>
		 * </p> 
		 */
		public static function ReturnGraphicsExtent(graphics:ArrayCollection, pointTolerance:Number = 5):Extent
		{
			var ext:Extent;
			var pt:MapPoint;
			var count:int = 0;
			
			for each (var graphic:Graphic in graphics)
			{
				if (count == 0)
				{
					if (graphic.geometry)
					{
						if (graphic.geometry.type == Geometry.MAPPOINT)
						{
							pt = graphic.geometry as MapPoint;
							ext = generatePointExtent(pt,pointTolerance);	
						}
						else
						{
							ext = graphic.geometry.extent;					
						}
						
						// Update the count flag
						count += 1;
					}
				}
				else
				{
					if (graphic.geometry)
					{
						// Check that the geometry spatial reference matches the ext spatial refrence
						if (graphic.geometry.spatialReference.wkid == ext.spatialReference.wkid)
						{
							var graphicExtent:Extent;
							if (graphic.geometry.type == Geometry.MAPPOINT)
							{
								pt = graphic.geometry as MapPoint;
								graphicExtent = generatePointExtent(pt,pointTolerance);	
							}
							else
							{
								graphicExtent = graphic.geometry.extent;					
							}
							ext = ext.union(graphicExtent);
						}
					}
				}
			}
			
			function generatePointExtent(pt:MapPoint,pointTolerance:Number):Extent
			{
				return new Extent(pt.x - pointTolerance,pt.y - pointTolerance,pt.x + pointTolerance, 
					pt.y + pointTolerance, pt.spatialReference);
			}
			
			return ext;
		}
		
		/**
		 * 
		 */
		public static function graphicAttributesToCSV(graphics:Array, isIdentify:Boolean = false, details:LayerDetails = null):void
		{
			try
			{
				var csv:String = "";
				var field:Field;
				var name:String;
				
				if (details) 
				{
					for each (field in details.fields)
					{
						csv += field.alias + ",";
					}
				} 
				else 
				{
					for (name in graphics[0].attributes)
					{
						csv += name + ",";
					}
				}
				
				// Trim off last comma
				csv = csv.substring(0,csv.length -1) + "\n";
				
				for each (var graphic:Graphic in graphics)
				{
					if (details)
					{
						for each (field in details.fields)
						{
							if (isIdentify)
							{
								csv += graphic.attributes[field.alias] + ",";
							}
							else
							{
								csv += graphic.attributes[field.name] + ",";
							}
						}
					}
					else
					{
						for (name in graphic.attributes)
						{
							csv += graphic.attributes[name] + ",";
						}
					}
				}
				
				// Trim off last comma
				csv = csv.substring(0,csv.length -1) + "\n";
				
				// Prepare			
				var fr:FileReference = new FileReference();
				var defaultFileName:String = "Export.csv";
				
				fr.save(csv,defaultFileName);
			}
			catch(error:Error)
			{
				Alert.show(error.message);
			}
		}
		
		
	}
}