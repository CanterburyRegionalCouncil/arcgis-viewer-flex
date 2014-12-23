package widgets.DrawAdvanced.events
{
	import com.esri.ags.Graphic;
	
	import flash.events.Event;
	
	public class GraphicInspectorEvent extends Event
	{
		public static const EditClicked:String = "editClicked";
		public static const ZoomClicked:String = "zoomClicked";
		public static const DeleteClicked:String = "deleteClicked";
		
		public function GraphicInspectorEvent(type:String, inspectedGraphic:Graphic=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		
			_graphic = inspectedGraphic;
		}
		
		private var _graphic:Graphic;
		
		public function get graphic():Graphic
		{
			return _graphic;
		}

		public function set graphic(value:Graphic):void
		{
			_graphic = value;
		}
	}
}