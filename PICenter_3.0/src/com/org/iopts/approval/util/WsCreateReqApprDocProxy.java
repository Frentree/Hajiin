package com.org.iopts.approval.util;

public class WsCreateReqApprDocProxy implements com.org.iopts.approval.util.WsCreateReqApprDoc {
  private String _endpoint = null;
  private com.org.iopts.approval.util.WsCreateReqApprDoc wsCreateReqApprDoc = null;
  
  public WsCreateReqApprDocProxy() {
    _initWsCreateReqApprDocProxy();
  }
  
  public WsCreateReqApprDocProxy(String endpoint) {
    _endpoint = endpoint;
    _initWsCreateReqApprDocProxy();
  }
  
  private void _initWsCreateReqApprDocProxy() {
    try {
      wsCreateReqApprDoc = (new com.org.iopts.approval.util.WsCreateReqApprDocServiceLocator()).getwsCreateReqApprDocDomino();
      if (wsCreateReqApprDoc != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)wsCreateReqApprDoc)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)wsCreateReqApprDoc)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (wsCreateReqApprDoc != null)
      ((javax.xml.rpc.Stub)wsCreateReqApprDoc)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.org.iopts.approval.util.WsCreateReqApprDoc getWsCreateReqApprDoc() {
    if (wsCreateReqApprDoc == null)
      _initWsCreateReqApprDocProxy();
    return wsCreateReqApprDoc;
  }
  
  public java.lang.String WS_APPR_CREATE_DOC(java.lang.String SZAPPRINFO, java.lang.String SZBODY, java.lang.String SZFILEINFO) throws java.rmi.RemoteException{
    if (wsCreateReqApprDoc == null)
      _initWsCreateReqApprDocProxy();
    return wsCreateReqApprDoc.WS_APPR_CREATE_DOC(SZAPPRINFO, SZBODY, SZFILEINFO);
  }
  
  
}