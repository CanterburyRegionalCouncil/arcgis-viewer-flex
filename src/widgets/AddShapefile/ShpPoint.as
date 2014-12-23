package widgets.AddShapefile
{
    import com.esri.ags.geometry.Extent;
    import com.esri.ags.geometry.Geometry;
    import com.esri.ags.geometry.MapPoint;
    import com.esri.ags.SpatialReference;

    public class ShpPoint extends Geometry
    {
        private var xcoor:int;

        private var ycoor:int;

        public function ShpPoint(xco:int, yco:int)
        {
            xcoor = xco;
            ycoor = yco;
        }

        public function toPoint(shpSpatialRef:SpatialReference):MapPoint
        {
            return new MapPoint(xcoor, ycoor, shpSpatialRef);
        }
    }
}