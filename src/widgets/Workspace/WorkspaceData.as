////////////////////////////////////////////////////////////////////////////////
//
// SUMMARY
// This class provides properties to store data for a workspace. This class is used for both itemrenderer binding 
// within the widget, and as the data storage class when workspaces are persisted in SharedObject mode.
//
// SOURCE		: 
//
// DEVELOPED BY : Matthew Simmons, Geographic Business Solutions.
//
// CREATED		: 18/02/2011
// DEPENDENCIES	: 
//
// CHANGES 
// Change By 			| Change Date 	| Change Description
// Matthew Simmons (GBS)| 18/02/2011	| LegendIncludeExclude Initial Development
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010 ESRI
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////


package widgets.Workspace
{
	import com.esri.ags.Graphic;
	import com.esri.ags.geometry.Geometry;
	
	import mx.utils.UIDUtil;
	
	/**
	 * WorkspaceData acts as a binding source of a list item of the SaveWorkspace widget. An instance of the WorkspaceData class represents a single workspace. 
	 * This class is used for both itemrenderer binding within the widget, and as the data storage class when workspaces are persisted in SharedObject mode.
	 * */
	public class WorkspaceData
	{
		/**
		 * The primary key (a UniqueIdentifier). Create new values with mx.utils.UIDUtil.createUID()
		 * */
		public var WorkspaceID:String;
		
		/** How the workspace is known to the user */
		[Bindable]
		public var Title:String;
		
		/** A brief description of the workspace*/
		[Bindable]
		public var Description:String;
		
		/**
		 * Array (of Number) defining the maps Extent, in the order:
		 * [xmin, ymin, xmax, ymax, SRID]
		 */
		public var MapExtent:Array;
		
		/***
		 * Array containing Objects with the following properties
		 *    MapServiceLayerType:String - one of {"ArcGISTiledMapServiceLayer", "ArcGISDynamicMapServiceLayer" or "FeatureLayer"} 
		 *    url:String - the url of the service
		 *    visible:Boolean - whether the service was visible
		 *    visiblelayers:Array - (of Number) the visible layers in ArcGISDynamicMapServiceLayer services
		 *    layerInfos:Array - (of LayerInfo) the layer infos of ArcGISTiledMapServiceLayer and ArcGISDynamicMapServiceLayer services for visibility
		 * null for this property implies MapServices are not to be included for this Workspace. An Empty Array implies MapServices may be included, but none yet are.
		 */
		public var MapServices:Array;
		
		/**
		 * 
		 * Array containing Objects with the following properties
		 *   LayerName:String,
		 *   Graphics:Array - (of ByteArray) within each ByteArray element is an object with the following properties from a com.esri.ags.Graphic: geometry, attributes, symbol
		 * null for this property implies GraphicLayers are not to be included for this Workspace. An Empty Array implies Graphics may be included, but none yet are.
		 * */
		public var GraphicLayers:Array;
		
		/** When the workspace was first created*/
		[Bindable]
		public var CreatedTime:Date;
		
		/** When the workspace was last modified*/
		[Bindable]
		public var LastModified:Date;
		
		public function WorkspaceData()
		{
			WorkspaceID = UIDUtil.createUID();
		}
	}
}