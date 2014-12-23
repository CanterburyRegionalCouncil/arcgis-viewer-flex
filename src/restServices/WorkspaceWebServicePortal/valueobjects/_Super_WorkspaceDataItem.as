/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - WorkspaceDataItem.as.
 */

package restServices.WorkspaceWebServicePortal.valueobjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.util.FiberUtils;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import mx.binding.utils.ChangeWatcher;
import mx.collections.ArrayCollection;
import mx.events.CollectionEvent;
import mx.events.PropertyChangeEvent;
import mx.validators.ValidationResult;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_WorkspaceDataItem extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void
    {
    }

    model_internal static function initRemoteClassAliasAllRelated() : void
    {
    }

    model_internal var _dminternal_model : _WorkspaceDataItemEntityMetadata;

    /**
     * properties
     */
    private var _internal_WorkspaceID : String;
    private var _internal_Title : String;
    private var _internal_Description : String;
    private var _internal_MapExtent : ArrayCollection;
    private var _internal_MapServices : ByteArray;
    private var _internal_GraphicLayers : ByteArray;
    private var _internal_CreatedTime : String;
    private var _internal_LastModified : String;

    private static var emptyArray:Array = new Array();


    /**
     * derived property cache initialization
     */
    model_internal var _cacheInitialized_isValid:Boolean = false;

    model_internal var _changeWatcherArray:Array = new Array();

    public function _Super_WorkspaceDataItem()
    {
        _model = new _WorkspaceDataItemEntityMetadata(this);

        // Bind to own data properties for cache invalidation triggering
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "WorkspaceID", model_internal::setterListenerWorkspaceID));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "Title", model_internal::setterListenerTitle));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "Description", model_internal::setterListenerDescription));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "MapExtent", model_internal::setterListenerMapExtent));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "MapServices", model_internal::setterListenerMapServices));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "GraphicLayers", model_internal::setterListenerGraphicLayers));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "CreatedTime", model_internal::setterListenerCreatedTime));
        model_internal::_changeWatcherArray.push(mx.binding.utils.ChangeWatcher.watch(this, "LastModified", model_internal::setterListenerLastModified));

    }

    /**
     * data property getters
     */

    [Bindable(event="propertyChange")]
    public function get WorkspaceID() : String
    {
        return _internal_WorkspaceID;
    }

    [Bindable(event="propertyChange")]
    public function get Title() : String
    {
        return _internal_Title;
    }

    [Bindable(event="propertyChange")]
    public function get Description() : String
    {
        return _internal_Description;
    }

    [Bindable(event="propertyChange")]
    public function get MapExtent() : ArrayCollection
    {
        return _internal_MapExtent;
    }

    [Bindable(event="propertyChange")]
    public function get MapServices() : ByteArray
    {
        return _internal_MapServices;
    }

    [Bindable(event="propertyChange")]
    public function get GraphicLayers() : ByteArray
    {
        return _internal_GraphicLayers;
    }

    [Bindable(event="propertyChange")]
    public function get CreatedTime() : String
    {
        return _internal_CreatedTime;
    }

    [Bindable(event="propertyChange")]
    public function get LastModified() : String
    {
        return _internal_LastModified;
    }

    /**
     * data property setters
     */

    public function set WorkspaceID(value:String) : void
    {
        var oldValue:String = _internal_WorkspaceID;
        if (oldValue !== value)
        {
            _internal_WorkspaceID = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "WorkspaceID", oldValue, _internal_WorkspaceID));
        }
    }

    public function set Title(value:String) : void
    {
        var oldValue:String = _internal_Title;
        if (oldValue !== value)
        {
            _internal_Title = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "Title", oldValue, _internal_Title));
        }
    }

    public function set Description(value:String) : void
    {
        var oldValue:String = _internal_Description;
        if (oldValue !== value)
        {
            _internal_Description = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "Description", oldValue, _internal_Description));
        }
    }

    public function set MapExtent(value:*) : void
    {
        var oldValue:ArrayCollection = _internal_MapExtent;
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_MapExtent = value;
            }
            else if (value is Array)
            {
                _internal_MapExtent = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of MapExtent must be a collection");
            }
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "MapExtent", oldValue, _internal_MapExtent));
        }
    }

    public function set MapServices(value:ByteArray) : void
    {
        var oldValue:ByteArray = _internal_MapServices;
        if (oldValue !== value)
        {
            _internal_MapServices = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "MapServices", oldValue, _internal_MapServices));
        }
    }

    public function set GraphicLayers(value:ByteArray) : void
    {
        var oldValue:ByteArray = _internal_GraphicLayers;
        if (oldValue !== value)
        {
            _internal_GraphicLayers = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "GraphicLayers", oldValue, _internal_GraphicLayers));
        }
    }

    public function set CreatedTime(value:String) : void
    {
        var oldValue:String = _internal_CreatedTime;
        if (oldValue !== value)
        {
            _internal_CreatedTime = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "CreatedTime", oldValue, _internal_CreatedTime));
        }
    }

    public function set LastModified(value:String) : void
    {
        var oldValue:String = _internal_LastModified;
        if (oldValue !== value)
        {
            _internal_LastModified = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "LastModified", oldValue, _internal_LastModified));
        }
    }

    /**
     * Data property setter listeners
     *
     * Each data property whose value affects other properties or the validity of the entity
     * needs to invalidate all previously calculated artifacts. These include:
     *  - any derived properties or constraints that reference the given data property.
     *  - any availability guards (variant expressions) that reference the given data property.
     *  - any style validations, message tokens or guards that reference the given data property.
     *  - the validity of the property (and the containing entity) if the given data property has a length restriction.
     *  - the validity of the property (and the containing entity) if the given data property is required.
     */

    model_internal function setterListenerWorkspaceID(value:flash.events.Event):void
    {
        _model.invalidateDependentOnWorkspaceID();
    }

    model_internal function setterListenerTitle(value:flash.events.Event):void
    {
        _model.invalidateDependentOnTitle();
    }

    model_internal function setterListenerDescription(value:flash.events.Event):void
    {
        _model.invalidateDependentOnDescription();
    }

    model_internal function setterListenerMapExtent(value:flash.events.Event):void
    {
        if (value is mx.events.PropertyChangeEvent)
        {
            if (mx.events.PropertyChangeEvent(value).newValue)
            {
                mx.events.PropertyChangeEvent(value).newValue.addEventListener(mx.events.CollectionEvent.COLLECTION_CHANGE, model_internal::setterListenerMapExtent);
            }
        }
        _model.invalidateDependentOnMapExtent();
    }

    model_internal function setterListenerMapServices(value:flash.events.Event):void
    {
        _model.invalidateDependentOnMapServices();
    }

    model_internal function setterListenerGraphicLayers(value:flash.events.Event):void
    {
        _model.invalidateDependentOnGraphicLayers();
    }

    model_internal function setterListenerCreatedTime(value:flash.events.Event):void
    {
        _model.invalidateDependentOnCreatedTime();
    }

    model_internal function setterListenerLastModified(value:flash.events.Event):void
    {
        _model.invalidateDependentOnLastModified();
    }


    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();
        var validationFailureMessages:Array = new Array();

        var propertyValidity:Boolean = true;
        if (!_model.WorkspaceIDIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_WorkspaceIDValidationFailureMessages);
        }
        if (!_model.TitleIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_TitleValidationFailureMessages);
        }
        if (!_model.DescriptionIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_DescriptionValidationFailureMessages);
        }
        if (!_model.MapExtentIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_MapExtentValidationFailureMessages);
        }
        if (!_model.MapServicesIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_MapServicesValidationFailureMessages);
        }
        if (!_model.GraphicLayersIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_GraphicLayersValidationFailureMessages);
        }
        if (!_model.CreatedTimeIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_CreatedTimeValidationFailureMessages);
        }
        if (!_model.LastModifiedIsValid)
        {
            propertyValidity = false;
            com.adobe.fiber.util.FiberUtils.arrayAdd(validationFailureMessages, _model.model_internal::_LastModifiedValidationFailureMessages);
        }

        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && propertyValidity;
    }

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
        var oldValue:Boolean = model_internal::_isValid;
        if (oldValue !== value)
        {
            model_internal::_isValid = value;
            _model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }
    }

    /**
     * derived property getters
     */

    [Transient]
    [Bindable(event="propertyChange")]
    public function get _model() : _WorkspaceDataItemEntityMetadata
    {
        return model_internal::_dminternal_model;
    }

    public function set _model(value : _WorkspaceDataItemEntityMetadata) : void
    {
        var oldValue : _WorkspaceDataItemEntityMetadata = model_internal::_dminternal_model;
        if (oldValue !== value)
        {
            model_internal::_dminternal_model = value;
            this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }
    }

    /**
     * methods
     */


    /**
     *  services
     */
    private var _managingService:com.adobe.fiber.services.IFiberManagingService;

    public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
    {
        _managingService = managingService;
    }

    model_internal function set invalidConstraints_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_invalidConstraints;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;
            _model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);
        }
    }

    model_internal function set validationFailureMessages_der(value:Array) : void
    {
        var oldValue:Array = model_internal::_validationFailureMessages;
        // avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;
            _model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);
        }
    }

    model_internal var _doValidationCacheOfWorkspaceID : Array = null;
    model_internal var _doValidationLastValOfWorkspaceID : String;

    model_internal function _doValidationForWorkspaceID(valueIn:Object):Array
    {
        var value : String = valueIn as String;

        if (model_internal::_doValidationCacheOfWorkspaceID != null && model_internal::_doValidationLastValOfWorkspaceID == value)
           return model_internal::_doValidationCacheOfWorkspaceID ;

        _model.model_internal::_WorkspaceIDIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isWorkspaceIDAvailable && _internal_WorkspaceID == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "WorkspaceID is required"));
        }

        model_internal::_doValidationCacheOfWorkspaceID = validationFailures;
        model_internal::_doValidationLastValOfWorkspaceID = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfTitle : Array = null;
    model_internal var _doValidationLastValOfTitle : String;

    model_internal function _doValidationForTitle(valueIn:Object):Array
    {
        var value : String = valueIn as String;

        if (model_internal::_doValidationCacheOfTitle != null && model_internal::_doValidationLastValOfTitle == value)
           return model_internal::_doValidationCacheOfTitle ;

        _model.model_internal::_TitleIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isTitleAvailable && _internal_Title == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "Title is required"));
        }

        model_internal::_doValidationCacheOfTitle = validationFailures;
        model_internal::_doValidationLastValOfTitle = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfDescription : Array = null;
    model_internal var _doValidationLastValOfDescription : String;

    model_internal function _doValidationForDescription(valueIn:Object):Array
    {
        var value : String = valueIn as String;

        if (model_internal::_doValidationCacheOfDescription != null && model_internal::_doValidationLastValOfDescription == value)
           return model_internal::_doValidationCacheOfDescription ;

        _model.model_internal::_DescriptionIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isDescriptionAvailable && _internal_Description == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "Description is required"));
        }

        model_internal::_doValidationCacheOfDescription = validationFailures;
        model_internal::_doValidationLastValOfDescription = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfMapExtent : Array = null;
    model_internal var _doValidationLastValOfMapExtent : ArrayCollection;

    model_internal function _doValidationForMapExtent(valueIn:Object):Array
    {
        var value : ArrayCollection = valueIn as ArrayCollection;

        if (model_internal::_doValidationCacheOfMapExtent != null && model_internal::_doValidationLastValOfMapExtent == value)
           return model_internal::_doValidationCacheOfMapExtent ;

        _model.model_internal::_MapExtentIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isMapExtentAvailable && _internal_MapExtent == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "MapExtent is required"));
        }

        model_internal::_doValidationCacheOfMapExtent = validationFailures;
        model_internal::_doValidationLastValOfMapExtent = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfMapServices : Array = null;
    model_internal var _doValidationLastValOfMapServices : ByteArray;

    model_internal function _doValidationForMapServices(valueIn:Object):Array
    {
        var value : ByteArray = valueIn as ByteArray;

        if (model_internal::_doValidationCacheOfMapServices != null && model_internal::_doValidationLastValOfMapServices == value)
           return model_internal::_doValidationCacheOfMapServices ;

        _model.model_internal::_MapServicesIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isMapServicesAvailable && _internal_MapServices == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "MapServices is required"));
        }

        model_internal::_doValidationCacheOfMapServices = validationFailures;
        model_internal::_doValidationLastValOfMapServices = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfGraphicLayers : Array = null;
    model_internal var _doValidationLastValOfGraphicLayers : ByteArray;

    model_internal function _doValidationForGraphicLayers(valueIn:Object):Array
    {
        var value : ByteArray = valueIn as ByteArray;

        if (model_internal::_doValidationCacheOfGraphicLayers != null && model_internal::_doValidationLastValOfGraphicLayers == value)
           return model_internal::_doValidationCacheOfGraphicLayers ;

        _model.model_internal::_GraphicLayersIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isGraphicLayersAvailable && _internal_GraphicLayers == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "GraphicLayers is required"));
        }

        model_internal::_doValidationCacheOfGraphicLayers = validationFailures;
        model_internal::_doValidationLastValOfGraphicLayers = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfCreatedTime : Array = null;
    model_internal var _doValidationLastValOfCreatedTime : String;

    model_internal function _doValidationForCreatedTime(valueIn:Object):Array
    {
        var value : String = valueIn as String;

        if (model_internal::_doValidationCacheOfCreatedTime != null && model_internal::_doValidationLastValOfCreatedTime == value)
           return model_internal::_doValidationCacheOfCreatedTime ;

        _model.model_internal::_CreatedTimeIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isCreatedTimeAvailable && _internal_CreatedTime == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "CreatedTime is required"));
        }

        model_internal::_doValidationCacheOfCreatedTime = validationFailures;
        model_internal::_doValidationLastValOfCreatedTime = value;

        return validationFailures;
    }
    
    model_internal var _doValidationCacheOfLastModified : Array = null;
    model_internal var _doValidationLastValOfLastModified : String;

    model_internal function _doValidationForLastModified(valueIn:Object):Array
    {
        var value : String = valueIn as String;

        if (model_internal::_doValidationCacheOfLastModified != null && model_internal::_doValidationLastValOfLastModified == value)
           return model_internal::_doValidationCacheOfLastModified ;

        _model.model_internal::_LastModifiedIsValidCacheInitialized = true;
        var validationFailures:Array = new Array();
        var errorMessage:String;
        var failure:Boolean;

        var valRes:ValidationResult;
        if (_model.isLastModifiedAvailable && _internal_LastModified == null)
        {
            validationFailures.push(new ValidationResult(true, "", "", "LastModified is required"));
        }

        model_internal::_doValidationCacheOfLastModified = validationFailures;
        model_internal::_doValidationLastValOfLastModified = value;

        return validationFailures;
    }
    

}

}
