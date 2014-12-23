package widgets.HeaderControllerEnhanced.components.supportClasses
{
	public class LinkItem
	{
		public var label:String;
		public var icon:Object;
		public var url:String;
		public var tooltip:String;
		public var bold:Boolean;
		
		public function LinkItem(labeltext:String, tooltiptext:String, urlpath:String, iconimage:Object, isbold:Boolean = false)
		{
			label = labeltext;
			tooltip = tooltiptext;
			url = urlpath;
			icon = iconimage;
			bold = isbold;
		}
	}
	
}