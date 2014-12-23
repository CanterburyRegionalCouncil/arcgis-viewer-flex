package widgets.supportClasses.utils
{
	import com.esri.ags.Map;
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.Extent;
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.geometry.Multipoint;
	import com.esri.ags.geometry.Polygon;
	import com.esri.ags.geometry.Polyline;
	import com.esri.ags.tasks.GeometryService;
	import com.esri.ags.utils.GeometryUtil;
	import com.esri.ags.utils.WebMercatorUtil;
	
	import flash.geom.Point;
	
	import mx.rpc.IResponder;
	
	public class GeometryUtil
	{
		private static const EPSG_GEOGRAPHIC:Number = 4326;
		
		/**
		 * Serialises an esri geometry to a generic object for saving. 
		 */
		public static function GeometryToObject(geometry:Geometry):Object
		{
			var object:Object = {};
			
			// Check for valid geometry
			if (geometry != null)
			{
				// Create an object to store spatial reference into
				var spatialReference:Object = { wkid: geometry.spatialReference.wkid };
				object.spatialReference = spatialReference;
				
				
				// Determine geometry type
				var pt:MapPoint;
				switch (geometry.type)
				{
					case Geometry.MAPPOINT:
					{
						// Geometry is a point - store x and y values
						pt = geometry as MapPoint;
						object.x = pt.x;
						object.y = pt.y;
						
						break;
					}
						
					case Geometry.EXTENT:
					{
						// Geometry is an extent - store xmin, xmax, ymin, ymax, height and width
						var ext:Extent = geometry as Extent;
						object.xmax = ext.xmax;
						object.ymax = ext.ymax;
						object.xmin = ext.xmin;
						object.ymin = ext.ymin;
						object.height = ext.height;
						object.width = ext.width;
						
						break;
					}
						
					case Geometry.POLYLINE:
					{
						// Geometry is a polyline - store in paths array an array of points for each path
						var line:Polyline = geometry as Polyline;
						var paths:Array = [];
						
						// Iterate through each path
						for each(var path:Array in line.paths)
						{
							// Create a new points array
							var pathpts:Array = [];
							
							// Iterate through each point in the path
							for each(pt in path)
							{
								pathpts.push([ pt.x, pt.y ]);		
							}
							paths.push(pathpts);
						}
						object.paths = paths;
						
						break;
					}
						
					case Geometry.POLYGON:
					{
						// Geometry is a polygon - store in rings array an array of points for each ring
						var polygon:Polygon = geometry as Polygon;
						var rings:Array = [];
						
						// Iterate through each path
						for each(var ring:Array in polygon.rings)
						{
							// Create a new points array
							var ringpts:Array = [];
							
							// Iterate through each point in the ring
							for each(pt in ring)
							{
								ringpts.push([ pt.x, pt.y ]);		
							}
							rings.push(ringpts);
						}
						object.rings = rings;
						
						break;
					}
						
					case Geometry.MULTIPOINT:
					{
						// Geometry is a multipoint feature - store in points array point objects
						var multipoint:Multipoint = geometry as Multipoint;
						
						var points:Array = [];
						for each(pt in multipoint.points)
						{
							points.push( {x:pt.x, y:pt.y} );						
						}
						object.points = points;
						
						break;
					}
				}
			}
			
			return object;
		}
		
		/**
		 * Reconstitutes a serialised geometry.  
		 */
		public static function ObjectToGeometry(object:Object):Geometry
		{
			// Create a geometry reference
			var geometry:Geometry; 
			
			if (object.spatialReference)
			{
				var wkid:Number = Number(object.spatialReference.wkid);
				var spatialref:SpatialReference = new SpatialReference(wkid);		
				var pt:MapPoint;
				
				// Check for attributes that are specific to geometry types
				if (object.x && object.y)
				{
					// Geometry is a map point
					pt = new MapPoint(Number(object.x),Number(object.y),spatialref);
					geometry = pt;
				}
				
				if (object.paths)
				{
					// Geometry is a line
					var paths:Array = [];
					
					for each (var pth:Object in object.paths)
					{
						var path:Array = [];
						for each (var mpt:Object in pth)
						{
							pt = new MapPoint(Number(mpt[0]),Number(mpt[1]),spatialref);
							path.push(pt);
						}
						paths.push(path);	
					}
					
					var lin:Polyline = new Polyline(paths,spatialref);
					geometry = lin;
				}
				
				if (object.rings)
				{
					// Geometry is a polygon
					var rings:Array = [];
					
					for each (var rng:Object in object.rings)
					{
						var ring:Array = [];
						for each (var ppt:Object in rng)
						{
							pt = new MapPoint(Number(ppt[0]),Number(ppt[1]),spatialref);
							ring.push(pt);
						}
						rings.push(ring);	
					}
					
					var pol:Polygon = new Polygon(rings,spatialref);
					geometry = pol;
				}
				
				if (object.points)
				{
					// Geometry is a multipoint
					var points:Array = [];
					
					for each (var ept:Object in object.points)
					{
						pt = new MapPoint(Number(ept.x),Number(ept.y),spatialref);
						points.push(pt);
					}
					
					var mul:Multipoint = new Multipoint(points,spatialref);
					geometry = mul;
				}
				
				if (object.width && object.height)
				{
					// Geometry is an extent
					var ext:Extent = new Extent(Number(object.xmin),Number(object.ymin),Number(object.xmax),
						Number(object.ymax),spatialref);
					geometry = ext;
				}
			}
			
			return geometry;
		}
		
		/**
		 * Function to return an exact copy of the supplied geometry features. 
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>geometry [Geometry]: </i>Geometry shape from which to extract the map point</li>
		 * </ul>
		 * </p> 
		 */
		public static function DuplicateGeometry(geometry:Geometry):Geometry
		{
			var newGeometry:Geometry;
			var json:Object = geometry.toJSON();
			newGeometry = Geometry.fromJSON(json);
			return newGeometry;
		}
		
		/**
		 * Static method to return a geometry feature moved by a defined x/y offset
		 */
		public static function moveGeometryXYOffset(geometry:Geometry, dx:Number, dy:Number):Geometry
		{
			var newGeometry:Geometry;
			var pt:MapPoint;
			
			// Check the geometry type			
			switch (geometry.type)
			{
				case Geometry.MAPPOINT:
				{
					pt = geometry as MapPoint;
					newGeometry = pt.offset(dx,dy);										
					break;
				}
					
				case Geometry.MULTIPOINT:
				{
					var mulPt:Multipoint = geometry as Multipoint;
					var newMulPt:Multipoint = new Multipoint([],mulPt.spatialReference);
					
					for each (pt in mulPt.points)
					{
						newMulPt.addPoint(pt.offset(dx,dy));	
					}
					newGeometry = newMulPt;
					break;
				}
					
				case Geometry.EXTENT:
				{
					var ext:Extent = geometry as Extent;
					newGeometry = ext.offset(dx,dy);
					break;
				}
					
				case Geometry.POLYGON:
				{
					var pol:Polygon = geometry as Polygon;
					var newPol:Polygon = new Polygon([],pol.spatialReference);
					
					for each (var ring:Array in pol.rings)
					{
						var newRing:Array = [];
						for each (pt in ring)
						{
							newRing.push(pt.offset(dx,dy));
						}
						newPol.rings.push(newRing);
					}
					newGeometry = newPol;
					break;
				}
					
				case Geometry.POLYLINE:
				{
					var lin:Polyline = geometry as Polyline;
					var newLin:Polyline = new Polyline([],lin.spatialReference);
					
					for each (var path:Array in lin.paths)
					{
						var newPath:Array = [];
						for each (pt in path)
						{
							newPath.push(pt.offset(dx,dy));
						}
						newLin.paths.push(newPath);
					}
					newGeometry = newLin;
					break;
				}
			}
			// Return the offset geometry
			return newGeometry;
		}
		
		/**
		 * Static method to return a geometry centered at the given x/y coordinates
		 */
		public static function moveGeometryToXY(geometry:Geometry, x:Number, y:Number):Geometry
		{
			var newGeometry:Geometry;
			var pt:MapPoint;
			
			var dx:Number;
			var dy:Number;
			
			// Check the geometry type			
			switch (geometry.type)
			{
				case Geometry.MAPPOINT:
				{
					pt = geometry as MapPoint;
					dx = x - pt.x;
					dy = y - pt.y;
					
					newGeometry = pt.offset(dx,dy);										
					break;
				}
					
				case Geometry.EXTENT:
				case Geometry.MULTIPOINT:
				case Geometry.POLYGON:
				case Geometry.POLYLINE:
				{
					var ext:Extent = geometry.extent;
					dx = x - ext.center.x;
					dy = y - ext.center.y;
					
					newGeometry = moveGeometryXYOffset(geometry,dx,dy);
					break;
				}
			}
			// Return the offset geometry
			return newGeometry;
		}
		
		/**
		 * Static method to return a geometry centered at the given x/y coordinates
		 */
		public static function createCircle(x:Number, y:Number, radius:Number, sref:SpatialReference, 
											divisions:int = 10, isPoly:Boolean = true):Geometry
		{
			var newGeometry:Geometry;
			var pts:Array = [];
			for (var i:Number = 0; i <= divisions; i++)
			{
				var pointRatio:Number = i/divisions;	
				var xSteps:Number = circleTrigFunctionX(pointRatio);
				var ySteps:Number = circleTrigFunctionY(pointRatio);
				var pointX:Number = x + xSteps * radius;
				var pointY:Number = y + ySteps * radius;
				var pt:MapPoint = new MapPoint(pointX,pointY,sref);
				pts.push(pt);
			}
			
			// Determine if this will be a polyline or a polygon
			if (isPoly)
			{
				var pol:Polygon = new Polygon([pts],sref);
				newGeometry = pol;				
			} 
			else
			{
				var lin:Polyline = new Polyline([pts],sref);
				newGeometry = lin;
			}
			
			// Return the circle geometry
			return newGeometry;
		}
		
		/**
		 * Function used in deterining the x coordinate from a bearing
		 */
		public static function circleTrigFunctionX (pointRatio:Number):Number
		{
			return Math.cos(pointRatio*2*Math.PI);
		}
		
		/**
		 * Function used in deterining the y coordinate from a bearing
		 */
		public static function circleTrigFunctionY (pointRatio:Number):Number
		{
			return Math.sin(pointRatio*2*Math.PI);
		}
		
		/**
		 * Function to return a representative x ccordinate for geometry features.  For line geometry this 
		 * is the x ccordinate of the point at the centre of the line feature, while for polygons this would 
		 * be the x coordinate of the polygon extent.
		 */
		public static function getX(geometry:Geometry):Number
		{
			var x:Number;
			var pt:MapPoint = getMapPoint(geometry);
			
			if (pt)
				x = pt.x;
			
			return x;
		}
		
		/**
		 * Function to return a representative y ccordinate for geometry features.  For line geometry this 
		 * is the y ccordinate of the point at the centre of the line feature, while for polygons this would 
		 * be the y coordinate of the polygon extent.
		 */
		public static function getY(geometry:Geometry):Number
		{
			var y:Number;
			var pt:MapPoint = getMapPoint(geometry);
			
			if (pt)
				y = pt.y;
			
			return y;
		}
		
		/**
		 * Function to return a representative point for geometry features.  For line geometry this 
		 * is the point at the centre of the line feature, while for polygons this would 
		 * be the centroid of the polygon extent.  If a bouding extent is supplied, the point returned fixed to within that extent. 
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>geometry [Geometry]: </i>Geometry shape from which to extract the map point</li>
		 * <li><i>extent [Extent] (optional): </i>Extent to use as a boundary when extracting the the point.
		 * If null, the point will be the centroid of the whole shape.</li>
		 * </ul>
		 * </p> 
		 */
		public static function getMapPoint(geometry:Geometry, extent:Extent = null):MapPoint
		{
			var pt:MapPoint;
			
			if (geometry)
			{
				switch (geometry.type)
				{
					case Geometry.MULTIPOINT:
					case Geometry.POLYGON:
					case Geometry.EXTENT:
					{
						pt = geometry.extent.center;	
						break;
					}
						
					case Geometry.POLYLINE:
					{
						/*
						const pl:Polyline = geometry as Polyline;
						const pathCount:Number = pl.paths.length;
						const pathIndex:int = int((pathCount / 2) - 1);
						const midPath:Array = pl.paths[pathIndex];
						const ptCount:Number = midPath.length;
						const ptIndex:int = int((ptCount / 2) - 1);
						pt = pl.getPoint(pathIndex, ptIndex);
						*/
						
						const pl:Polyline = geometry as Polyline;
						pt = alongLine(pl,50,true);
						
						break;
					}
						
					case Geometry.MAPPOINT:
					{
						pt = MapPoint(geometry);
						break;
					}
				}
			}
			return pt;
		}
		
		/**
		 * Function to return a representative label point for geometry features.  For line 
		 * geometry this is the point at the centre of the line feature, while for polygons 
		 * this would be the centroid of the polygon extent.
		 */
		public static function getLabelPosition(geom:Geometry):MapPoint
		{
			var pt:MapPoint;
			
			// Determine the type of the geometry being measured. 
			switch (geom.type)
			{
				case Geometry.POLYLINE:
				{
					/*
					var polyline:Polyline = geom as Polyline;
					var pathIndex:int;
					if (polyline.paths.length == 1)
					{
					pathIndex = 0;
					}
					else
					{
					pathIndex = int((polyline.paths.length / 2) - 1);
					}
					var path:Array = polyline.paths[pathIndex];
					var ptIndex:int = int(( path.length / 2) - 1);
					pt = polyline.getPoint(pathIndex, ptIndex);
					*/
					
					const pl:Polyline = geom as Polyline;
					pt = alongLine(pl,50,true);
					
					break;
				}
				case Geometry.POLYGON:
				{
					var polygon:Polygon = geom as Polygon;
					var polygonExtent:Extent;
					if (polygon.rings.length == 1)
					{
						polygonExtent = polygon.extent;
					}
					else
					{
						// Multiple rings, hence show the measurement label at the center of first ring
						var tempPolygon:Polygon = new Polygon;
						tempPolygon.rings = [ polygon.rings[0]];
						polygonExtent = tempPolygon.extent;
					}
					pt = polygonExtent.center;
					break;
				}
				case Geometry.EXTENT:
				{
					pt = geom.extent.center;
					break;
				}
			}
			
			return pt;
		}
		
		/**
		 * Calculates the length of a line segment in map units, and applies conversion factor 
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>startPt [MapPoint]: </i>Map point representing the start of the line segment</li>
		 * <li><i>endPt [MapPoint]: </i>Map point representing the start of the line segment</li>
		 * <li><i>conversion [Number] (optional): </i>Conversion factor to apply to the map unit measurements</li>
		 * </ul>
		 * </p> 
		 */
		public static function getSegmentLength(startPt:MapPoint, endPt:MapPoint, 
												conversion:Number = 1):Number
		{
			// Check for valid parameters
			if (startPt && endPt) {
				var dX:Number;
				var dY:Number;
				
				// Check SRID for Geographic Coordinates
				if (startPt.spatialReference && startPt.spatialReference.wkid == EPSG_GEOGRAPHIC)
				{
					var stPt:MapPoint = WebMercatorUtil.geographicToWebMercator(startPt) as MapPoint;
					var edPt:MapPoint = WebMercatorUtil.geographicToWebMercator(endPt) as MapPoint;
					
					dX = stPt.x - edPt.x;
					dY = stPt.y - edPt.y;
				}
				else
				{
					dX = startPt.x - endPt.x;
					dY = startPt.y - endPt.y;
				}
				var lin:Number =  Math.sqrt((dX*dX) + (dY*dY)); 
				return lin * conversion;
			}
			else 
				return 0;
		}
		
		/**
		 * Calculates the area of an extent based on the coordinates of its centroid and one of its corners,
		 * the applies an area unit conversion factor
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>centrePt [MapPoint]: </i>Map point representing the centroid of an extent object</li>
		 * <li><i>endPoint [MapPoint]: </i>Map point representing one corner of the extent object</li>
		 * <li><i>conversion [Number] (optional): </i>Conversion factor to apply to the map unit measurements</li>
		 * </ul>
		 * </p> 
		 */
		public static function getExtentArea(centrePt:MapPoint, cornerPt:MapPoint,
											 conversion:Number = 1):Number
		{
			var dX:Number = centrePt.x - cornerPt.x;
			var dY:Number = centrePt.y - cornerPt.y;
			
			var area:Number = Math.abs(dX * dY * 4);
			return area * conversion;
		}
		
		/**
		 * Calculates a map point a given distance along a line segment;
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>startPt [MapPoint]: </i>Map point representing the start of the line segment</li>
		 * <li><i>endPt [MapPoint]: </i>Map point representing the start of the line segment</li>
		 * <li><i>distance [Number]: </i>Distance along the length of the line segment that should be returned</li>
		 * </ul>
		 * </p> 
		 */
		public static function alongLineSegment(startPt:MapPoint, endPt:MapPoint, distance:Number):MapPoint
		{
			var dX:Number;
			var dY:Number;
			var endX:Number; 
			var endY:Number; 
			var gstartPt:MapPoint;
			var gendPt:MapPoint;
			var outPt:MapPoint;
			var isGeographic:Boolean = false;
			
			// Check SRID for Geographic Coordinates
			if (startPt.spatialReference && startPt.spatialReference.wkid == EPSG_GEOGRAPHIC)
			{
				isGeographic = true;
				gstartPt = WebMercatorUtil.geographicToWebMercator(startPt) as MapPoint;
				gendPt = WebMercatorUtil.geographicToWebMercator(endPt) as MapPoint;
				
				dX = gstartPt.x - gendPt.x;
				dY = gstartPt.y - gendPt.y;
			}
			else
			{
				dX = startPt.x - endPt.x;
				dY = startPt.y - endPt.y;
			}
			var segLength:Number =  Math.sqrt((dX*dX) + (dY*dY)); 
			
			// Check the requested distance doesn't exceed the length of the segment
			if (segLength > distance) {
				// Calculate percentage of total length
				var per:Number = distance/segLength;
				if (isGeographic) {
					endX = gstartPt.x - dX*per;
					endY = gstartPt.y - dY*per;
					
					outPt = WebMercatorUtil.webMercatorToGeographic(new MapPoint(endX, endY)) as MapPoint;
				}
				else {
					endX = startPt.x - dX*per;
					endY = startPt.y - dY*per;
					
					outPt = new MapPoint(endX, endY, startPt.spatialReference);
				}
				
				return outPt;	
			}
			else {
				// Return the end of the line segment
				return endPt;
			}
		}
		
		/**
		 * Calculates a map point a given distance along a line.
		 * <p>
		 * <b>Parameters</b><br/>
		 * <ul>
		 * <li><i>line [Polyline]: </i>Line along which the point is to be calculated</li>
		 * <li><i>distance [Number]: </i>Distance along the length of the line that should be returned as a map point</li>
		 * <li><i>isPercentage [Boolean](optional): </i>Flag for whether the distance provided is a measure distance or a percentage of the total line length.. If true, ditance should be expressed as a number between 0 and 100</li>
		 * </ul>
		 * </p> 
		 */
		public static function alongLine(line:Polyline, distance:Number, isPercentage:Boolean = false):MapPoint
		{
			// Get the length of the line
			var lineLength:Number = returnSimpleLength(line); 
			
			var pathCnt:Number = line.paths.length;
			var pointCnt:Number;			
			
			var outPt:MapPoint;
			
			if (isPercentage && distance >= 100)
			{
				// Return the last point in the line
				pointCnt = line.paths[pathCnt - 1].length;
				outPt = line.getPoint(pathCnt - 1, pointCnt - 1);				
			}
			else {	
				if (isPercentage) {
					distance = lineLength * distance/100;
				} 
				
				// Iterate through each path/segment until the target length is reached
				var segLength:Number;
				var calcLength:Number = 0;
				var path:int;
				var pt:int;
				var startPt:MapPoint;
				var endPt:MapPoint;
				
				// Iterate through the paths
				for (path = 0; path < pathCnt; path++) {
					pointCnt = line.paths[path].length;
					
					// Iterate through the points in the path
					for (pt = 0; pt < pointCnt - 1; pt++) {
						startPt = line.getPoint(path, pt);
						endPt = line.getPoint(path, pt+1);
						segLength = getSegmentLength(startPt, endPt,1);
						
						if (calcLength + segLength > distance) {
							var segDistance:Number = distance - calcLength;
							outPt = alongLineSegment(startPt, endPt, segDistance);
							break;
						}
						else {
							calcLength += segLength;
						}
					}
					
					if (outPt != null)
					{
						break;
					}
				}
			}
			
			return outPt;
		}
		
		/**
		 * NOT COMPLETE
		 */
		public static function divideLine(line:Polyline, distance:Number, isDivisionNumber:Boolean = false):Array
		{
			// Get the length of the line
			var lineLength:Number = returnSimpleLength(line); 
			
			if (isDivisionNumber)
			{
				distance = (lineLength/distance) as int;
			}

			var pathCnt:int = line.paths.length;
			var pointCnt:Number;			
			
		
			var pointsList:Array = [];
			
			
			
			
			return pointsList;
		}
		
		
		/* Geometry Manipulation
		------------------------------------------------------------------------------------------------------------------- */
		
		/**
		 * Updates the location of a specific vertex in a polyline feature.
		 */
		public static function updatePolylineVertex(polyline:Polyline,oldPt:MapPoint, newPt:MapPoint):Polyline
		{
			// Find the path and point number
			var pathid:int = 0;
			var ptid:int;
			var found:Boolean = false;
			
			// Iterate through each path
			for each (var path:Array in polyline.paths)
			{
				// Reset the point count
				ptid = 0;
				
				// Iterate through the map points
				for each (var pt:MapPoint in path)
				{
					if (pt.x == oldPt.x && pt.y == oldPt.y)
					{
						// Point found - update to the new point location
						polyline.setPoint(pathid,ptid,newPt);
						
						// Update found flag
						found = true;
						break;
					}
					else 
					{
						ptid += 1;
					}
				}
				
				// Increment pathid
				if (found)
				{
					break;
				}
				else 
				{
					pathid += 1;
				}
			}
			
			// Return the updated feature
			return polyline;
		}
		
		/**
		 * Updates the location of a specific vertex in a polygon feature.
		 */
		public static function updatePolygonVertex(polygon:Polygon,oldPt:MapPoint, newPt:MapPoint):Polygon
		{
			// Find the ring and point number
			var ringid:int = 0;
			var ptid:int;
			var found:Boolean = false;
			
			// Iterate through each ring
			for each (var ring:Array in polygon.rings)
			{
				// Reset the point count
				ptid = 0;
				
				// Iterate through the map points
				for each (var pt:MapPoint in ring)
				{
					if (pt.x == oldPt.x && pt.y == oldPt.y)
					{
						// Point found - update to the new point location
						polygon.setPoint(ringid,ptid,newPt);
						
						// Update found flag
						found = true;
						break;
					}
					else 
					{
						ptid += 1;
					}
				}
				
				// Increment pathid
				if (found)
				{
					break;
				}
				else 
				{
					ringid += 1;
				}
			}
			
			// Return the updated feature
			return polygon;
		}
		
		/**
		 * Function to generate an extent around a map point.  For use with search widgets that use points to search layers.  
		 */
		public static function createExtentAroundMapPoint(centerPoint:MapPoint, tolerance:Number, map:Map):Extent
		{
			var screenPoint:Point = map.toScreen(centerPoint as MapPoint);
			
			var upperLeftScreenPoint:Point = new Point(screenPoint.x - tolerance, screenPoint.y - tolerance);
			var lowerRightScreenPoint:Point = new Point(screenPoint.x + tolerance, screenPoint.y + tolerance);
			
			var upperLeftMapPoint:MapPoint = map.toMap(upperLeftScreenPoint);
			var lowerRightMapPoint:MapPoint = map.toMap(lowerRightScreenPoint);
			
			return new Extent(upperLeftMapPoint.x, upperLeftMapPoint.y, lowerRightMapPoint.x, lowerRightMapPoint.y, map.spatialReference);
		}
		
		/**
		 * Function determines whether a specified geometry contains multipart geometry.  
		 */		
		public static function isMultiPart(geometry:Geometry):Boolean
		{
			var result:Boolean = false
			
			switch(geometry.type)
			{
				case Geometry.MULTIPOINT:
				{
					var mpt:Multipoint = geometry as Multipoint;
					if (mpt.points.length > 1)
					{
						result = true;
					}
					break;
				}
					
				case Geometry.POLYGON:					
				{
					var pol:Polygon = geometry as Polygon;
					if (pol.rings.length > 1)
					{
						result = true;
					}
					break;
				}
					
				case Geometry.POLYLINE:					
				{
					var lin:Polyline = geometry as Polyline;
					if (lin.paths.length > 1)
					{
						result = true;
					}
					break;
				}
					
				default:
				{
					// Used for MapPoint and Extent geometry which can't be multipart
					break;
				}
			}
			
			return result;
		}
		
		/**
		 * Converts a multipart geometry into an array of single part geometry of the same type.
		 */
		public static function ExplodeMultiPart(geometry:Geometry):Array
		{
			var parts:Array = [];
			var pt:MapPoint;
			var pth:Array;
			
			switch(geometry.type)
			{
				case Geometry.MULTIPOINT:
				{
					var mpt:Multipoint = geometry as Multipoint;
					for each(pt in mpt.points)
					{
						parts.push(pt);
					}
					break;
				}
					
				case Geometry.POLYGON:					
				{
					var pol:Polygon = geometry as Polygon;
					if (pol.rings.length > 1)
					{
						for each (pth in pol.rings)
						{
							var npol:Polygon = new Polygon([pth], geometry.spatialReference);						
							parts.push(npol);
						}
					}
					else
					{
						parts.push(pol);						
					}
					break;
				}
					
				case Geometry.POLYLINE:					
				{
					var lin:Polyline = geometry as Polyline;
					if (lin.paths.length > 1)
					{
						for each (pth in lin.paths)
						{
							var nlin:Polyline = new Polyline([pth], geometry.spatialReference);						
							parts.push(nlin);
						}
					}
					else
					{
						parts.push(lin);						
					}
					break;
				}
					
				default:
				{
					// Used for MapPoint and Extent geometry which can't be multipart
					parts.push(geometry);
					break;
				}
			}
			
			return parts;			
		}
		
		
		
		/*
		Functions for simple calculations of area and length
		*/
		
		/**
		 * Calculates the area of a supplied polygon or extent object.  Returns 0 for all other geometry types.
		 */
		public static function returnSimpleArea(geometry:Geometry):Number
		{
			var area:Number;
			
			switch (geometry.type) 
			{
				case Geometry.EXTENT:
					var ext:Extent = geometry as Extent;
					area = ext.height * ext.width;
					break;
				
				case Geometry.POLYGON:
					var pol:Polygon = geometry as Polygon;
					area = 0;
					
					// Check if simple geometry
					if (pol.rings && pol.rings.length > 0) 
					{
						var ring:Array = pol.rings[0];
						
						var d1:Number;
						var d2:Number
						var p1:MapPoint;
						var p2:MapPoint;
						
						var i:int;
						var il:int = ring.length;
						if (il > 2) 
						{
							d1 = 0;
							d2 = 0;
							//for (i=0; i < il -2; i++)
							for (i=il - 1; i > 0; i--)
							{
								p1 = ring[i];
								p2 = ring[i - 1];
								
								d1 += p1.x * p2.y;
								d2 += p1.y * p2.x;
							}
							
							// do final calculation on last point to first point
							p1 = ring[0];
							p2 = ring[il - 1];
							
							d1 += p1.x * p2.y;
							d2 += p1.y * p2.x;
							
							// Calculate the area value
							area = Math.abs((d1 - d2)/2);
						}
					}
					
					break;
				
				default:
					area = 0;					
			}
			return area;
		}
		
		/**
		 * Calculates the length of lines or the perimeter of a supplied polygon or extent object.  Returns 0 for all other geometry types.
		 */
		public static function returnSimpleLength(geometry:Geometry):Number
		{
			var length:Number;
			var p1:MapPoint;
			var p2:MapPoint;
			var i:int;
			var il:int;
			var l:Number;
			
			switch (geometry.type) 
			{
				case Geometry.EXTENT:
					var ext:Extent = geometry as Extent;
					length = ext.height * 2 +  ext.width * 2;
					break;
				
				case Geometry.POLYLINE:
					var lin:Polyline = geometry as Polyline;
					length = 0;
					
					// Check if simple geometry
					if (lin.paths && lin.paths.length > 0)
					{
						var path:Array = lin.paths[0];						
						il = path.length;
						
						for (i=0; i < il - 1; i++)
						{
							p1 = path[i];
							p2 = path[i + 1];
							l = getSegmentLength(p1,p2);
							length += l;
						}
						
						// Calculate the length value
						length = Math.abs(length);
					}
					break;
				
				case Geometry.POLYGON:
					var pol:Polygon = geometry as Polygon;
					length = 0;
					
					// Check if simple geometry
					if (pol.rings && pol.rings.length > 0) 
					{
						var ring:Array = pol.rings[0];
						il = ring.length;
						
						if (il > 1) 
						{
							for (i=0; i < il - 1; i++)
							{
								p1 = ring[i];
								p2 = ring[i + 1];
								
								l = getSegmentLength(p1,p2);
								length += l;
							}
							
							// Calculate the length value
							length = Math.abs(length);
						}
					}
					break;
				
				default:
					length = 0;					
			}
			return length;			
		}
		
		/**
		 * Calculates the length of latest line segment in the line or the perimeter of the supplied polygon or extent object.  Returns 0 for all other geometry types.
		 */
		public static function returnLastSegmentLength(geometry:Geometry):Number
		{
			var length:Number;
			var p1:MapPoint;
			var p2:MapPoint;
			var i:int;
			var il:int;
			var l:Number;
			
			switch (geometry.type) 
			{
				case Geometry.EXTENT:
					var ext:Extent = geometry as Extent;
					length = ext.height * 2 +  ext.width * 2;
					break;
				
				case Geometry.POLYLINE:
					var lin:Polyline = geometry as Polyline;
					length = 0;
					
					// Check if simple geometry
					if (lin.paths && lin.paths.length > 0)
					{
						var path:Array = lin.paths[0];						
						il = path.length;
						
						p1 = path[il - 2];
						p2 = path[il - 1];
						length = getSegmentLength(p1,p2);
						
						// Calculate the length value
						length = Math.abs(length);
					}
					break;
				
				case Geometry.POLYGON:
					var pol:Polygon = geometry as Polygon;
					length = 0;
					
					// Check if simple geometry
					if (pol.rings && pol.rings.length > 0) 
					{
						var ring:Array = pol.rings[0];
						il = ring.length;
						
						if (il == 2) 
						{
							p1 = ring[il - 2];
							p2 = ring[il - 1];
							length = getSegmentLength(p1,p2);
						}
						else if (il > 2) 
						{
							p1 = ring[il - 3];
							p2 = ring[il - 2];
							length = getSegmentLength(p1,p2);
						}
						// Calculate the length value
						length = Math.abs(length);
					}
					break;
				
				default:
					length = 0;					
			}
			return length;			
		}
		
		/**
		 * Determines the circle radius of an extent. 
		 */
		public static function getCircleRadius(geometry:Geometry):Number
		{
			var length:Number;
			switch (geometry.type) 
			{
				case Geometry.EXTENT:
					var ext:Extent = geometry as Extent;
					length = ext.height/2;
					break;
				
				case Geometry.POLYGON:
					var pol:Polygon = geometry as Polygon;
					length = pol.extent.height/2;
					break;
				
				default:
					length = 0;					
			}
			return length;	
		}
		
		
		/*
		Functions inherited from ESRI GeometryUtil
		*/
		
		/**
		 * Calls the geodesicAreas function of the ESRI GeometryUtil class.
		 */
		public static function geodesicAreas(polygons:Array,areaUnit:String):Array
		{
			return com.esri.ags.utils.GeometryUtil.geodesicAreas(polygons,areaUnit);
		}
		
		/**
		 * Calls the geodesicDensify function of the ESRI GeometryUtil class.
		 */
		public static function geodesicDensify(geometry:Geometry,maxSegmentLength:Number = 100000):Geometry
		{
			return com.esri.ags.utils.GeometryUtil.geodesicDensify(geometry,maxSegmentLength);
		}
		
		/**
		 * Calls the geodesicLengths function of the ESRI GeometryUtil class.
		 */
		public static function geodesicLengths(polylines:Array,lengthUnit:String):Array
		{
			return com.esri.ags.utils.GeometryUtil.geodesicLengths(polylines,lengthUnit);
		}
		
		/**
		 * Calls the normalizeCentralMeridian function of the ESRI GeometryUtil class.
		 */
		public static function normalizeCentralMeridian(geometries:Array,geometryService:GeometryService,responder:IResponder):void
		{
			com.esri.ags.utils.GeometryUtil.normalizeCentralMeridian(geometries,geometryService,responder);
		}
		
		/**
		 * Calls the polygonSelfIntersecting function of the ESRI GeometryUtil class.
		 */
		public static function polygonSelfIntersecting(poly:Polygon):Boolean
		{
			return com.esri.ags.utils.GeometryUtil.polygonSelfIntersecting(poly);
		}
	}
}