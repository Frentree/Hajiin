/**
 * WsCreateReqApprDocServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.org.iopts.approval.util;

public class DevWsCreateReqApprDocServiceLocator extends org.apache.axis.client.Service implements com.org.iopts.approval.util.DevWsCreateReqApprDocService {

    public DevWsCreateReqApprDocServiceLocator() {
    }


    public DevWsCreateReqApprDocServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public DevWsCreateReqApprDocServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for wsCreateReqApprDocDomino
    private java.lang.String wsCreateReqApprDocDomino_address = "http://devappr.netswork.co.kr:80/comn/webservices.nsf/wsCreateReqApprDoc?OpenWebService";

    public java.lang.String getwsCreateReqApprDocDominoAddress() {
        return wsCreateReqApprDocDomino_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String wsCreateReqApprDocDominoWSDDServiceName = "wsCreateReqApprDocDomino";

    public java.lang.String getwsCreateReqApprDocDominoWSDDServiceName() {
        return wsCreateReqApprDocDominoWSDDServiceName;
    }

    public void setwsCreateReqApprDocDominoWSDDServiceName(java.lang.String name) {
        wsCreateReqApprDocDominoWSDDServiceName = name;
    }

    public com.org.iopts.approval.util.DevWsCreateReqApprDoc getwsCreateReqApprDocDomino() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(wsCreateReqApprDocDomino_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getwsCreateReqApprDocDomino(endpoint);
    }

    public com.org.iopts.approval.util.DevWsCreateReqApprDoc getwsCreateReqApprDocDomino(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.org.iopts.approval.util.DevWsCreateReqApprDocDominoSoapBindingStub _stub = new com.org.iopts.approval.util.DevWsCreateReqApprDocDominoSoapBindingStub(portAddress, this);
            _stub.setPortName(getwsCreateReqApprDocDominoWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setwsCreateReqApprDocDominoEndpointAddress(java.lang.String address) {
        wsCreateReqApprDocDomino_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.org.iopts.approval.util.DevWsCreateReqApprDoc.class.isAssignableFrom(serviceEndpointInterface)) {
                com.org.iopts.approval.util.DevWsCreateReqApprDocDominoSoapBindingStub _stub = new com.org.iopts.approval.util.DevWsCreateReqApprDocDominoSoapBindingStub(new java.net.URL(wsCreateReqApprDocDomino_address), this);
                _stub.setPortName(getwsCreateReqApprDocDominoWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("wsCreateReqApprDocDomino".equals(inputPortName)) {
            return getwsCreateReqApprDocDomino();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("urn:DefaultNamespace", "wsCreateReqApprDocService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("urn:DefaultNamespace", "wsCreateReqApprDocDomino"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("wsCreateReqApprDocDomino".equals(portName)) {
            setwsCreateReqApprDocDominoEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
