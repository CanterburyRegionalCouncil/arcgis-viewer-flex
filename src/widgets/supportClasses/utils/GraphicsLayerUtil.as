package widgets.supportClasses.utils
{
	import com.adobe.serializers.json.JSONEncoder;
	import com.esri.ags.FeatureSet;
	import com.esri.ags.Graphic;
	import com.esri.ags.layers.GraphicsLayer;

	public class GraphicsLayerUtil
	{
		public function GraphicsLayerUtil()
		{
			/**
			 * Returns an object representing a json arcgis featureset object.  User must supply a valid geometry type as feauresets can only contain 
			 * a single geometry type.  Graphics utilising a text symbol will be considered a label, and will be filtered out of the results by default. 
			 * Generic attributes will be included - attributes that the graphic includes will not be translated into the output.
			 * <p>
			 * <b>Parameters</b><br/>
			 * <ul>
			 * <li><i>layer [GraphicsLayer]: </i>Graphics layer to translated into a featureset json object.</li>
			 * <li><i>geometryType [String]: </i>Geometry type to be used in the output featureset.  Only graphics with this geometry type will be included in the output.  
			 * Accepts the standard Geometry types.</li>
			 * <li><i>includeLabels [Boolean] (optional): </i>Specify whether to include label points in the output set.  If true, the geometry must be a MapPoint to be accepted.
			 * Defaults to false.</li>
			 * </ul>
			 * </p>  		 
			 */
			public static function graphicsLayerToArcGISFeaturesetJson(layer:GraphicsLayer, geometryType:String, includeLabels:Boolean = false):Object
			{
				var result:Object;
				var features:Array = [];
				var id:int = 0;
				for each (var graphic:Graphic in layer.graphicProvider)
				{
					// Check if the geometry of the graphic is of the required type
					if (graphic.geometry && graphic.geometry.type == geometryType)
					{
						// Create the attributes object and populate with objects
						var attributes = {};

						// Add a unique object id
						id ++;
						attributes.id = id;
						
						// Create a new feature
						var feature:Graphic = new Graphic(graphic.geometry, null, attributes);
						features.push(feature);						
					}
				}
				
				var fset:FeatureSet = new FeatureSet(features);
						
				result = fset.toJSON();
				
				
				return result;
			}
		}
	}
}