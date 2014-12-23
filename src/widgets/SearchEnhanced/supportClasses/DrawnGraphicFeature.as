package widgets.SearchEnhanced.supportClasses
{
	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.Geometry;

	/**
	 * Class for binding to result graphic seletion features.
	 */
	public class DrawnGraphicFeature
	{
		public function DrawnGraphicFeature(newid:int, newgraphic:Graphic)
		{
			this.id = newid;
			this.graphic = newgraphic;
		}
		
		public var id:int;
		public var graphic:Graphic;
		
		public function get geometry():Geometry
		{
			return graphic.geometry;
		}
		
		public function get GraphicType():String
		{
			var gttype:String = "";
			
			switch(graphic.geometry.type)
			{
				case Geometry.MAPPOINT:
				{
					gttype = "Point Graphic";
					break;
				}

				case Geometry.POLYLINE:
				{
					gttype = "Line Graphic";
					break;
				}

				case Geometry.EXTENT:
				case Geometry.POLYGON:
				{
					gttype = "Polygon Graphic";
					break;
				}

				case Geometry.MULTIPOINT:
				{
					gttype = "Multipoint Graphic";
					break;
				}
			}
			
			return gttype;
		}
	}
}