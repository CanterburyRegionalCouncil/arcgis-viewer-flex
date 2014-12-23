package widgets.SearchEnhanced.supportClasses
{
	import com.esri.ags.FeatureSet;
	import com.esri.ags.Graphic;
	import com.esri.ags.Map;
	import com.esri.ags.SpatialReference;
	import com.esri.ags.events.FeatureLayerEvent;
	import com.esri.ags.events.LayerEvent;
	import com.esri.ags.geometry.Extent;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.layers.FeatureLayer;
	import com.esri.ags.layers.supportClasses.FeatureCollection;
	import com.esri.ags.layers.supportClasses.Field;
	import com.esri.ags.layers.supportClasses.LayerDetails;
	import com.esri.ags.portal.PopUpRenderer;
	import com.esri.ags.portal.supportClasses.PopUpInfo;
	import com.esri.ags.portal.supportClasses.PopUpMediaInfo;
	import com.esri.ags.renderers.Renderer;
	import com.esri.ags.renderers.SimpleRenderer;
	import com.esri.ags.symbols.PictureMarkerSymbol;
	import com.esri.ags.symbols.SimpleFillSymbol;
	import com.esri.ags.symbols.SimpleLineSymbol;
	import com.esri.ags.symbols.SimpleMarkerSymbol;
	import com.esri.ags.symbols.Symbol;
	import com.esri.ags.tasks.supportClasses.Query;
	import com.esri.ags.utils.JSONUtil;
	import com.esri.viewer.AppEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.ClassFactory;
	import mx.events.FlexEvent;
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	
	import spark.collections.Sort;
	import spark.collections.SortField;
	
	import widgets.supportClasses.FeatureSetUtil;
	import widgets.supportClasses.utils.GraphicUtil;
	import widgets.supportClasses.utils.LayerUtil;

	
	[Bindable]
	public class SearchLayer extends EventDispatcher
	{

		/* CLASS CONSTANTS
		--------------------------------------------------------------------------------------------------- */
		/**
		 * Event type used to signal that the results layer has been hidden.
		 */
		public static const RESULT_LAYER_HIDDEN:String = "SearchLayer_ResultLayerHidden"; 
		
		/**
		 * Event type used to signal that the results layer selected contents have been updated.
		 */
		public static const RESULT_LAYER_UPDATED:String = "SearchLayer_ResultLayerUpdated"; 

		/**
		 * Event type used to signal that the results layer selected contents have been updated and no results where found.
		 */
		public static const QUERY_NORESULT:String = "SearchLayer_QueryNoResult"; 
		
		/**
		 * Event type used to signal that the results layer selected contents have been cleared.
		 */
		public static const RESULT_LAYER_CLEARED:String = "SearchLayer_ResultLayerCleared"; 

		/**
		 * Event type used to signal that the results layer selected contents have been cleared.
		 */
		public static const QUERY_FAULT:String = "SearchLayer_QueryFault"; 

		/**
		 * Event type used to signal that the client should zoom to the extent of the selected contents of the results layer.
		 */
		public static const ZOOM_TO_RESULTS:String = "SearchLayer_ZoomToResults"; 

		/**
		 * Event type used to signal that the client should convert the selcted contents of the results layer to drawing graphics.
		 */
		public static const CONVERT_RESULTS_TO_GRAPHICS:String = "SearchLayer_ConverResultsToGraphics"; 

		/**
		 * Event type used to signal that the client should highlight the selected record.
		 */
		public static const RECORD_APPLY_HIGHLIGHT:String = "SearchLayer_RecordApplyHighlight"; 

		/**
		 * Event type used to signal that the client should remove the highlight from the selected record.
		 */
		public static const RECORD_REMOVE_HIGHLIGHT:String = "SearchLayer_RecordRemoveHighlight"; 
		
		/**
		 * Event type used to signal the client that the selected record has been double clicked.
		 */
		public static const RECORD_DOUBLECLICK:String = "SearchLayer_RecordDoubleClick"; 
		
		
		/**
		 * Event type used to signal that the results layer selected contents have been cleared.
		 */
		public static const RESULT_LAYER_LABEL:String = " [Search Results]"; 
		
		
		
		/* CLASS CONSTRUCTOR
		--------------------------------------------------------------------------------------------------- */
		
		/**
		 * Constructor for a SearchLayer settings object.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>url [String]: </i>URL for the http end point for map layer being searched.</li>
		 * <li><i>proxyUrl [String]: </i>URL for the proxy page to be used to proxy any searches to the http end point for map layer.  If null, the queries will not be proxied.</li>
		 * <li><i>token [String]: </i>Token to be used to access a secured map layer.</li>
		 * <li><i>labelString [String]: </i>Text to be displayed as a describer for the the layer.  This should be a unique name.  If not supplied, the layer name from the map service will be used.</li>
		 * <li><i>fieldsXML [XMLList]: </i>XML objects containing the field settings to be used to display the results.  If not supplied, the default field details from the layerDetails will be used..</li>
		 * </ul>
		 * </p>		 
		 */		
		public function SearchLayer(url:String, proxyUrl:String=null, token:String=null, labelString:String=null, 
									 fieldsXML:XMLList=null, titlefieldname:String=null,  expressionsXML:XMLList=null, 
									 linksXML:XMLList=null, useshapeextent:Boolean=true, zoomtoscale:Number=10000, 
									 minsearchscale:Number=50000, useamfformat:Boolean=true, resultSymbol:Symbol=null, 
									 map:Map=null, target:IEventDispatcher=null, urlAliases:XMLList=null)
		{
			super(target);
			
			// Set the layer properties
			this.url = url;
			this.label = labelString;
			this.fields = fieldsXML;
			this.titlefield = titlefieldname;
			this.expressions = expressionsXML;
			this.links = linksXML;
			this.useextent = useshapeextent;
			this.zoomscale = zoomtoscale; 
			this.minscale = minsearchscale;	
			this.symbol = resultSymbol;
			
			// Set the layer
			_searchLayer = new FeatureLayer(url, proxyUrl, token);
			_searchLayer.useAMF = useamfformat;
			_searchLayer.name = labelString;
			_searchLayer.id = labelString;
			
			// Add listener for when layer is loaded
			_searchLayer.addEventListener(LayerEvent.LOAD, layerLoaded);
			
			// Construct the results layer
			_resultsLayer = new FeatureLayer();
			_resultsLayer.id = label + RESULT_LAYER_LABEL;
			_resultsLayer.visible = false;
			_resultsLayer.isEditable = false;
			_resultsLayer.name = label + RESULT_LAYER_LABEL;
			
			_resultsLayer.addEventListener(FlexEvent.HIDE, resultFeatureLayer_hideHandler);

			// Prepare the results colelction for the results list
			_searchResults = new ArrayCollection();
			
		}
		
		/* CLASS PROPERTIES
		--------------------------------------------------------------------------------------------------- */
		
		/**
		 * Internal refernce to the feature layer containing the search settings.  Used to perform the queries.
		 */
		private var _searchLayer:FeatureLayer;
		
		/**
		 * ESRI Feature layer to be searched. 
		 */
		public function set layer(value:FeatureLayer):void
		{
			if (value)
			{
				_searchLayer = value;
				
				// Check if the layer is loaded
				if (_searchLayer.loaded)
				{
					updateLayerDetails();	
				}
				else
				{
					// Add listener for when layer is loaded
					_searchLayer.addEventListener(LayerEvent.LOAD, layerLoaded);
				}
			}
		}
		
		public function get layer():FeatureLayer
		{
			return _searchLayer;
		}

		/**
		 * Source url for the searchable layer.
		 */
		public var url:String = "";
		
		/**
		 * Display name to use when referring to this layer.
		 */
		public var label:String = "";

		/**
		 * XML list containing the settings for each of the different text searches
		 * configured to be applied to this layer.  
		 */
		public var expressions:XMLList;
		
		private var _fields:XMLList;
		
		/**
		 * XML list containing the field detail settings to be displayed in the grid
		 * and summary view of the returned results.  
		 */
		public function set fields(value:XMLList):void
		{
			_fields = value;
			
			// Check if the layer is loaded
			if (_searchLayer && _searchLayer.loaded)
			{
				updateLayerDetails();	
			}
		}

		public function get fields():XMLList
		{
			return _fields;
		}
		
		/**
		 * Name of the field in the featureslayer's attributes that is used as a title 
		 * when display record details.  Unless specifically set, this will default to 
		 * the layers's primary display field.
		 */
		public var titlefield:String = "";

		/**
		 * XML list containing the hyperlink detail settings to be displayed in the 
		 * grid and summary view of the returned results.  
		 */
		public var links:XMLList;
		
		/**
		 * This is the map scale up to which search by locations can be initiated.  If
		 * set to 0, the user may select features from this layer at any scale.
		 */   
		public var minscale:Number = 0;

		/**
		 * Symbol used to render the results graphics with 
		 */
		public var symbol:Symbol;
		
		/**
		 * Boolean variable that determines whether the layer should use the extent of 
		 * features geometry as the zoom extent when a utilising the zoom to feature 
		 * method. 
		 */
		public var useextent:Boolean = true;
		
		/**
		 * Default map scale used when displaying results on the map.  If the useextent
		 * flag is set to true, this value is only used when the setting the map extent 
		 * to match the feature's extent would result in a scale less than this value.
		 * If set to 0, map scale will not be changed (i.e. the map will maintain its 
		 * current scale and will only centre the map on the feature.
		 */
		public var zoomscale:Number = 0;


		/* -------------------------------------------------------------------------------
		SEARCH RESULTS LAYER PROPERTY
		------------------------------------------------------------------------------- */
		
		/**
		 * Internal refernce to the feature layer containing the search settings.  Used to perform the queries.
		 */
		private var _resultsLayer:FeatureLayer;
		
		public function get resultsLayer():FeatureLayer
		{
			return _resultsLayer;
		}
		
		
		
		/* -------------------------------------------------------------------------------
		SEARCH RESULTS COLLECTION PROPERTY
		------------------------------------------------------------------------------- */
		
		private var _searchResults:ArrayCollection;
		
		/**
		 * Collection of the records from the search
		 */
		public function get searchResults():ArrayCollection
		{
			return _searchResults;
		}
		
		
		
		/* -------------------------------------------------------------------------------
		SEARCH RESULTS EXTENT PROPERTY
		------------------------------------------------------------------------------- */
		
		/**
		 * Extent rectange for the current selected records.
		 */
		public function get resultsExtent():Extent
		{
			var result:Extent;
			if (_searchResults.length > 0)
			{
				result = GraphicUtil.ReturnGraphicsExtent(new ArrayCollection(_resultsLayer.featureCollection.featureSet.features));					
			}
			return result;
		}
		
		
		private var supportsServerSideSorting:Boolean;
		private var orderByFields:Array;
		private var _resultCount:int = 0;
		
		
		/* -------------------------------------------------------------------------------
		URL ALLIAS COLLECTION PROPERTY
		------------------------------------------------------------------------------- */

		private var _urlAliases:XMLList;
		
		public function get urlAliases():XMLList
		{
			return _urlAliases;
		}

		public function set urlAliases(value:XMLList):void
		{
			_urlAliases = value;
		}
		
		
		/* CLASS METHODS
		--------------------------------------------------------------------------------------------------- */

		public function checkAlias(checkurl:String):Boolean
		{
			var found:Boolean = false;
			var checkURLLowered:String = checkurl.toLowerCase();
			
			if (checkURLLowered == this.url.toLowerCase())
			{
				found = true;
			}
			else
			{
				// Check the alias list
				if (_urlAliases != null)
				{
					var lng:int = _urlAliases.length();
					if (lng > 0)
					{
						// Populate the search expressions
						for (var i:int = 0; i < lng; i++)
						{
							var aliasurl:String = String(_urlAliases[i].@url).toLowerCase();
							if (aliasurl == checkURLLowered)
							{
								found = true;
								break;
							}
						}
					}
				}
			}
			return found;
		}
		
		/**
		 * Returns a boolean value stating whether there is an expression for this layer that has the provided Predivtive ID value.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>predictive ID [String]: </i> String name associated with the expression.</li>
		 * </ul>
		 * </p>
		 */
		public function hasExpression(predictiveID:String):Boolean
		{
			var found:Boolean = false;
			
			// Iterate through each of the expression XML features and check the predivtive id value
			if (expressions)
			{
				var exps:XMLList = expressions.expression;
				var lng:int = exps.length();
				
				if (lng > 0)
				{
					// Populate the search expressions
					for (var i:int = 0; i < lng; i++)
					{
						var expPredictiveID:String = exps[i].@predictiveID;
						if (expPredictiveID == predictiveID)
						{
							found = true;
							break;
						}
					}
				}
			}
			
			return found;
		}
		
		/**
		 * Returns the expression xml value from this layer that has the provided Predivtive ID value.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>predictive ID [String]: </i> String name associated with the expression.</li>
		 * </ul>
		 * </p>
		 */
		public function getExpression(predictiveID:String):XML
		{
			var exp:XML;
			
			if (expressions)
			{
				var exps:XMLList = expressions.expression;
				var lng:int = exps.length();
				
				if (lng > 0)
				{
					// Populate the search expressions
					for (var i:int = 0; i < lng; i++)
					{
						var expPredictiveID:String = exps[i].@predictiveID;
						if (expPredictiveID == predictiveID)
						{
							exp = exps[i];
							break;
						}
					}
				}				
			}
			return exp;
		}
		
		/**
		 * Called when the map layer has been loaded properly.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>event [LayerEvent]: </i>Layer event returned when the layer is loaded.</li>
		 * </ul>
		 * </p>
		 */		
		private function layerLoaded(event:LayerEvent):void
		{
			// Clear listener for when layer is loaded
			_searchLayer.removeEventListener(LayerEvent.LOAD, layerLoaded);

			// Removing scale dependency
			_searchLayer.layerDetails.minScale = 0; 
			_searchLayer.layerDetails.maxScale = 0;
			
			// Update the layer details
			updateLayerDetails();	
		}
		
		/**
		 * Updates the layer details.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li>None.</li>
		 * </ul>
		 * </p>
		 */		
		private function updateLayerDetails():void
		{
			// Set the label field if not already set
			if (this.label == "" || this.label == null)
			{
				this.label = _searchLayer.layerDetails.name;
			}
			
			// Set the display field if not already set
			if (this.titlefield == "" || this.titlefield == null)
			{
				this.titlefield = _searchLayer.layerDetails.displayField;
			}
			
			// Set the output fields
			if ((_fields && _fields[0].@all[0] == "true")|| _fields == null)
			{
				_searchLayer.outFields = [ "*" ];
			}
			else if (_fields)
			{
				var flds:XMLList = _fields.field;
				_searchLayer.outFields = [];
				for each (var fieldXML:XML in flds)
				{
					if (fieldXML.@name[0])
					{
						var fldName:String = fieldXML.@name[0];						
						_searchLayer.outFields.push(fldName);
					}
				}
			}

			// Update the sorting options
			supportsServerSideSorting = _searchLayer.layerDetails
				&& _searchLayer.layerDetails.version >= 10.1
				&& _searchLayer.layerDetails.supportsAdvancedQueries;
			
			// Update the sort field details
			orderByFields = [this.titlefield];
			
			// Update the results layer
			_resultsLayer.renderer 		= prepareRenderer();
		}
		
		private function prepareRenderer():Renderer
		{
			var renderer:SimpleRenderer = new SimpleRenderer(symbol);
			renderer.label = _resultsLayer.name;
			return renderer;			
		}
		
		
		/**
		 * Generates a friendly alias for the given field name, removing non compliant characaters such as "." from the names.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>fieldname [String]: </i>Field name to be made friendly.</li>
		 * </ul>
		 * </p>		 
		 */
		private function generateFriendlyName(fieldname:String):String
		{
			var friendly:String = fieldname.replace(/\./gi,"@");
			return friendly;
		}
		
		/**
		 * Clears any currently selected records.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li>None.</li>
		 * </ul>
		 * </p>
		 */
		public function clearSelection():void
		{
			if (_searchResults && _searchResults.length > 0)
			{
				// Clear existing records
				_searchResults.removeAll();

				// Clear the results layer
				_resultsLayer.featureCollection = new FeatureCollection(new FeatureSet(), _resultsLayer.layerDetails); // empty featureset to clear
				
				// Reset the record id counter
				_resultCount = 0;
				
				// Dispatch the change event
				AppEvent.dispatch(SearchLayer.RESULT_LAYER_CLEARED, { searchLayer: this });
			}
		}
		
		/**
		 * Clears the selected record from the current selction set. 
		 */ 
		public function clearSelectedRecord(graphic:Graphic):void
		{
			// Clear existing records
			_searchResults.removeAll();

			// Get the object ID field
			var objectIDField:String = _searchLayer.layerDetails.objectIdField;
			var objectID:int, records:Array, index:int;
			
			var feat:String;
			var rec:String;

			// Get the records object id
			objectID = graphic.attributes[objectIDField];
			
			// Check for already selected records
			records = getRecords(objectID, objectIDField);
			
			if (records.length > 0)
			{
				// Prepare the attributes record for checking
				feat = convertGraphic(graphic, objectIDField, false);
				
				// Compare each record in the records to see if it matches this record
				var found:Boolean = false;
				for each (var record:Graphic in records)
				{
					// Prepare record attributes for comparison to the feature attribues
					rec = convertGraphic(record, objectIDField, false);
					if (rec == feat)
					{
						// Remove from the results layer featureset
						index = _resultsLayer.featureCollection.featureSet.features.indexOf(record);
						_resultsLayer.featureCollection.featureSet.features.splice(index,1);
					}
				}
			}

			// Create the search results
			_searchResults = createSearchResults(_resultsLayer.featureCollection.featureSet, fields);
			
			if (_searchResults.length > 0)
			{
				// Dispatch the change event
				AppEvent.dispatch(SearchLayer.RESULT_LAYER_UPDATED, { searchLayer: this });
			}
			else
			{
				// Dispatch the clear event
				AppEvent.dispatch(SearchLayer.RESULT_LAYER_CLEARED, { searchLayer: this });
			}
		}
		
		/**
		 * Clears an array of selected records from the current selction set. 
		 */ 
		public function clearSelectedRecords(graphics:Array):void
		{
			// Clear existing records
			_searchResults.removeAll();
			
			// Get the object ID field
			var objectIDField:String = _searchLayer.layerDetails.objectIdField;
			var objectID:int, records:Array, index:int;
			
			var feat:String;
			var rec:String;
			
			for each (var graphic:Graphic in graphics)
			{
				// Get the records object id
				objectID = graphic.attributes[objectIDField];
				
				// Check for already selected records
				records = getRecords(objectID, objectIDField);
				
				if (records.length > 0)
				{
					// Prepare the attributes record for checking
					feat = convertGraphic(graphic, objectIDField, false);
					
					// Compare each record in the records to see if it matches this record
					var found:Boolean = false;
					for each (var record:Graphic in records)
					{
						// Prepare record attributes for comparison to the feature attribues
						rec = convertGraphic(record, objectIDField, false);
						if (rec == feat)
						{
							// Remove from the results layer featureset
							index = _resultsLayer.featureCollection.featureSet.features.indexOf(record);
							_resultsLayer.featureCollection.featureSet.features.splice(index,1);
						}
					}
				}
			}
			
			// Create the search results
			_searchResults = createSearchResults(_resultsLayer.featureCollection.featureSet, fields);
			
			if (_searchResults.length > 0)
			{
				// Dispatch the change event
				AppEvent.dispatch(SearchLayer.RESULT_LAYER_UPDATED, { searchLayer: this });
			}
			else
			{
				// Dispatch the clear event
				AppEvent.dispatch(SearchLayer.RESULT_LAYER_CLEARED, { searchLayer: this });
			}
		}
		
		
		/* QUERY FUNCTIONS
		--------------------------------------------------------------------------------------------------- */
		
		/**
		 * Execute the query against the layer
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>queryText [String]: </i>SQL query string to be used to filter the layer.</li>
		 * <li><i>queryShape [Geometry]: </i>Geometry to use as a spatial filter for the query.</li>
		 * <li><i>selectionMode [String]: </i>Selection mode to use when performing the query. Options include FeatureLayer.SELECTION_NEW (default), FeatureLayer.SELECTION_ADD, FeatureLayer.SELECTION_SUBTRACT.</li>
		 * </ul>
		 * </p>
		 */
		public function query(queryText:String, queryShape:Geometry, selectionMode:String = FeatureLayer.SELECTION_NEW, 
							  spatialRelation:String = null, spatialReference:SpatialReference=null):void
		{
			if (!_searchLayer.loaded)
			{
				_searchLayer.addEventListener(LayerEvent.LOAD, queryLayer_loadHandler);
				function queryLayer_loadHandler(event:LayerEvent):void
				{
					// Remove the handler
					_searchLayer.removeEventListener(LayerEvent.LOAD, queryLayer_loadHandler);
					
					// Call this function again using the same parameters
					this.query(queryText, queryShape, selectionMode, spatialRelation, spatialReference);
				}
				return;
			}
			
			// Construct the query
			var query:Query = new Query();
			query.returnGeometry = true;
			
			if (queryText)
				query.where = queryText;
			
			if (queryShape)
				query.geometry = queryShape;
			
			if (spatialRelation)
				query.spatialRelationship = spatialRelation;
			
			if (spatialReference)
				query.outSpatialReference = spatialReference;
			
			if (supportsServerSideSorting && orderByFields)
				query.orderByFields = orderByFields;
			
			// Check selection mode
			switch(selectionMode)
			{
				case FeatureLayer.SELECTION_NEW:
					_searchLayer.queryFeatures(query, new AsyncResponder(queryNew_onResult, query_onFault));
					break;
				
				case FeatureLayer.SELECTION_ADD:
					// Check if there are any existing selected features
					if (_searchResults.length == 0)
					{
						// Perform query as if this is a new selection
						_searchLayer.queryFeatures(query, new AsyncResponder(queryNew_onResult, query_onFault));
					}
					else
					{
						// Add new unique features to existing selection selection
						_searchLayer.queryFeatures(query, new AsyncResponder(queryAdd_onResult, query_onFault));
					}
					break;
				
				case "remove":
				case FeatureLayer.SELECTION_SUBTRACT:
					// Remove any existing selected features that match the query results 
					_searchLayer.queryFeatures(query, new AsyncResponder(queryRemove_onResult, query_onFault));
					break;
				
				default:
					break;
			}		
		}
		
		/**
		 * Called when the query function returns a result
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>featureSet [FeatureSet]: </i>Result set from the query.</li>
		 * <li><i>token [Object]: </i>Attached settings object.  Not utilised.</li>
		 * </ul>
		 * </p>
		 */
		protected function queryNew_onResult(featureSet:FeatureSet, token:Object = null):void
		{
			// Clear existing records
			_searchResults.removeAll();

			// Reset the record object id
			_resultCount = 0;
			
			try
			{
				if (!supportsServerSideSorting && orderByFields)
				{
					FeatureSetUtil.sortFeaturesByFieldName(featureSet, orderByFields);
				}
				_searchResults = createSearchResults(featureSet, fields);
				
				if (featureSet.features.length < 1)
				{
					// Dispatch the change event
					AppEvent.dispatch(SearchLayer.QUERY_NORESULT, { searchLayer: this });
				}
				else
				{
					// Dispatch the change event
					AppEvent.dispatch(SearchLayer.RESULT_LAYER_UPDATED, { searchLayer: this });
				}
			}
			catch (error:Error)
			{
				// Dispatch the fault event
				AppEvent.dispatch(SearchLayer.QUERY_FAULT, { searchLayer: this, faultmessage: error.message.toString() });
			}
		}
		
		/**
		 * Add any records not already in the current selected records to the set
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>featureSet [FeatureSet]: </i>Result set from the query of records tto be potentially appended.</li>
		 * <li><i>token [Object]: </i>Attached settings object.  Not utilised.</li>
		 * </ul>
		 * </p>
		 */
		protected function queryAdd_onResult(featureSet:FeatureSet, token:Object = null):void
		{
			// Clear existing records
			_searchResults.removeAll();

			try
			{
				// Get the object ID field
				var objectIDField:String = _searchLayer.layerDetails.objectIdField;
				var objectID:int, records:Array;
				for each (var graphic:Graphic in featureSet.features)
				{
					// Get the records object id
					objectID = graphic.attributes[objectIDField];
					
					// Check for already selected records
					records = getRecords(objectID, objectIDField);
	
					var feat:String;
					var rec:String;
					
					if (records.length == 0)
					{
						_resultsLayer.featureCollection.featureSet.features.push(graphic);
					}
					else
					{
						// Prepare the attributes record for checking
						feat = convertGraphic(graphic, objectIDField, false);

						// Compare each record in the records to see if it matches this record
						var found:Boolean = false;
						for each (var record:Graphic in records)
						{
							// Prepare record attributes for comprison to the feature attribues
							rec = convertGraphic(record, objectIDField);
							if (rec == feat)
							{
								found = true;
								break;
							}

							if (!found)
							{
								_resultsLayer.featureCollection.featureSet.features.push(graphic);
							}
						}
					}
				}
				
				// Create the search results
				if (_resultsLayer.featureCollection)
				{
					// Update the dislay renderer details
					_resultsLayer.featureCollection.layerDefinition.drawingInfo.renderer = prepareRenderer();

					// Apply a sort to the collection
					if (orderByFields)
					{
						FeatureSetUtil.sortFeaturesByFieldName(_resultsLayer.featureCollection.featureSet, orderByFields);
					}
					
					// Recreate the search results
					_searchResults = createSearchResults(_resultsLayer.featureCollection.featureSet, fields);
				}
				else
				{
					// Dispatch the no result event
					AppEvent.dispatch(SearchLayer.QUERY_NORESULT, { searchLayer: this });
					return;
				}

				// Dispatch the change event
				AppEvent.dispatch(SearchLayer.RESULT_LAYER_UPDATED, { searchLayer: this });
			}
			catch (error:Error)
			{
				// Dispatch the fault event
				AppEvent.dispatch(SearchLayer.QUERY_FAULT, { searchLayer: this, faultmessage: error.message.toString() });
			}
		}
		
		/**
		 * Remove any records that are already in the current selected records
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>featureSet [FeatureSet]: </i>Result set from the query of records to be removed.</li>
		 * <li><i>token [Object]: </i>Attached settings object.  Not utilised.</li>
		 * </ul>
		 * </p>
		 */
		protected function queryRemove_onResult(featureSet:FeatureSet, token:Object = null):void
		{
			// Clear existing records
			_searchResults.removeAll();
			
			try
			{
				// Get the object ID field
				var objectIDField:String = _searchLayer.layerDetails.objectIdField;
				var objectID:int, records:Array, index:int;
				
				var feat:String;
				var rec:String;
				
				for each (var graphic:Graphic in featureSet.features)
				{
					// Get the records object id
					objectID = graphic.attributes[objectIDField];
					
					// Check for already selected records
					records = getRecords(objectID, objectIDField);
					
					if (records.length > 0)
					{
						// Prepare the attributes record for checking
						feat = convertGraphic(graphic, objectIDField, false);
						
						// Compare each record in the records to see if it matches this record
						var found:Boolean = false;
						for each (var record:Graphic in records)
						{
							// Prepare record attributes for comparison to the feature attribues
							rec = convertGraphic(record, objectIDField);
							if (rec == feat)
							{
								// Remove from the results layer featureset
								index = _resultsLayer.featureCollection.featureSet.features.indexOf(record);
								_resultsLayer.featureCollection.featureSet.features.splice(index,1);
							}
						}
					}
				}
				
				// Create the search results
				if (_resultsLayer.featureCollection)
				{
					_searchResults = createSearchResults(_resultsLayer.featureCollection.featureSet, fields);
				}
				else
				{
					// Dispatch the no result event
					AppEvent.dispatch(SearchLayer.QUERY_NORESULT, { searchLayer: this });
					return;
				}
				
				if (_searchResults.length > 0)
				{
					// Dispatch the change event
					AppEvent.dispatch(SearchLayer.RESULT_LAYER_UPDATED, { searchLayer: this });
				}
				else
				{
					// Dispatch the cleared event
					AppEvent.dispatch(SearchLayer.RESULT_LAYER_CLEARED, { searchLayer: this });
				}
			}
			catch (error:Error)
			{
				// Dispatch the fault event
				AppEvent.dispatch(SearchLayer.QUERY_FAULT, { searchLayer: this, faultmessage: error.message.toString() });
			}
		}
		
		/** 
		 * Retrieve records (if any) from the current selected features.  Returns an array of multiple records if more than one record shares the specified object id (which can happen in a view).
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>objectID [int]: </i>Object id value for records being searched for.</li>
		 * <li><i>obectIDField [String]: </i>Name of the object id field in the dataset.</li>
		 * </ul>
		 * </p>
		 */ 
		protected function getRecords(objectID:int, objectIDField:String):Array
		{
			var results:Array = new Array();
			
			if (_resultsLayer.featureCollection)
			{
				for each (var graphic:Graphic in _resultsLayer.featureCollection.featureSet.features)
				{
					if (graphic.attributes[objectIDField] == objectID)
					{
						results.push(graphic);
					}
				}
			}
			return results;
		}
		
		/**
		 * Creates the search results set to be displayed in the result inspector.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>featureSet [FeatureSet]: </i>Result set from the query of records processed.</li>
		 * <li><i>queryFields [XMLList]: </i>XMLList of the field settings to be used.</li>
		 * </ul>
		 * </p>
		 */
		private function createSearchResults(featureSet:FeatureSet, queryFields:XMLList):ArrayCollection
		{
			var result:ArrayCollection = new ArrayCollection();
			var layerDetails:LayerDetails = LayerUtil.cloneLayerDetails(_searchLayer.layerDetails);
			if (!titlefield)
			{
				titlefield = featureSet.displayFieldName;
			}
			
			var id:int = 0;
			
			for each (var graphic:Graphic in featureSet.features)
			{
				graphic.attributes["_FID"] = id;
				id ++;
				
				var resultAttributes:ResultAttributes =
					ResultAttributes.toResultAttributes(queryFields, graphic, featureSet, _searchLayer, layerDetails, label, titlefield, null, null, links);
				
				var searchResult:ResultItem = new ResultItem(graphic, resultAttributes);
				result.addItem(searchResult);
				
				var infoWindowRenderer:ClassFactory = new ClassFactory(PopUpRenderer);
				infoWindowRenderer.properties = { popUpInfo: configurePopUpInfo(resultAttributes)};
				graphic.infoWindowRenderer = infoWindowRenderer;
			}

			// Prepare field settings
			if (queryFields)
			{
				var outFields:Array = [];
				for each (var fieldXML:XML in queryFields.field) // display the fields in the same order as specified
				{
					var fld:Field = LayerUtil.getField(layerDetails, fieldXML.@name[0])
					if (fld)
					{
						// Update the field properties
						fld.alias = fieldXML.@alias[0] || fieldXML.@name[0];
						outFields.push(fieldXML.@name[0]);
					}
				}
				_resultsLayer.outFields = outFields;
			}
			else
			{
				_resultsLayer.outFields = _searchLayer.outFields;
			}
			
			_resultsLayer.visible = true;
			_resultsLayer.featureCollection = new FeatureCollection(featureSet, layerDetails);

			// Reset the object id field
			var ofield:Field = LayerUtil.getField(_resultsLayer.featureCollection.layerDefinition, _searchLayer.layerDetails.objectIdField);
			ofield.type = Field.TYPE_INTEGER;
			
			_resultsLayer.featureCollection.layerDefinition.fields.push(createFIDField());
			_resultsLayer.featureCollection.layerDefinition.objectIdField = "_FID";
			
			_resultsLayer.renderer = prepareRenderer();

			// Return the results
			return result;
		}
		
		/**
		 * Creates an FID field to use in the search results.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li>None.</li>
		 * </ul>
		 * </p>
		 */
		private function createFIDField():Field
		{
			var result:Field = new Field();
			result.name = "_FID";
			result.alias = "FID";
			result.editable = false;
			result.type = Field.TYPE_OID;
			result.nullable = false;
			
			return result;
		}
		
		/**
		 * Creates a text string that can be used for comparing records.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>graphic [Graphic]: </i>Record graphic to prepare.</li>
		 * <li><i>objectIDField [String]: </i>Name of the field that conatins the standard objectid.</li>
		 * <li><i>hasFID [Boolean]: </i>Flag for whether the graphic should have the searchlayer FID field.</li>
		 * </ul>
		 * </p>
		 */
		private function convertGraphic(graphic:Graphic, objectIDField:String, hasFID:Boolean = true):String
		{
			var obj:Object = graphic.toJSON();
			delete obj.attributes[objectIDField];
			
			if (hasFID)
			{
				delete obj.attributes["_FID"];
			}
			return JSONUtil.encode(obj);
		}
			
		/**
		 * Configures the popup renderer for the results set.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>resultAttributes [ResultAttributes]: </i>Processed search results object.</li>
		 * </ul>
		 * </p>
		 */
		public function configurePopUpInfo(resultAttributes:ResultAttributes):PopUpInfo
		{
			var popUpInfo:PopUpInfo = new PopUpInfo;
			
			popUpInfo.title = resultAttributes.title;
			popUpInfo.description = resultAttributes.content;
			

			var links:ArrayCollection = resultAttributes.links;
			if (links && links.length > 0)
			{
				popUpInfo.popUpMediaInfos = [];
				
				// Iterate through each linkItem and look for images 
				for each (var linkItem:ResultLink in links)
				{
					var pos:Number = linkItem.url.length - 4;
					var sfx:String = linkItem.url.substr(pos, 4).toLowerCase();
					if ((sfx == ".jpg") || (sfx == "jpeg") ||(sfx == ".png") || (sfx == ".gif")) // use PopUpMediaInfo if it is an image
					{
						// Link contains an image - populate as a popup media
						var popUpMediaInfo:PopUpMediaInfo = new PopUpMediaInfo;
						popUpMediaInfo.imageLinkURL = linkItem.url;
						popUpMediaInfo.imageSourceURL = linkItem.url;
						popUpInfo.popUpMediaInfos.push(popUpMediaInfo);
					}
					else
					{
						// Append as a link item to the description
						popUpInfo.description += "<br/>" + linkItem.popupLink;
					}
				}
			}
			
			return popUpInfo;
		}
		
		/**
		 * Called when the query task returns a fault event.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>info [Object]: </i>Fault event object.</li>
		 * <li><i>token [Object]: </i>Attached settings object.  Not utilised.</li>
		 * </ul>
		 * </p>
		 */
		private function query_onFault(info:Object, token:Object = null):void
		{
			// Dispatch the fault event
			AppEvent.dispatch(SearchLayer.QUERY_FAULT, { searchLayer: this, faultmessage: info.toString() });
		}
		
		
		
		/* RESULTS LAYER FUNCTIONS
		--------------------------------------------------------------------------------------------------- */
		
		/**
		 * Called when the results layer has been hidden.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>event [FlexEvent]: </i>Event returned when the results layer is hidden.</li>
		 * </ul>
		 * </p>
		 */
		private function resultFeatureLayer_hideHandler(event:FlexEvent):void
		{
			AppEvent.dispatch(SearchLayer.RESULT_LAYER_HIDDEN, { searchLayer: this });
		}
	}
}