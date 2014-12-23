package widgets.supportClasses.utils
{
	import com.esri.ags.Map;
	import com.esri.ags.layers.ArcGISDynamicMapServiceLayer;
	import com.esri.ags.layers.ArcGISImageServiceLayer;
	import com.esri.ags.layers.ArcGISTiledMapServiceLayer;
	import com.esri.ags.layers.ArcIMSMapServiceLayer;
	import com.esri.ags.layers.Layer;
	import com.esri.ags.layers.FeatureLayer;
	import com.esri.ags.layers.GraphicsLayer;
	import com.esri.ags.layers.GPResultImageLayer;
	
	import com.esri.ags.tools.PolygonVertexLayer;
	import com.esri.ags.tools.PolylineVertexLayer;
	
	import mx.collections.ArrayCollection;
	
	public class MapUtil
	{
		/**
		 * Iterates over all map layers and passes each one to the given function.
		 *
		 * @param func  A function with the signature <code>func( layer :Layer ) :void</code>.
		 */
		public static function forEachMapLayer(map:Map, func:Function):void
		{
			if (map)
			{
				for each (var layer:Layer in map.layers)
				{
					func(layer);
				}
			}
		}
		
		/**
		 * Returns a suitable label for the specified map layer.
		 * Returns null if no label can be determined.
		 */
		public static function labelLayer(layer:Layer):String
		{
			var label:String = null;
			
			if (layer.id == "")
			{
				// Tiled layers
				if (layer is ArcGISTiledMapServiceLayer)
				{
					label = extractServiceNameFromUrl((layer as ArcGISTiledMapServiceLayer).url);
					
					// Dynamic layers
				}
				else if (layer is ArcGISDynamicMapServiceLayer)
				{
					label = extractServiceNameFromUrl((layer as ArcGISDynamicMapServiceLayer).url);
				}
				else if (layer is ArcGISImageServiceLayer)
				{
					label = extractServiceNameFromUrl((layer as ArcGISImageServiceLayer).url);
				}
				else if (layer is ArcIMSMapServiceLayer)
				{
					label = (layer as ArcIMSMapServiceLayer).serviceName;
				}
				else if (layer is FeatureLayer)
				{
					label = extractServiceNameFromUrl((layer as FeatureLayer).url);
				}
				else if (layer is GPResultImageLayer)
				{
					label = "(Task Result) " + extractServiceNameFromUrl((layer as GPResultImageLayer).url);
					
					// Graphics layers
				}
				else if (layer is GraphicsLayer)
				{
					label = "Graphics";
				}
			}
			else
			{
				label = layer.name;
			}
			return label;
		}
		
		// These tokens must be lowercase.
		private static const IGNORE_URL_TOKENS:Array =
			[
				"mapserver",
				"wmsserver",
				"imageserver",
				"globeserver",
				"gpserver",
				"http:",
				"https:"
			];
		
		/**
		 * Returns then service name component from a layers url.
		 */
		public static function extractServiceNameFromUrl(url:String):String
		{
			/*
			ArcGIS URL formats:
			http://<host>/<instance>/rest/services/<service>/MapServer
			http://<host>/<instance>/rest/services/<service>/ImageServer
			http://<host>/<instance>/rest/services/<service>/GPServer/<task>
			...
			*/
			
			// Extract the <service> part of the URL
			if (url)
			{
				// Remove any query params
				var queryPos:int = url.indexOf("?");
				if (queryPos != -1)
				{
					url = url.substring(0, queryPos);
				}
				
				// Search for the service name token
				var urlParts:Array = url.split("/").reverse();
				for each (var s:String in urlParts)
				{
					if (s && s != "" && IGNORE_URL_TOKENS.indexOf(s.toLowerCase()) == -1)
					{
						return s;
					}
				}
			}
			return null;
		}
		
		/**
		 * Returns an array of all Polyline vertex layers currently in the map.  
		 * Polyline vertex layers are utilised by the edit tool to display and 
		 * edit the vertices of the editable shape. 
		 */ 
		public static function getPolylineVertexLayers(map:Map):Array
		{
			var pLayers:Array = [];
			for each (var layer:Layer in map.layers)
			{
				if (layer is PolylineVertexLayer)
				{
					pLayers.push(layer);
				}
			}
			return pLayers; 
		}
		
		/**
		 * Returns an array of all Polygon vertex layers currently in the map.  
		 * Polygon vertex layers are utilised by the edit tool to display and 
		 * edit the vertices of the editable shape. 
		 */ 
		public static function getPolygonVertexLayers(map:Map):Array
		{
			var pLayers:Array = [];
			for each (var layer:Layer in map.layers)
			{
				trace("PVL: " + layer.name);
				if (layer is PolygonVertexLayer)
				{
					pLayers.push(layer);
				}
			}
			return pLayers; 
		}			
		
		/** 
		 * Checks for the existence of a graphics layer with the supplied name.
		 * If a graphics layer with that name is not located, the function creates a graphics layer with the supplied name and adds it to the map.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>layerID [String]: </i>ID of the graphics layer to search for and be retrieved.</li>
		 * <li><i>map [Map]: </i>Map component which should contain the feature layer.</li>
		 * <li><i>layerName [String] (optional): </i>Name to use for the layer (default is the same as the layer id).</li>
		 * </ul>
		 * </p> 
		 */
		public static function checkGraphicLayer(layerID:String, map:Map, layerName:String = ""):GraphicsLayer 
		{
			// Loop through each layer in the map
			for each(var layer:Layer in map.layers) 
			{
				// Only interested if it is a graphics layer
				if(layer is GraphicsLayer) 
				{
					if(layer.id === layerID) 
					{
						// If it already exists then we can leave the function
						return layer as GraphicsLayer;
					}
				}
			}
			
			// If we get this far we need to create the graphics layer and add it to the map
			var graphicsLayer:GraphicsLayer = new GraphicsLayer;
			
			// Set the name/id of the graphics layer 
			graphicsLayer.id = layerID;
			
			if (layerName == "")
			{
				graphicsLayer.name = graphicsLayer.id;
			}
			else
			{
				graphicsLayer.name = layerName;
			}
			
			// Add the layer to the map
			map.addLayer(graphicsLayer);
			
			// Return the result 
			return graphicsLayer;
		}
		
		/**
		 * Returns the feature layer from a map with the given url.  Can be passed an array collection of map layers or a map component.  One of the two options should be supplied.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>featureLayerURL [String]: </i>Rest service endpoint url for the layer to be retrieved.</li>
		 * <li><i>gdbVersion [String]: </i>Geodatabase version id for the layer to be returned.</li>
		 * <li><i>map [Map] (optional): </i>Map component which should contain the feature layer.</li>
		 * <li><i>collection [ArrayCollection] (optional): </i>List of map layers which should contain the feature layer.</li>
		 * </ul>
		 * </p> 
		 */
		public static function getFeatureLayerFromMap(featureLayerURL:String, gdbVersion:String, map:Map=null, collection:ArrayCollection=null):FeatureLayer
		{
			var result:FeatureLayer;
			
			// Get the map list
			var mapLayers:ArrayCollection;
			
			if (map != null) {  			
				mapLayers = map.layers as ArrayCollection;
			}
			
			if (collection != null) {  			
				mapLayers = collection;
			}
			
			if (mapLayers != null ) {
				// loop through all the map layers
				for (var n:int = 0; n < mapLayers.length; )
				{
					if (mapLayers.getItemAt(n) is FeatureLayer
						&& FeatureLayer(mapLayers.getItemAt(n)).url == featureLayerURL
						&& FeatureLayer(mapLayers.getItemAt(n)).gdbVersion == gdbVersion)
					{
						result = mapLayers.getItemAt(n) as FeatureLayer;
						break;
					}
					else
					{
						n++;
					}
				}
			}			
			return result;
		}
		
		/**
		 * Returns all  of the feature layer from a map.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>map [Map] (optional): </i>Map component from which the feature layers should be extracted.</li>
		 * </ul>
		 * </p> 
		 */
		public static function getFeatureLayersFromMap(map:Map):ArrayCollection
		{
			var result:ArrayCollection = new ArrayCollection();
			
			var mapLayers:ArrayCollection;
			if (map != null) {  			
				mapLayers = map.layers as ArrayCollection;
				
				for (var n:int = 0; n < mapLayers.length; )
				{
					if (mapLayers.getItemAt(n) is FeatureLayer)
					{
						result.addItem(mapLayers.getItemAt(n));
					}
					n++;
				}
			}
			
			return result;
		}
	}
}