package widgets.DrawAdvanced.components
{
	import com.esri.ags.Graphic;
	import com.esri.ags.events.GraphicEvent;
	import com.esri.ags.events.GraphicsLayerEvent;
	import com.esri.ags.layers.GraphicsLayer;
	import widgets.DrawAdvanced.components.GraphicPropertiesItemRenderer;
	
	import mx.collections.*;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.events.CollectionEvent;
	
	import spark.components.DataGroup;
	import spark.components.supportClasses.ItemRenderer;
	import spark.effects.AnimateFilter;
	import spark.formatters.NumberFormatter;
	
	// these events bubble up from the GraphicPropertiesItemRenderer
	[Event(name="graphicClick", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicDoubleClick", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicDelete", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicEditProperties", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicMouseOver", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicMouseOut", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicBuffer", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicLabelMeasurements", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicHideMeasurements", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicCopy", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicPaste", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicTag", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicZoomTo", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]
	[Event(name="graphicShowHide", type="widgets.DrawAdvanced.events.GraphicPropertiesItemRendererEvent")]

	/**
	 * Data component used to display smmary details for a 
	 */
	public class GraphicDataGroup extends DataGroup
	{
		/* -------------------------------------------------------------------
		Component constructor
		---------------------------------------------------------------------- */

		public function GraphicDataGroup()
		{
			// Initialise base class
			super();
			
			// Set itemrenderer
			this.itemRenderer = new ClassFactory(GraphicPropertiesItemRenderer);
		}

		/* -------------------------------------------------------------------
		Component constants
		---------------------------------------------------------------------- */

		private const defaultLengthFormat:Object = { label: 'Meters', abbr: 'm', conversion: 1, precision: 0 };
		private const defaultAreaFormat:Object = { label: 'Square Meters', abbr: 'm²', conversion: 1, precision: 0 };

		
		
		/* -------------------------------------------------------------------
		Component variables
		---------------------------------------------------------------------- */

		// Number formatter for setting the format of areas, etc
		private var _numberformatter:NumberFormatter;

		// Measurement format setting objects
		private var _lengthFormat:Object = defaultLengthFormat;
		private var _areaFormat:Object = defaultAreaFormat;
		
		private var _graphics:ArrayCollection = new ArrayCollection();
		
		// Graphics layer - use as a data source object instead of an array collection
		private var _graphicsLayer:GraphicsLayer;
		
		
		/* -------------------------------------------------------------------
		Component properties
		---------------------------------------------------------------------- */


		/* Number Formatter Property
		------------------------------------------------------*/
		
		/**
		 * Number formatter used to format the style of areas and lengths rendered in the results
		 */
		[Bindable]
		public function set numberFormatter(value:NumberFormatter):void
		{
			if (value)
			{
				_numberformatter = value;
			}
			else
			{
				_numberformatter = new NumberFormatter();
			}
		}
		
		public function get numberFormatter():NumberFormatter
		{
			return _numberformatter;			
		}

		
		
		/* Length Format Property
		------------------------------------------------------*/
		
		/**
		 * Object containing the formatting properties  
		 */
		[Bindable]
		public function set lengthFormat(value:Object):void
		{
			if (value)
			{
				_lengthFormat = value;
			}
			else
			{
				_lengthFormat = defaultLengthFormat;
			}
		}
		
		public function get lengthFormat():Object
		{
			return _lengthFormat;
		}
		

		
		/* Area Format Property
		------------------------------------------------------*/

		/**
		 * Object containing the formatting properties  
		 */
		[Bindable]
		public function set areaFormat(value:Object):void
		{
			if (value)
			{
				_areaFormat = value;
			}
			else
			{
				_areaFormat = defaultAreaFormat;
			}
		}
		
		public function get areaFormat():Object
		{
			return _areaFormat;
		}

		

		/* Graphics Collection
		------------------------------------------------------*/

		/**
		 * Updates the display graphics collection
		 */
		[Bindable]
		public function set displayGraphics(value:ArrayCollection):void
		{
			invalidateDisplayList();

			// Update the event listener
			_graphics.removeEventListener(CollectionEvent.COLLECTION_CHANGE, updateGraphicList);
			_graphics = value;
			_graphics.addEventListener(CollectionEvent.COLLECTION_CHANGE, updateGraphicList);
			
			// Reset the data provider to a new collection
			this.dataProvider = new ArrayCollection();
			
			// Insert the graphics in the reverse order into the new array collection
			if (_graphics && _graphics.length > 0)
			{
				for each (var graphic:Graphic in _graphics)
				{
					ArrayCollection(this.dataProvider).addItemAt(graphic,0);
				}
			}
			
			validateNow();
		}
		
		public function get displayGraphics():ArrayCollection
		{
			return ArrayCollection(this.dataProvider); 			
		}
		

		public function set graphicsLayer(value:GraphicsLayer):void
		{
			// Clear existing listeners
			if (_graphicsLayer)
			{
				_graphicsLayer.removeEventListener(GraphicEvent.GRAPHIC_ADD, graphicAddRemove);
				_graphicsLayer.removeEventListener(GraphicEvent.GRAPHIC_REMOVE, graphicAddRemove);
				_graphicsLayer.removeEventListener(GraphicsLayerEvent.GRAPHICS_CLEAR, graphicsCleared); 
			}
				
			// Update the layer details and add listeners
			if (value)
			{
				_graphicsLayer = value;
				_graphicsLayer.addEventListener(GraphicEvent.GRAPHIC_ADD, graphicAddRemove);
				_graphicsLayer.addEventListener(GraphicEvent.GRAPHIC_REMOVE, graphicAddRemove);
				_graphicsLayer.addEventListener(GraphicsLayerEvent.GRAPHICS_CLEAR, graphicsCleared); 
			}
			else
				_graphicsLayer = null;
			
			// Initialise the displayed records
			updateDataProvider();
		}
		
		/**
		 * Called when a graphic is added or removed from the graphics layer
		 */
		private function graphicAddRemove(event:GraphicEvent):void
		{
			updateDataProvider();
		}
		
		/**
		 * Called when the graphics layer is cleared
		 */
		private function graphicsCleared(event:GraphicsLayerEvent):void
		{
			updateDataProvider();
		}

		/**
		 * 
		 */
		private function updateDataProvider():void
		{
			invalidateDisplayList();
			
			// Reset the data provider to a new collection
			this.dataProvider = new ArrayCollection();
			
			// Insert the graphics in the reverse order into the new array collection
			if (_graphicsLayer && (_graphicsLayer.graphicProvider as ArrayCollection).length > 0)
			{
				for each (var graphic:Graphic in (_graphicsLayer.graphicProvider as ArrayCollection))
				{
					ArrayCollection(this.dataProvider).addItemAt(graphic,0);
				}
			}
			
			validateNow();
		}
		
		/* -------------------------------------------------------------------
		Component Event Handlers
		---------------------------------------------------------------------- */
		
		/**
		 * Called when the graphic list watcher singles a graphic list change.
		 */
		private function updateGraphicList(event:CollectionEvent):void
		{
			invalidateDisplayList();
			
			// Reset the data provider to a new collection
			this.dataProvider = new ArrayCollection();
			
			// Insert the graphics in the reverse order into the new array collection
			if (_graphics && _graphics.length > 0)
			{
				for each (var graphic:Graphic in _graphics)
				{
					ArrayCollection(this.dataProvider).addItemAt(graphic,0);
				}
			}
			
			validateNow();
		}
		
		/* -------------------------------------------------------------------
		Component constructor
		---------------------------------------------------------------------- */

		public function invalidateList():void
		{
			var _itemRenderer:IFactory = this.itemRenderer;
			this.itemRenderer = null;
			this.itemRenderer = _itemRenderer;
		}

		
		/* -------------------------------------------------------------------
		Component actions
		---------------------------------------------------------------------- */

		/**
		 * Applies a highlight fundtion to the supplied graphic if it 
		 */
		public function highlightGraphic(graphic:Graphic):void
		{
			// Find the item renderer associated with the specifid graphic
			var i:int = ArrayCollection(this.dataProvider).getItemIndex(graphic);
			if (i > -1 && i < this.numChildren)
			{
				// Get the child item at this index
				var itm:Object = this.getChildAt(i);
				if (itm && itm is ItemRenderer && ItemRenderer(itm).data === graphic)
				{
					// Apply the rollover effect
					var rend:GraphicPropertiesItemRenderer = GraphicPropertiesItemRenderer(itm);
					rend.showRollOver();
				}
			}
		}
		
		/**
		 * Removes the highlight from the selected feature in the current drawing graphic collection.
		 */
		public function clearHighlightGraphic(graphic:Graphic):void
		{
			// Find the item renderer associated with the specifid graphic
			var i:int = ArrayCollection(this.dataProvider).getItemIndex(graphic);
			if (i > -1 && i < this.numChildren)
			{
				// Get the child item at this index
				var itm:Object = this.getChildAt(i);
				if (itm && itm is ItemRenderer && ItemRenderer(itm).data === graphic)
				{
					// Clear the rollover effect
					var rend:GraphicPropertiesItemRenderer = GraphicPropertiesItemRenderer(itm);
					rend.clearRollOver();
				}
			}
		}
	}
}