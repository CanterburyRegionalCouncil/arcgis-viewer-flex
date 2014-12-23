package widgets.HeaderControllerEnhanced.components
{
	import widgets.HeaderControllerEnhanced.components.*;
	
	import mx.core.ClassFactory;
	
	import spark.components.DataGroup;
	
	// these events bubble up from the LinkItemRenderer
	[Event(name="linkItemClick", type="flash.events.Event")]
	[Event(name="linkItemMouseOver", type="flash.events.Event")]
	[Event(name="linkItemMouseOut", type="flash.events.Event")]
	
	public class LinkItemDataGroup extends DataGroup
	{
		public function LinkItemDataGroup()
		{
			super();
			
			this.itemRendererFunction = rendererFunction;
		}

		private function rendererFunction(item:Object):ClassFactory
		{
			return new ClassFactory(LinkItemDataGroupRenderer);
		}
	}
}