package widgets.DrawAdvanced.events
{
	import com.esri.ags.Graphic;
	
	import flash.events.Event;
	
	public class GraphicPropertiesItemRendererEvent extends Event
	{
		public static const GRAPHIC_CLICK:String 				= "graphicClick";
		public static const GRAPHIC_DOUBLE_CLICK:String 		= "graphicDoubleClick";
		public static const GRAPHIC_MOUSE_OVER:String 			= "graphicMouseOver";
		public static const GRAPHIC_MOUSE_OUT:String			= "graphicMouseOut";
		public static const GRAPHIC_DELETE:String 				= "graphicDelete";
		public static const GRAPHIC_EDIT_PROPERTIES:String 		= "graphicEditProperties";
		public static const GRAPHIC_BUFFER:String				= "graphicBuffer";
		public static const GRAPHIC_COPY:String 				= "graphicCopy";
		public static const GRAPHIC_PASTE:String 				= "graphicPaste";
		public static const GRAPHIC_LABELMEASUREMENTS:String 	= "graphicLabelMeasurements";
		public static const GRAPHIC_HIDEMEASUREMENTS:String 	= "graphicHideMeasurements";
		public static const GRAPHIC_ZOOMTO:String 				= "graphicZoomTo";
		public static const GRAPHIC_TAG:String 					= "graphicTag";
		public static const GRAPHIC_SHOWHIDE:String 			= "graphicShowHide";
		
		/**
		 * Constructor
		 */
		public function GraphicPropertiesItemRendererEvent(type:String, inspectedGraphic:Graphic=null, controlKey:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			// Apply extra event settings
			_graphic = inspectedGraphic;
			_ctrlKey = controlKey;
		}
		
		private var _graphic:Graphic;
		private var _ctrlKey:Boolean = false;
		
		
		/**
		 * Graphic being displayed in the item renderer
		 */
		public function get graphic():Graphic
		{
			return _graphic;
		}
		
		public function set graphic(value:Graphic):void
		{
			_graphic = value;
		}

		/**
		 * Specifies whether the control key is being pressed
		 */
		public function get ctrlKey():Boolean
		{
			return _ctrlKey;
		}
		
		public function set ctrlKey(value:Boolean):void
		{
			_ctrlKey = value;
		}
		
	}
}