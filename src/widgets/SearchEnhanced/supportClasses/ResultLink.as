package widgets.SearchEnhanced.supportClasses
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.utils.StringUtil;
	
	[Bindable]
	public class ResultLink extends EventDispatcher
	{
		public function ResultLink(url:String, label:String, target:IEventDispatcher=null)
		{
			super(target);
			
			this.url = url;
			this.label = label;
		}
		
		public var url:String;
		
		public var label:String;
		
		public function get popupLink():String
		{
			var popup:String = ""; 
			
			/* Altered by Ryan Elley 07/03/2013 - Removes trailing spaces from any url */ 
			
			var urlstring:String = StringUtil.trim(url);
			
			if (urlstring && urlstring.length > 0)
			{
				if (label)
				{
					popup = "<a href='" + urlstring + "'>" + label + "</a>";
				}
				else
				{
					popup = "<a href='" + urlstring + "'>" + url + "</a>";
				}
			}
			
			// Return the result as a popup setting			
			return popup;
		}
	}
}