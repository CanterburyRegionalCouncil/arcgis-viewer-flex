package widgets.LayerListEnhanced.components
{
	import com.esri.ags.layers.Layer;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class MapLayer extends EventDispatcher
	{
		public function MapLayer( layerxml:XML, label:String, type:String, icon:Class, icontip:String, 
								  keywords:String, description:String='', layer:Layer=null, 
								  add:Boolean=false, useproxy:Boolean = false, proxyurl:String = null, metaurl:String = null, target:IEventDispatcher=null)
		{
			super(target);
			this.layerXML = layerxml;
			this.label = label;
			this.type = type;
			this.icon = icon;
			this.icontip = icontip;
			this.keywords = keywords;
			this.description = description;
			this.layer = layer;
			this.add = add;
			
			if (metaurl != null)
			{
				// Check for proxy
				if (layerxml[0].@useproxy && layerxml[0].@useproxy == "true") 
				{
					this.metaurl = proxyurl + "?" + metaurl;
				}
				else
				{
					this.metaurl = metaurl;
				}
			}
		}
		
		[Bindable]
		public var label:String;
		public var type:String;

		[Bindable]
		public var icon:Class;
		
		[Bindable]
		public var icontip:String;

		public var keywords:String;
		
		[Bindable]
		public var description:String;
		public var layer:Layer;
		public var add:Boolean;
		
		public var layerXML:XML;
		
		[Bindable]
		public var metaurl:String;
	}
}