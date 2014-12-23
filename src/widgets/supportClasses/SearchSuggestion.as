package widgets.supportClasses
{
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.Extent;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Bindable]
	public class SearchSuggestion extends EventDispatcher
	{
		public static const SEARCH_RUN_QUEUED:String = "SearchWidget_QueuedSearch";
		public static const SEARCH_RUN:String = "SearchWidget_RunSearch";
		
		public function SearchSuggestion(object:Object,target:IEventDispatcher=null)
		{
			super(target);
		
			if (object)
			{
				// Populate item attributes
				if (object.searchtext)
					searchtext = object.searchtext;
	
				if (object.searchclass)
					searchclass = object.searchclass;
				
				if (object.keydescription)
					keydescription = object.keydescription;	
				
				if (object.searchkey)
					searchkey = object.searchkey;
				
				// Populate item geometry
				if (object.x && object.y && object.outSR)
				{
					var mp:MapPoint = new MapPoint(Number(object.x),Number(object.y));
					var sr:SpatialReference = new SpatialReference(Number(object.outSR));
					mp.spatialReference = sr;
					mappoint = mp;
				}
				
				if (object.geometry)
					searchgeometry = object.geometry;
				
				if (object.searchmethod)
					searchmethod = object.searchmethod;

				if (object.selectionmode)
					selectionmode = object.selectionmode;

				if (object.searchurl)
					searchurl = object.searchurl;

			}
		}
		
		public var searchtext:String;
		
		public var searchclass:String;
		
		public var searchkey:String;
		
		public var keydescription:String;
		
		public var extent:Extent;
		
		public var mappoint:MapPoint;
		
		public var icon:String;
		
		public var searchgeometry:Geometry;

		public var searchurl:String;

		/** Spatial relation method to apply to geometry based suggestions - see esri query task for more details */
		public var searchmethod:String;

		/** Mode for overiding the selection mode in the search widget */
		public var selectionmode:String;
	}
}