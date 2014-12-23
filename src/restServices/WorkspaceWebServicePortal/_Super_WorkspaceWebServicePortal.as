/**
 * This is a generated class and is not intended for modification.  To customize behavior
 * of this service wrapper you may modify the generated sub-class of this class - WorkspaceWebServicePortal.as.
 */
package restServices.WorkspaceWebServicePortal
{
	import com.adobe.fiber.core.model_internal;
	import com.adobe.fiber.services.wrapper.WebServiceWrapper;
	import com.adobe.serializers.utility.TypeUtility;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncToken;
	import mx.rpc.soap.mxml.Operation;
	import mx.rpc.soap.mxml.WebService;
	import restServices.WorkspaceWebServicePortal.valueobjects.WorkspaceDataItem;
	
	[ExcludeClass]
	internal class _Super_WorkspaceWebServicePortal extends com.adobe.fiber.services.wrapper.WebServiceWrapper
	{
		// Constructor
		public function _Super_WorkspaceWebServicePortal()
		{
			// initialize service control
			_serviceControl = new mx.rpc.soap.mxml.WebService();
			var operations:Object = new Object();
			var operation:mx.rpc.soap.mxml.Operation;
			
			operation = new mx.rpc.soap.mxml.Operation(null, "DeleteWorkspace");
			operations["DeleteWorkspace"] = operation;
			
			operation = new mx.rpc.soap.mxml.Operation(null, "GetWorkspaces");
			operation.resultElementType = WorkspaceDataItem;
			operations["GetWorkspaces"] = operation;

			operation = new mx.rpc.soap.mxml.Operation(null, "GetAllWorkspaces");
			operation.resultElementType = WorkspaceDataItem;
			operations["GetAllWorkspaces"] = operation;
			
			operation = new mx.rpc.soap.mxml.Operation(null, "UpdateWorkspace");
			operations["UpdateWorkspace"] = operation;
			
			operation = new mx.rpc.soap.mxml.Operation(null, "GetWorkspaceByID");
			operation.resultType = WorkspaceDataItem;
			operations["GetWorkspaceByID"] = operation;
			
			operation = new mx.rpc.soap.mxml.Operation(null, "InsertWorkspace");
			operations["InsertWorkspace"] = operation;
			
			_serviceControl.operations = operations;
			try
			{
				_serviceControl.convertResultHandler = com.adobe.serializers.utility.TypeUtility.convertResultHandler;
			}
			catch (e: Error)
			{ /* Flex 3.4 and eralier does not support the convertResultHandler functionality. */ }
			
			_serviceControl.service = "ViewerWebServicePortal";
			_serviceControl.port = "ViewerWebServicePortalSoap";
			model_internal::loadWSDLIfNecessary();
			
			model_internal::initialize();
		}
		
		/**
		 * This method is a generated wrapper used to call the 'DeleteWorkspace' operation. It returns an mx.rpc.AsyncToken whose 
		 * result property will be populated with the result of the operation when the server response is received. 
		 * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
		 * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
		 *
		 * @see mx.rpc.AsyncToken
		 * @see mx.rpc.CallResponder 
		 *
		 * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
		 */
		public function DeleteWorkspace(ws:WorkspaceDataItem) : mx.rpc.AsyncToken
		{
			model_internal::loadWSDLIfNecessary();
			var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("DeleteWorkspace");
			var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(ws) ;
			
			return _internal_token;
		}
		
		/**
		 * This method is a generated wrapper used to call the 'GetWorkspaces' operation. It returns an mx.rpc.AsyncToken whose 
		 * result property will be populated with the result of the operation when the server response is received. 
		 * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
		 * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
		 *
		 * @see mx.rpc.AsyncToken
		 * @see mx.rpc.CallResponder 
		 *
		 * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
		 */
		public function GetWorkspaces() : mx.rpc.AsyncToken
		{
			model_internal::loadWSDLIfNecessary();
			var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("GetWorkspaces");
			var _internal_token:mx.rpc.AsyncToken = _internal_operation.send() ;
			
			return _internal_token;
		}
		
		/**
		 * This method is a generated wrapper used to call the 'GetWorkspaces' operation. It returns an mx.rpc.AsyncToken whose 
		 * result property will be populated with the result of the operation when the server response is received. 
		 * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
		 * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
		 *
		 * @see mx.rpc.AsyncToken
		 * @see mx.rpc.CallResponder 
		 *
		 * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
		 */
		public function GetAllWorkspaces() : mx.rpc.AsyncToken
		{
			model_internal::loadWSDLIfNecessary();
			var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("GetAllWorkspaces");
			var _internal_token:mx.rpc.AsyncToken = _internal_operation.send() ;
			
			return _internal_token;
		}
		
		/**
		 * This method is a generated wrapper used to call the 'UpdateWorkspace' operation. It returns an mx.rpc.AsyncToken whose 
		 * result property will be populated with the result of the operation when the server response is received. 
		 * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
		 * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
		 *
		 * @see mx.rpc.AsyncToken
		 * @see mx.rpc.CallResponder 
		 *
		 * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
		 */
		public function UpdateWorkspace(ws:WorkspaceDataItem) : mx.rpc.AsyncToken
		{
			model_internal::loadWSDLIfNecessary();
			var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("UpdateWorkspace");
			var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(ws) ;
			
			return _internal_token;
		}
		
		/**
		 * This method is a generated wrapper used to call the 'GetWorkspaceByID' operation. It returns an mx.rpc.AsyncToken whose 
		 * result property will be populated with the result of the operation when the server response is received. 
		 * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
		 * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
		 *
		 * @see mx.rpc.AsyncToken
		 * @see mx.rpc.CallResponder 
		 *
		 * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
		 */
		public function GetWorkspaceByID(ID:String) : mx.rpc.AsyncToken
		{
			model_internal::loadWSDLIfNecessary();
			var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("GetWorkspaceByID");
			var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(ID) ;
			
			return _internal_token;
		}
		
		/**
		 * This method is a generated wrapper used to call the 'InsertWorkspace' operation. It returns an mx.rpc.AsyncToken whose 
		 * result property will be populated with the result of the operation when the server response is received. 
		 * To use this result from MXML code, define a CallResponder component and assign its token property to this method's return value. 
		 * You can then bind to CallResponder.lastResult or listen for the CallResponder.result or fault events.
		 *
		 * @see mx.rpc.AsyncToken
		 * @see mx.rpc.CallResponder 
		 *
		 * @return an mx.rpc.AsyncToken whose result property will be populated with the result of the operation when the server response is received.
		 */
		public function InsertWorkspace(ws:WorkspaceDataItem) : mx.rpc.AsyncToken
		{
			model_internal::loadWSDLIfNecessary();
			var _internal_operation:mx.rpc.AbstractOperation = _serviceControl.getOperation("InsertWorkspace");
			var _internal_token:mx.rpc.AsyncToken = _internal_operation.send(ws) ;
			
			return _internal_token;
		}
	}
}
