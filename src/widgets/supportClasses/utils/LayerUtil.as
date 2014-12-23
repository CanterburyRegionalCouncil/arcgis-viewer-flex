package widgets.supportClasses.utils
{
	import com.esri.ags.Graphic;
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.Extent;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.layers.ArcGISDynamicMapServiceLayer;
	import com.esri.ags.layers.ArcGISTiledMapServiceLayer;
	import com.esri.ags.layers.FeatureLayer;
	import com.esri.ags.layers.Layer;
	import com.esri.ags.layers.supportClasses.CodedValue;
	import com.esri.ags.layers.supportClasses.CodedValueDomain;
	import com.esri.ags.layers.supportClasses.DrawingInfo;
	import com.esri.ags.layers.supportClasses.FeatureLayerDetails;
	import com.esri.ags.layers.supportClasses.FeatureTableDetails;
	import com.esri.ags.layers.supportClasses.FeatureTemplate;
	import com.esri.ags.layers.supportClasses.FeatureType;
	import com.esri.ags.layers.supportClasses.Field;
	import com.esri.ags.layers.supportClasses.LayerDetails;
	import com.esri.ags.layers.supportClasses.LayerInfo;
	import com.esri.ags.layers.supportClasses.LayerInfoWindowRenderer;
	import com.esri.ags.portal.PopUpRenderer;
	import com.esri.ags.portal.supportClasses.PopUpFieldFormat;
	import com.esri.ags.portal.supportClasses.PopUpFieldInfo;
	import com.esri.ags.portal.supportClasses.PopUpInfo;
	import com.esri.ags.portal.supportClasses.PopUpMediaInfo;
	import com.esri.ags.tasks.supportClasses.Query;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	
	public class LayerUtil
	{
		/**
		 * Returns a field with the given name (if exists) from a layer details object.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>layerdetails [LayerDetails]: </i>LayerDetails object for a featurelayer or a sub-layer from an 
		 * ArcGISTiled or ArcGISDynamic Map Service layer.</li>
		 * <li><i>fieldName [String]: </i>Name of the field whose details are to be returned.  <b>This should be the 
		 * full fieldname, not the field alias.</b></li>
		 * </ul>
		 * </p>  		 
		 */
		public static function getField(layerdetails:LayerDetails, fieldname:String):Field
		{
			var field:Field;
			
			// Make sure that a list of fields and a fieldname was supplied
			if (layerdetails && layerdetails.fields && fieldname)
			{
				// Iterate through each of the supplied fields
				for (var i:int = 0; i < layerdetails.fields.length; i++)
				{
					// Check to see if the name attribute equals the given field name
					if (String(layerdetails.fields[i].name).toUpperCase() == fieldname.toUpperCase())
					{
						field = layerdetails.fields[i] as Field;
						break;
					}
				}
			}
			
			// Return the result
			return field;
		}		
		
		/**
		 *  Returns if a feature layer contains a field with the given name
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>layerdetails [LayerDetails]: </i>LayerDetails object for a featurelayer or a sub-layer from an 
		 * ArcGISTiled or ArcGISDynamic Map Service layer.</li>
		 * <li><i>fieldName [String]: </i>Name of the field whose presence should be checked for.  <b>This should 
		 * be the full fieldname, not the field alias.</b></li>
		 * </ul>
		 * </p> 		 
		 */
		public static function hasField(layerdetails:LayerDetails, fieldName:String):Boolean
		{
			var found:Boolean = false;
			for each (var field:Field in layerdetails.fields)
			{
				if (field.name.toUpperCase() == fieldName.toUpperCase())
				{	
					found = true;
					break;
				}
			}
			return found;
		}
		
		/**
		 * Returns an array containing the attributes of a collection of graphics
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>graphics [ArrayCollection]: </i>Array collection of graphic features.  This could be a graphic 
		 * provider from a graphic or feature layer.</li>
		 * </ul>
		 * </p> 	
		 */
		public static function getGraphicAttributes(graphics:ArrayCollection):Array
		{
			var attributes:Array = new Array();
			
			for each (var graphic:Graphic in graphics)
			{
				attributes.push(graphic.attributes);
			}
			
			// Return the result array
			return attributes;
		}
		
		/**
		 * Updates the selection records of a Feature Layer when utilised in Selection Mode.  The selection criteria 
		 * can be specified as a SQL Query statement and/or a geometry (a minimum of one of these options should be 
		 * specified).
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>queryLayer [FeatureLayer]: </i>Feature layer in Selection Mode whose current selection is to be modified.</li>
		 * <li><i>selectionMode [String]: </i>The select action to be applied.  Possible values include new, add, and subtract.</li>
		 * <li><i>queryText [String] (optional): </i>SQL Statement used to apply to the selection of the feature layer.</li>
		 * <li><i>queryShape [Geometry] (optional): </i>Geometry shape used to apply to the selection of the feature layer.</li>
		 * <li><i>outSpatialReference [SpatialReference] (optional): </i>Spatial reference object to specify what spatial reference 
		 * the features that are returned as part of the query should utilise.  Important to use when using layers that have a 
		 * spatial referece that differs from the one being utilised in the map.</li>
		 * </ul>
		 * </p> 	
		 */
		public static function updateSelection(queryLayer:FeatureLayer, 
											   selectionMode:String = FeatureLayer.SELECTION_NEW, 
											   queryText:String = null, queryShape:Geometry = null, 
											   outSpatialReference:SpatialReference = null):void
		{
			// Construct the query
			var query:Query = new Query();
			
			if (queryText)
				query.where = queryText;
			
			if (queryShape)
				query.geometry = queryShape;
			
			if (outSpatialReference)
				query.outSpatialReference = outSpatialReference;
			
			// Execute the query
			queryLayer.selectFeatures(query, selectionMode);
		}
		
		/** 
		 * Returns the feature type for the given layer.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>typeID [String]: </i>Subtype id value of the subtype if the feature layer utilises subtypes.</li>
		 * <li><i>layer [FeatureLayer]: </i>Feature layer that is beuing utilised.  Feature layers contain all of the field
		 * and domain settings.</li>
		 * </ul>
		 * </p>  
		 */
		public static function getFeatureType(typeID:String, layer:FeatureLayer):FeatureType
		{
			var result:FeatureType;
			
			// Confirm that a layer was supplied
			if (layer)
			{
				// Iterate through the fetaure types of the layer
				for each (var featureType:FeatureType in layer.layerDetails.types)
				{
					if (typeID == featureType.id)
					{
						result = featureType;
						break;
					}
				}
			}
			
			// Return the result
			return result;
		}
		
		/**
		 * Returns the coded value associated with the specified code from a coded value domain on a field in a feature layer.  
		 * Used to get the display value of the field rather than the code vakue.   
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>fieldName [String]: </i>Name of the field that contains the coded domain details.</li>
		 * <li><i>fieldValue [String]: </i>Value object to return the coded value for.</li>
		 * <li><i>typeID [String]: </i>Subtype id value of the subtype if the feature layer utilises subtypes.</li>
		 * <li><i>layer [FeatureLayer]: </i>Feature layer that is beuing utilised.  Feature layers contain all of the field
		 * and domain settings.</li>
		 * <li><i>domainsCache [Object]: </i>Object that either contains the domain settings or will be populated with the 
		 * domain settings.  Used for caching the domain values in order to make future calls to the function quicker and less
		 * intensive.</li>
		 * </ul>
		 * </p>  
		 */
		public static function getCodedValue(fieldName:String, fieldValue:String, typeID:String, 
											 layer:FeatureLayer, domainsCache:Object):CodedValue
		{
			var result:CodedValue;
			
			if (!domainsCache)
			{
				domainsCache = {}; // map from (fieldName + typeID) to CodedValueDomain
			}
			
			var domainsKey:String = fieldName + typeID;
			var codedValueDomain:CodedValueDomain;
			
			if (domainsKey in domainsCache)
			{
				codedValueDomain = domainsCache[domainsKey];
			}
			else
			{
				if (typeID)
				{
					var featureType:FeatureType = getFeatureType(typeID, layer);
					if (featureType)
					{
						codedValueDomain = featureType.domains[fieldName] as CodedValueDomain;
					}
				}
				else
				{
					var layerDetails:LayerDetails = layer.layerDetails;
					var field:Field = getField(layerDetails,fieldName);
					if (field)
					{
						codedValueDomain = field.domain as CodedValueDomain;
					}
				}
				domainsCache[domainsKey] = codedValueDomain;
			}
			
			if (codedValueDomain)
			{
				for each (var codedValue:CodedValue in codedValueDomain.codedValues)
				{
					if (fieldValue == codedValue.code)
					{
						result = codedValue;
						break;
					}
				}
			}
			
			return result;
		}
		
		/**
		 * Creates an object based on the popup info settings of the specified ArcGISTiled, ArcGISDynamic or Feature layer.  
		 * Used for serialisation.  If the layer does not contain any popupinfo settings, null is returned.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>layer [Layer]: </i>ArcGIS Tiled, Dynamic or Featurelayer whose popup info details should be serialised.</li>
		 * <li><i>sublayerIDs [Array]: </i>Array of sub layer id numbers representing those sub layers of the main layer whose 
		 * popupInfo details should be serialised. If passed an empty array, all sub layer details will be serialised.  Ignored 
		 * for Feature layers.</li>
		 * </ul>
		 * </p>  
		 */
		public static function serialisePopupInfoSettings(layer:Layer, sublayerIDs:Array = null):Object
		{
			var settings:Object;
			var layerIWR:LayerInfoWindowRenderer;
			var popUpInfos:Array;
			
			// Check layer type 
			if (layer is ArcGISDynamicMapServiceLayer) 
			{
				// Check for popup settings
				var dLayer:ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer(layer);
				if (dLayer.layerInfoWindowRenderers && dLayer.layerInfoWindowRenderers.length > 0)
				{
					// Iterate through each infoRenderer in the array
					for each (layerIWR in dLayer.layerInfoWindowRenderers)
					{
						// Check that sub layer is included
						if (sublayerIDs == null || sublayerIDs.indexOf(layerIWR.layerId) > -1)
						{
							// Generate the serialised object for this infoWindowRenderer
							var dRenderer:Object = serialiseLayerInfoWindowRenderer(layerIWR);
							
							if (settings == null)
							{
								popUpInfos = [];
								popUpInfos.push(dRenderer);
								
								settings = { popUpInfos:popUpInfos };
							}
							else
							{
								settings.popUpInfos.push(dRenderer);
							}
						}
					}
				}
			}
			else if (layer is ArcGISTiledMapServiceLayer)
			{
				// Check for popup settings
				var tLayer:ArcGISTiledMapServiceLayer = ArcGISTiledMapServiceLayer(layer);
				if (tLayer.layerInfoWindowRenderers && tLayer.layerInfoWindowRenderers.length > 0)
				{
					// Iterate through each infoRenderer in the array
					for each (layerIWR in tLayer.layerInfoWindowRenderers)
					{
						// Check that sub layer is included
						if (sublayerIDs == null || sublayerIDs.indexOf(layerIWR.layerId) > -1)
						{
							// Generate the serialised object for this infoWindowRenderer
							var tRenderer:Object = serialiseLayerInfoWindowRenderer(layerIWR);
							
							if (settings == null)
							{
								popUpInfos = [];
								popUpInfos.push(tRenderer);
								
								settings = { popUpInfos:popUpInfos };
							}
							else
							{
								settings.popUpInfos.push(tRenderer);
							}
						}
					}
				}
			}
			else if (layer is FeatureLayer)
			{
				// Check for popup settings
				var fLayer:FeatureLayer = FeatureLayer(layer);
				if (fLayer.infoWindowRenderer)
				{
					// Get the popup info details
					var popupInfo:PopUpInfo = ClassFactory(fLayer.infoWindowRenderer).properties.popUpInfo as PopUpInfo;
					
					// Generate the popup info details
					var info:Object = serialisePopupInfo(popupInfo);
					
					popUpInfos = [];
					popUpInfos.push(info);
					
					settings = { popUpInfos:popUpInfos };
				}
			}
			
			return settings;
		}
		
		/**
		 * Creates an object based on the popup info settings of the specified LayerInfoWindowRenderer object.  
		 * Used for serialisation.  If the LayerInfoWindowRenderer object does not contain any popupinfo settings, null is returned.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>layerIWR [LayerInfoWindowRenderer]: </i>LayerInfoWindowRenderer object from an ArcGIS Tiled or Dynamic map service 
		 * whose popup info details should be serialised.  This object could contain 1 or more popup settings for the sub-layers.</li>
		 * </ul>
		 * </p>  
		 */
		public static function serialiseLayerInfoWindowRenderer(layerIWR:LayerInfoWindowRenderer):Object
		{
			// Get the popup info details
			var popupInfo:PopUpInfo = ClassFactory(layerIWR.infoWindowRenderer).properties.popUpInfo as PopUpInfo;
			
			// Generate the popup info details
			var info:Object = serialisePopupInfo(popupInfo);
			
			// Append the layer id
			info.layerId = layerIWR.layerId; 
			
			return info;
		}
		
		/**
		 * Creates an object based on the popup info object.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>popupInfo [PopUpInfo]: </i>Popup info object to be serialised.</li>
		 * </ul>
		 * </p>  
		 */
		public static function serialisePopupInfo(popupInfo:PopUpInfo):Object
		{
			var info:Object = {};
			
			// Set popup details
			info.title = popupInfo.title;
			info.description = popupInfo.description;
			info.showAttachments = popupInfo.showAttachments.toString();
			
			// Set the field details
			var fldInfos:Array = [];
			for each (var fld:PopUpFieldInfo in popupInfo.popUpFieldInfos)
			{
				var fldInfo:Object = { fieldName:fld.fieldName, label:fld.label, visible:fld.visible.toString()};
				
				// Apply format details if set
				if (fld.format)
				{
					if (fld.format.dateFormat)
						fldInfo.dateFormat = fld.format.dateFormat;
					
					if (fld.format.precision != -1)
						fldInfo.precision = fld.format.precision;
					
					if (fld.format.useThousandsSeparator)
						fldInfo.useThousandsSeparator = fld.format.useThousandsSeparator.toString();
					
					if(fld.format.useUTC)
						fldInfo.useUTC = fld.format.useUTC.toString();
				}
				
				// Push into the array				
				fldInfos.push(fldInfo);
			}
			info.fieldInfos = fldInfos;
			
			// Set media details
			var mediaInfos:Array = [];
			for each (var media:PopUpMediaInfo in popupInfo.popUpMediaInfos)
			{
				var mediaInfo:Object = { type:media.type, title:media.title, caption:media.caption };
				
				switch (media.type)
				{
					case "columnchart":
					case "piechart":
					case "barchart":
					case "linechart":
					{
						// Get the chart field settings
						mediaInfo.chartFields = media.chartFields.join(";");
						
						// Check for normalisation details
						if (media.chartNormalizationField)
							mediaInfo.chartNormalizationField = media.chartNormalizationField;
						
						// Check for chart stylename details
						if (media.chartSeriesStyleName)
							mediaInfo.chartSeriesStyleName = media.chartSeriesStyleName;
						
						break;
					}
						
					default:
					{
						// Get the image settings							
						mediaInfo.imageSourceURL = media.imageSourceURL;
						
						// Check for link info
						if (media.imageLinkURL)
							mediaInfo.imageLinkURL = media.imageLinkURL;
					}
				}
				
				// Push into the array				
				mediaInfos.push(mediaInfo);
			}
			info.mediaInfos = mediaInfos;			
			
			return info;
		}
		
		/**
		 * Reconsititutes popupinfowindow settings from a serialised object created using the serialiseLayerInfoWindowRenderer 
		 * function and applies it to the saved layer. 
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>settings [Object]: </i>Object containing the saved popupwindow settings created using the 
		 * serialiseLayerInfoWindowRenderer function.<li>
		 * <li><i>layer [Layer]: </i>ArcGIS Tiled, Dynamic or Featurelayer whose popup info details should be serialised.</li>
		 * </ul>
		 * </p>  
		 */
		public static function deserialisePopupInfoSettings(settings:Object, layer:Layer):void
		{
			if (settings != null)
			{
				var info:Object;
				var popUpInfo:PopUpInfo;
				var fldInfo:Object;
				var fldMedia:Object;
				var layerId:int;
				var sublayerId:int;
				var layerInfoWindowRenderer:LayerInfoWindowRenderer;
				var infoWindowRenderer:ClassFactory;
				var layerInforenderers:Array = [];
				
				if (layer is ArcGISDynamicMapServiceLayer)
				{
					var dLayer:ArcGISDynamicMapServiceLayer = ArcGISDynamicMapServiceLayer(layer);
					
					// Iterate through each popup seetings object in the settings
					for each (info in settings.popUpInfos)
					{
						// Get the sub layer ID
						sublayerId = int(info.layerId);
						
						// Create the popup object
						var dPopUp:PopUpInfo = new PopUpInfo();
						dPopUp.title = info.title;
						dPopUp.description = info.description;
						dPopUp.showAttachments = info.showAttachments == "true";
						
						var dFlds:Array = [];
						for each (fldInfo in info.fieldInfos)
						{
							// Create a new field info object
							var dFld:PopUpFieldInfo = new PopUpFieldInfo();
							dFld.fieldName = fldInfo.fieldName;
							dFld.label = fldInfo.label;
							dFld.visible = fldInfo.visible == "true";
							
							// Apply format details
							dFld.format = new PopUpFieldFormat();
							dFld.format.dateFormat = fldInfo.dateFormat;
							
							if (fldInfo.precision)
								dFld.format.precision = fldInfo.precision;
	
							dFld.format.useThousandsSeparator = fldInfo.useThousandsSeparator == "true";
							dFld.format.useUTC = fldInfo.useUTC == "true";
							
							// Append to fields array
							dFlds.push(dFld);
						}
						dPopUp.popUpFieldInfos = dFlds;
						
						var dMeds:Array = [];
						for each (fldMedia in info.mediaInfos)
						{
							var dMed:PopUpMediaInfo = new PopUpMediaInfo();
							dMed.type = fldMedia.type;
							dMed.title = fldMedia.title;
							dMed.caption = fldMedia.caption;
							
							switch (fldMedia.type)
							{
								case "columnchart":
								case "piechart":
								case "barchart":
								case "linechart":
								{
									// Get chart settings
									dMed.chartFields = String(fldMedia.chartFields).split(";");
									
									if (fldMedia.chartNormalizationField)
									{
										dMed.chartNormalizationField = fldMedia.chartNormalizationField;
									}
									
									if (fldMedia.chartSeriesStyleName)
									{
										dMed.chartSeriesStyleName = fldMedia.chartSeriesStyleName;
									}
									break;
								}
									
								default:
								{
									// Get the image settings 
									dMed.imageSourceURL = fldMedia.imageSourceURL;
									if (fldMedia.imageLinkURL)
										dMed.imageLinkURL = fldMedia.imageLinkURL;
								}
							}
							
							dMeds.push(dMed);
						}
						dPopUp.popUpMediaInfos = dMeds;		
						
						// Configure the popup window renderer
						layerInfoWindowRenderer = new LayerInfoWindowRenderer;
						layerInfoWindowRenderer.layerId = sublayerId;
						infoWindowRenderer = new ClassFactory(PopUpRenderer);
						infoWindowRenderer.properties = { popUpInfo: dPopUp };
						layerInfoWindowRenderer.infoWindowRenderer = infoWindowRenderer;
						
						layerInforenderers.push(layerInfoWindowRenderer);
					}

					// Apply Layer Info renderers
					if (layerInforenderers.length > 0)
					{
						dLayer.layerInfoWindowRenderers = layerInforenderers;
					}
				}
				else if (layer is ArcGISTiledMapServiceLayer)
				{
					var tLayer:ArcGISTiledMapServiceLayer = ArcGISTiledMapServiceLayer(layer);
					
					// Iterate through each popup seetings object in the settings
					for each (info in settings.popUpInfos)
					{
						// Get the sub layer ID
						sublayerId = int(info.layerId);
						
						// Create the popup object
						var tPopUp:PopUpInfo = new PopUpInfo();
						tPopUp.title = info.title;
						tPopUp.description = info.description;
						tPopUp.showAttachments = info.showAttachments == "true";
						
						var tFlds:Array = [];
						for each (fldInfo in info.fieldInfos)
						{
							// Create a new field info object
							var tFld:PopUpFieldInfo = new PopUpFieldInfo();
							tFld.fieldName = fldInfo.fieldName;
							tFld.label = fldInfo.label;
							tFld.visible = fldInfo.visible == "true";
							
							// Apply format details
							tFld.format = new PopUpFieldFormat();
							tFld.format.dateFormat = fldInfo.dateFormat;
							if (fldInfo.precision)
								tFld.format.precision = fldInfo.precision;
							tFld.format.useThousandsSeparator = fldInfo.useThousandsSeparator == "true";
							tFld.format.useUTC = fldInfo.useUTC == "true";
							
							// Append to fields array
							tFlds.push(tFld);
						}
						tPopUp.popUpFieldInfos = dFlds;
						
						var tMeds:Array = [];
						for each (fldMedia in info.mediaInfos)
						{
							var tMed:PopUpMediaInfo = new PopUpMediaInfo();
							tMed.type = fldMedia.type;
							tMed.title = fldMedia.title;
							tMed.caption = fldMedia.caption;
							
							switch (fldMedia.type)
							{
								case "columnchart":
								case "piechart":
								case "barchart":
								case "linechart":
								{
									// Get chart settings
									tMed.chartFields = String(fldMedia.chartFields).split(";");
									
									if (fldMedia.chartNormalizationField)
									{
										tMed.chartNormalizationField = fldMedia.chartNormalizationField;
									}
									
									if (fldMedia.chartSeriesStyleName)
									{
										tMed.chartSeriesStyleName = fldMedia.chartSeriesStyleName;
									}
									break;
								}
									
								default:
								{
									// Get the image settings 
									tMed.imageSourceURL = fldMedia.imageSourceURL;
									if (fldMedia.imageLinkURL)
										tMed.imageLinkURL = fldMedia.imageLinkURL;
								}
							}
							
							tMeds.push(tMed);
						}
						tPopUp.popUpMediaInfos = tMeds;		
						
						// Configure the popup window renderer
						layerInfoWindowRenderer = new LayerInfoWindowRenderer;
						layerInfoWindowRenderer.layerId = sublayerId;
						infoWindowRenderer = new ClassFactory(PopUpRenderer);
						infoWindowRenderer.properties = { popUpInfo: tPopUp };
						layerInfoWindowRenderer.infoWindowRenderer = infoWindowRenderer;
						
						layerInforenderers.push(layerInfoWindowRenderer);
					}

					// Apply Layer Info renderers
					if (layerInforenderers.length > 0)
					{
						tLayer.layerInfoWindowRenderers = layerInforenderers;
					}
				}
				else if (layer is FeatureLayer)
				{
					var fLayer:FeatureLayer = FeatureLayer(layer);
					
					// See if there is a popup info setting for this layer
					info = settings.popUpInfos[0];
					if (info)
					{
						// Create the popup object
						var fPopUp:PopUpInfo = new PopUpInfo();
						fPopUp.title = info.title;
						fPopUp.description = info.description;
						fPopUp.showAttachments = info.showAttachments == "true";
						
						var fFlds:Array = [];
						for each (fldInfo in info.fieldInfos)
						{
							// Create a new field info object
							var fFld:PopUpFieldInfo = new PopUpFieldInfo();
							fFld.fieldName = fldInfo.fieldName;
							fFld.label = fldInfo.label;
							fFld.visible = fldInfo.visible == "true";
							
							// Apply format details
							fFld.format = new PopUpFieldFormat();
							fFld.format.dateFormat = fldInfo.dateFormat;
							if (fldInfo.precision)
								fFld.format.precision = fldInfo.precision;
							fFld.format.useThousandsSeparator = fldInfo.useThousandsSeparator == "true";
							fFld.format.useUTC = fldInfo.useUTC == "true";
							
							// Append to fields array
							fFlds.push(fFld);
						}
						fPopUp.popUpFieldInfos = fFlds;
						
						var fMeds:Array = [];
						for each (fldMedia in info.mediaInfos)
						{
							var fMed:PopUpMediaInfo = new PopUpMediaInfo();
							fMed.type = fldMedia.type;
							fMed.title = fldMedia.title;
							fMed.caption = fldMedia.caption;
							
							switch (fldMedia.type)
							{
								case "columnchart":
								case "piechart":
								case "barchart":
								case "linechart":
								{
									// Get chart settings
									fMed.chartFields = String(fldMedia.chartFields).split(";");
									
									if (fldMedia.chartNormalizationField)
									{
										fMed.chartNormalizationField = fldMedia.chartNormalizationField;
									}
									
									if (fldMedia.chartSeriesStyleName)
									{
										fMed.chartSeriesStyleName = fldMedia.chartSeriesStyleName;
									}
									break;
								}
									
								default:
								{
									// Get the image settings 
									fMed.imageSourceURL = fldMedia.imageSourceURL;
									if (fldMedia.imageLinkURL)
										fMed.imageLinkURL = fldMedia.imageLinkURL;
								}
							}
							
							fMeds.push(fMed);
						}
						fPopUp.popUpMediaInfos = fMeds;		
						
						// Configure the popup window renderer
						layerInfoWindowRenderer = new LayerInfoWindowRenderer;
						layerInfoWindowRenderer.layerId = sublayerId;
						infoWindowRenderer = new ClassFactory(PopUpRenderer);
						infoWindowRenderer.properties = { popUpInfo: fPopUp };						

						// Set the layer infoWindowRenderer
						fLayer.infoWindowRenderer = infoWindowRenderer;
					}
				}
			}
		}
	
		/**
		 * Checks whether a feature layer allows features to be created.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>featureLayer [FeatureLayer]: </i>ArcGIS Featurelayer to check edit details for.</li>
		 * </ul>
		 * </p>  
		 */
		public static function featureLayerIsCreateAllowed(featureLayer:FeatureLayer):Boolean
		{
			var result:Boolean;
			
			if (featureLayer.layerDetails is FeatureLayerDetails)
			{
				result = (featureLayer.layerDetails as FeatureLayerDetails).isCreateAllowed;
			}
			else if (featureLayer.tableDetails is FeatureTableDetails)
			{
				result = (featureLayer.tableDetails as FeatureTableDetails).isCreateAllowed;
			}
			
			return result;
		}

		/**
		 * Creates a new layer details object with the same properties as a supplied object. 
  		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>details [LayerDetails]: </i>ArcGIS layerdetails object that shoudl be duplicated.</li>
		 * </ul>
		 * </p>  
		 */
		public static function cloneLayerDetails(details:LayerDetails):LayerDetails
		{
			var result:LayerDetails = new LayerDetails();
			
			result.canModifyLayer 		= details.canModifyLayer;
			result.canScaleSymbols 		= details.canScaleSymbols;
			result.capabilities			= [];
			result.copyright			= details.copyright;
			result.defaultVisibility	= details.defaultVisibility;
			result.definitionExpression	= details.definitionExpression;
			result.description			= details.description;
			result.displayField			= details.displayField;
			result.drawingInfo			= new DrawingInfo();
			result.drawingInfo.alpha	= details.drawingInfo.alpha;
			result.drawingInfo.renderer = details.drawingInfo.renderer;
			result.extent				= new Extent(details.extent.xmin, details.extent.ymin, details.extent.xmax, details.extent.ymax, new SpatialReference(details.spatialReference.wkid));

			result.fields 				= [];
			for each(var field:Field in details.fields)
			{
				var newField:Field = new Field();
				newField.alias			= field.alias;
				newField.domain			= field.domain;
				newField.editable		= field.editable;
				newField.length			= field.length;
				newField.name			= field.name;
				newField.nullable		= field.nullable;
				newField.type			= field.type;
				result.fields.push(newField);
			}
			
			result.geometryType			= details.geometryType;
			result.hasAttachments		= details.hasAttachments;
			result.hasLabels			= details.hasLabels;
			result.hasM					= details.hasM;
			result.hasZ					= details.hasZ;
			result.htmlPopupType		= details.htmlPopupType;
			result.id					= details.id;
			result.isDataVersioned		= details.isDataVersioned;
			result.maxRecordCount		= details.maxRecordCount;
			result.maxScale				= details.maxScale;
			result.minScale				= details.minScale;
			result.name					= details.name;
			result.objectIdField		= details.objectIdField;
			result.ownershipBasedAccessControlForFeatures = details.ownershipBasedAccessControlForFeatures;
			result.parentLayer			= details.parentLayer;
			result.relationships		= details.relationships;
			result.spatialReference		= new SpatialReference(details.spatialReference.wkid);
			result.subLayers			= details.subLayers;
			result.supportedQueryFormats = details.supportedQueryFormats;
			result.supportsAdvancedQueries = details.supportsAdvancedQueries;
			result.supportsStatistics	= details.supportsStatistics;
			result.timeInfo				= details.timeInfo;
			result.type					= details.type;
			result.typeIdField			= details.typeIdField;

			result.types 				= [];
			for each(var typ:FeatureType in details.types)
			{
				var newType:FeatureType = new FeatureType();
				newType.domains			= typ.domains;
				newType.id				= typ.id;
				newType.name			= typ.name;
				
				newType.templates		= [];
				for each(var temp:FeatureTemplate in typ.templates)
				{
					var newTemp:FeatureTemplate = new FeatureTemplate();
					newTemp.description	= temp.description;
					newTemp.drawingTool = temp.drawingTool;
					newTemp.name		= temp.name;
					newTemp.prototype	= temp.prototype;

					newType.templates.push(newTemp);
				}
				result.types.push(newTemp);
			}

			result.version			= details.version;
			return result;
		}
	
	}
}