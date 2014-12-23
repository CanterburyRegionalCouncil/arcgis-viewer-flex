package widgets.supportClasses
{
	import com.esri.ags.geometry.Extent;

	public class WebMapItem
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 */
		public function WebMapItem(id:String, owner:String, created:Date, modified:Date,
			title:String, description:String, tags:Array, snippet:String, thumbnail:String,
			extentminx:Number, extentminy:Number, extentmaxx:Number, extentmaxy:Number, 
			accessInformation:String, access:String)
		{
			this._id = id;
			this._owner = owner;
			if (!created)
			{
				this._created = new Date();			
			} else {
				this._created = created;			
			}
			if (!modified)
			{
				this._modified = new Date();			
			} else {
				this._modified = modified;			
			}
			this._title = title;
			this._description = description;
			
			if (tags)
			{
				this._tags = tags;
			}
			else 
				this._tags = [];
			this._snippet = snippet;
			this._thumbnail = thumbnail;
			this._extentminx = extentminx;
			this._extentminy = extentminy;
			this._extentmaxx = extentmaxx;
			this._extentmaxy = extentmaxy;
			this._accessInformation = accessInformation;
			this._access = access;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//  Id
		//--------------------------------------------------------------------------
		
		private var _id:String;
		
		public function get Id():String
		{
			return _id;
		}
		
		
		//--------------------------------------------------------------------------
		//  Owner
		//--------------------------------------------------------------------------
		
		private var _owner:String;
		
		public function get Owner():String
		{
			return _owner;
		}

		public function set Owner(value:String):void
		{
			_owner = value;
		}
		
		
		//--------------------------------------------------------------------------
		//  Created
		//--------------------------------------------------------------------------
		
		private var _created:Date;
		
		public function get Created():Date
		{
			return _created;
		}
		
		public function set Created(value:Date):void
		{
			_created = value;
		}
		
		
		//--------------------------------------------------------------------------
		//  Modified
		//--------------------------------------------------------------------------
		
		private var _modified:Date;
		
		public function get Modified():Date
		{
			return _modified;
		}
		
		public function set Modified(value:Date):void
		{
			_modified = value;
		}
		
		
		//--------------------------------------------------------------------------
		//  Title
		//--------------------------------------------------------------------------
		
		private var _title:String;
		
		public function get Title():String
		{
			return _title;
		}
		
		public function set Title(value:String):void
		{
			_title = value;
		}

		
		//--------------------------------------------------------------------------
		//  Description
		//--------------------------------------------------------------------------
		
		private var _description:String;
		
		public function get Description():String
		{
			return _description;
		}
		
		public function set Description(value:String):void
		{
			_description = value;
		}		
		
		
		//--------------------------------------------------------------------------
		//  Tags
		//--------------------------------------------------------------------------
		
		private var _tags:Array = [];
		
		public function get Tags():Array
		{
			return _tags;
		}
		
		public function set Tags(value:Array):void
		{
			if (value)
				_tags = value;
		}				
		
		
		//--------------------------------------------------------------------------
		//  Snippet
		//--------------------------------------------------------------------------
		
		private var _snippet:String;
		
		public function get Snippet():String
		{
			return _snippet;
		}
		
		public function set Snippet(value:String):void
		{
			_snippet = value;
		}		

		
		//--------------------------------------------------------------------------
		//  Thumbnail
		//--------------------------------------------------------------------------
		
		private var _thumbnail:String;
		
		public function get Thumbnail():String
		{
			return _thumbnail;
		}
		
		public function set Thumbnail(value:String):void
		{
			_thumbnail = value;
		}		

		
		//--------------------------------------------------------------------------
		//  Extent MinX
		//--------------------------------------------------------------------------
		
		private var _extentminx:Number;
		
		public function get ExtentMinX():Number
		{
			return _extentminx;
		}
		
		public function set ExtentMinX(value:Number):void
		{
			_extentminx = value;
		}		
		
		
		//--------------------------------------------------------------------------
		//  Extent MinY
		//--------------------------------------------------------------------------
		
		private var _extentminy:Number;
		
		public function get ExtentMinY():Number
		{
			return _extentminy;
		}
		
		public function set ExtentMinY(value:Number):void
		{
			_extentminy = value;
		}				
		
		
		//--------------------------------------------------------------------------
		//  Extent MaxX
		//--------------------------------------------------------------------------
		
		private var _extentmaxx:Number;
		
		public function get ExtentMaxX():Number
		{
			return _extentmaxx;
		}
		
		public function set ExtentMaxX(value:Number):void
		{
			_extentmaxx = value;
		}		
		
		
		//--------------------------------------------------------------------------
		//  Extent MaxY
		//--------------------------------------------------------------------------
		
		private var _extentmaxy:Number;
		
		public function get ExtentMaxY():Number
		{
			return _extentmaxy;
		}
		
		public function set ExtentMaxY(value:Number):void
		{
			_extentminy = value;
		}				

		
		//--------------------------------------------------------------------------
		//  AccessInformation
		//--------------------------------------------------------------------------
		
		private var _accessInformation:String;
		
		public function get AccessInformation():String
		{
			return _accessInformation;
		}
		
		public function set AccessInformation(value:String):void
		{
			_accessInformation = value;
		}		

		
		//--------------------------------------------------------------------------
		//  LicenseInfo
		//--------------------------------------------------------------------------
		
		private var _licenseInfo:String;
		
		public function get LicenseInfo():String
		{
			return _licenseInfo;
		}
		
		public function set LicenseInfo(value:String):void
		{
			_licenseInfo = value;
		}		

		
		//--------------------------------------------------------------------------
		//  Access
		//--------------------------------------------------------------------------
		
		private var _access:String;
		
		public function get Access():String
		{
			return _access;
		}
		
		public function set Access(value:String):void
		{
			_access = value;
		}		
		
		
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		public function toObject():Object
		{
			return {
				id: this._id, owner: this._owner, created: Date.parse(this._created.toString()), modified: Date.parse(this._modified.toString()),
				guid: null, name: null, title: this._title, type: "Web Map", typeKeywords: ["ArcGIS Online","Explorer Web Map","Map","Online Map","Web Map"],
				description: this._description, tags: this._tags, snippet: this._snippet, 
				thumbnail: this._thumbnail, documentation: null, extent: [[this._extentminx, this._extentminy],[this._extentmaxx, this._extentmaxy]],
				spatialReference: null, accessInformation: this._accessInformation, licenseInfo: this._licenseInfo,
				culture: "en-us", properties: null, url:null, access: this._access, numComments: 0, commentsEnabled: false, listed: false, largeThumbnail: false,
				appCategories: [], industries: [], languages: [], banner: null, screenshots: [], numRatings: 0, avgRating: 0, numViews: 1
			};
			
		}
		
	}
}