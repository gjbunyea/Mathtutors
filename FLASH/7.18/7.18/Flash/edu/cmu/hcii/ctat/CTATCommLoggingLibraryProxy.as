class edu.cmu.hcii.ctat.CTATCommLoggingLibraryProxy extends edu.cmu.hcii.ctat.CTATCommLoggingLibraryCore
{
   var retrieving = false;
   var url = "http://tutors.pslc.cs.cmu.edu/tutorshop/log/server";
   var urllocked = false;
   var id = -1;
   var sendmode = "SEND";
   var status = "NOTOK";
   var httpStatus = 0;
   var httpStatusType = "undefined";
   var failed = false;
   var sessionObj = null;
   var disabled = false;
   var intervalId = null;
   var duration = 5000;
   function CTATCommLoggingLibraryProxy(a_url, an_id, a_session)
   {
      super();
      this.setClassType("CTATCommLoggingLibraryProxy");
      this.debug("CTATCommLoggingLibraryProxy ()");
      this.url = a_url;
      this.id = an_id;
      this.sessionObj = new edu.cmu.hcii.ctat.CTATSessionMessageTransferData();
      mx.events.EventDispatcher.initialize(this);
      this.debug("Connecting HTTP events ...");
   }
   function dispatchEvent()
   {
   }
   function addEventListener()
   {
   }
   function removeEventListener()
   {
   }
   function createReceiveObject()
   {
      this.debug("createReceiveObject ()");
   }
   function startConnectionTimer()
   {
      this.debug("startConnectionTimer ()");
      if(this.intervalId != null)
      {
         trace("clearInterval");
         clearInterval(this.intervalId);
      }
      this.intervalId = setInterval(this,"checkTimeout",this.duration);
   }
   function checkTimeout()
   {
      this.debug("checkTimeout ()");
      if(this.retrieving == true)
      {
         clearInterval(this.intervalId);
         _global.theShell.displayMessage("Unable to send to logservice, engaging secondary service","INFO");
         this.failover();
      }
   }
   function resetConnectionTimer()
   {
      if(this.intervalId != null)
      {
         trace("clearInterval");
         clearInterval(this.intervalId);
      }
   }
   function lockURL(a_val)
   {
      this.urllocked = a_val;
   }
   function getURLLocked()
   {
      return this.urllocked;
   }
   function setSessionObject(an_obj)
   {
      this.sessionObj = an_obj;
   }
   function getSessionObject()
   {
      return this.sessionObj;
   }
   function getQueueSize()
   {
      return this.outgoingQueue.length;
   }
   function setMode(a_val)
   {
      this.sendmode = a_val;
   }
   function getMode()
   {
      return this.sendmode;
   }
   function setStatus(a_val)
   {
      this.status = a_val;
   }
   function getStatus()
   {
      return this.status;
   }
   function setFailed(a_val)
   {
      this.failed = a_val;
   }
   function getFailed()
   {
      return this.failed;
   }
   function logSessionMessage(plog_service_url, pauth_token, psession_id, puser_guid)
   {
      this.debug("logSessionMessage ()");
      this.simpleSessionLog(plog_service_url,pauth_token,psession_id,puser_guid);
   }
   function simpleSessionLog(plog_service_url, pauth_token, psession_id, puser_guid)
   {
      this.debug("simpleSessionLog ()");
      if(this.disabled == true)
      {
         this.debug("This proxy is disabled, probably due to a prior failure");
         return undefined;
      }
      if(this.sessionObj == undefined || this.sessionObj == null)
      {
         this.debug("Internal error: no valid session object available");
         return undefined;
      }
      this.sessionObj.setlog_service_url(plog_service_url);
      this.sessionObj.setauth_token(pauth_token);
      var _loc2_ = this.sessionObj.setsession_id(psession_id);
      var _loc3_ = this.sessionObj.setuser_guid(puser_guid);
      this.traceSessionData(this.sessionObj,"SessionLog");
      this.userAndSessionValidityWarning("session_id",this.sessionObj.getsession_id(),_loc2_);
      this.userAndSessionValidityWarning("user_guid",this.sessionObj.getuser_guid(),_loc3_);
      this.SessionLog();
   }
   function SessionLog()
   {
      this.debug("SessionLog ()");
      this.SessionLogNoQueue();
      return undefined;
   }
   function SessionLogNoQueue()
   {
      this.debug("SessionLogNoQueue (" + this.outgoingQueue.length + ")");
      var _loc4_ = this.url;
      if(this.getURLLocked() == false)
      {
         this.debug("The URL is not hard coded in the proxy, using flashvar provided ...");
         if(this.sessionObj.getlog_service_url() != null)
         {
            _loc4_ = this.sessionObj.getlog_service_url();
         }
      }
      else
      {
         this.debug("The URL is locked (hard coded) in the proxy, using: " + this.url);
      }
      this.timeZone = "UTC";
      this.timeStamp = this.FormatTimeStamp(new Date());
      var _loc3_ = this.createOutoingMessage();
      _loc3_.xmlobj.appendChild(_loc3_.xmlobj.createElement("log_session_start"));
      _loc3_.xmlobj.firstChild.attributes.timezone = this.timeZone;
      _loc3_.xmlobj.firstChild.attributes.date_time = this.timeStamp;
      _loc3_.xmlobj.firstChild.attributes.auth_token = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getauth_token());
      _loc3_.xmlobj.firstChild.attributes.session_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getsession_id());
      _loc3_.xmlobj.firstChild.attributes.user_guid = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getuser_guid());
      _loc3_.xmlobj.firstChild.attributes.class_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getclass_id());
      _loc3_.xmlobj.firstChild.attributes.treatment_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.gettreatment_id());
      _loc3_.xmlobj.firstChild.attributes.assignment_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getassignment_id());
      _loc3_.xmlobj.firstChild.attributes.info_type = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getinfo_type());
      var _loc5_ = _loc3_.xmlobj.toString();
      this.outgoingQueue[len].url = _loc4_;
      this.outgoingQueue[len].data = _loc5_;
      if(_global.theShell.sgLogMode == "HTTP" || _global.theShell.sgLogMode == "HTTP&STREAM")
      {
         if(_loc4_ != null)
         {
            if(this.outgoingQueue.length < 2)
            {
               this.ExternalLogging(_loc5_);
               this.debug("Calling sendAndLoad on [" + _loc4_ + "] for session object: " + _loc5_);
               _loc3_.xmlobj.sendAndLoad(_loc4_,_loc3_.receiveXMLContent);
               _loc3_.sent = true;
            }
         }
         else
         {
            this.debug("No log service url availavle to log session");
            this.ExternalLogging("No log service url availavle to log session");
         }
      }
      if(_global.theShell.sgLogMode == "STREAM" || _global.theShell.sgLogMode == "HTTP&STREAM")
      {
         if(this.outgoingQueue.length == 1)
         {
            this.debug("Calling Flash xml socket send (" + _loc4_ + ") ...");
            _global.theShell.myXMLSocket.send(_loc3_.receiveXMLContent);
         }
      }
   }
   function SendLog(infoString, theActionMsgDescription)
   {
      this.debug("SendLog ()");
      this.SendLogNoQueue(infoString,theActionMsgDescription);
      return undefined;
   }
   function SendLogNoQueue(infoString, theActionMsgDescription)
   {
      this.debug("SendLogNoQueue (" + this.outgoingQueue.length + ")");
      var _loc3_ = this.url;
      if(this.getURLLocked() == false)
      {
         this.debug("The URL is not hard coded in the proxy, using flashvar provided ...");
         if(this.sessionObj.getlog_service_url() != null)
         {
            _loc3_ = this.sessionObj.getlog_service_url();
         }
      }
      else
      {
         this.debug("The URL is locked (hard coded) in the proxy, using: " + this.url);
      }
      this.timeZone = "UTC";
      this.timeStamp = this.FormatTimeStamp(new Date());
      var _loc2_ = this.createOutoingMessage();
      _loc2_.xmlobj.appendChild(_loc2_.xmlobj.createElement("log_action"));
      _loc2_.xmlobj.firstChild.attributes.info_type = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getinfo_type());
      _loc2_.xmlobj.firstChild.attributes.external_object_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getexternal_object_id());
      _loc2_.xmlobj.firstChild.attributes.source_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getsource_id());
      _loc2_.xmlobj.firstChild.attributes.container_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getcontainer_id());
      _loc2_.xmlobj.firstChild.attributes.timezone = this.timeZone;
      _loc2_.xmlobj.firstChild.attributes.auth_token = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getauth_token());
      _loc2_.xmlobj.firstChild.attributes.session_id = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getsession_id());
      _loc2_.xmlobj.firstChild.attributes.user_guid = edu.cmu.hcii.ctat.CTATUtil.unescapeXML(this.sessionObj.getuser_guid());
      _loc2_.xmlobj.firstChild.attributes.date_time = this.timeStamp;
      _loc2_.xmlobj.firstChild.attributes.action_id = theActionMsgDescription;
      _loc2_.xmlobj.firstChild.appendChild(_loc2_.xmlobj.createTextNode(escape(infoString)));
      var _loc4_ = _loc2_.xmlobj.toString();
      _loc2_.url = _loc3_;
      _loc2_.data = _loc4_;
      if(this.sendQueued == true)
      {
         if(this.outgoingQueue.length < 2)
         {
            this.ExternalLogging(_loc4_);
            this.debug("(Queued version) Calling sendAndLoad on [" + _loc3_ + "] for regular log object: " + _loc4_);
            _loc2_.sent = true;
            _loc2_.xmlobj.sendAndLoad(_loc3_,_loc2_.receiveXMLContent);
         }
      }
      else
      {
         this.ExternalLogging(_loc4_);
         this.debug("(Non Queued version) Calling sendAndLoad on [" + _loc3_ + "] for regular log object: " + _loc4_);
         _loc2_.sent = true;
         _loc2_.xmlobj.sendAndLoad(_loc3_,_loc2_.receiveXMLContent);
      }
   }
   function receiveData(src)
   {
      this.debug("receiveData (" + this.id + ") from " + this.sessionObj.getlog_service_url() + " with: " + src);
      this.debug("We have a response message ...");
      this.setStatus("OK");
      var _loc2_ = this.processQueue();
      this.showStatus(_loc2_);
      if(this.sendQueued == true)
      {
         this.debug("We\'re in queued mode, sending next message in line ...");
         if(_loc2_ != null && _loc2_ != undefined)
         {
            this.debug("We\'ve got a message in the queue, sending (" + _loc2_.url + ")...");
            this.debug("Sending data: " + _loc2_.data);
            this.retrieving = true;
            _loc2_.sent = true;
            _loc2_.xmlobj.sendAndLoad(_loc2_.url,_loc2_.receiveXMLContent);
            return undefined;
         }
      }
      this.debug("No more message in the queue, resetting ...");
      this.retrieving = false;
   }
   function receiveLoad(success)
   {
      this.debug("receiveLoad (" + this.id + "): " + success.toString());
   }
   function receiveHTTPStatus(httpStatus)
   {
      this.debug("receiveHTTPStatus (" + this.id + "," + httpStatus + ")");
   }
   function failover()
   {
      this.debug("failover ()");
      this.failed = true;
      this.disabled = true;
      this.dispatchEvent({type:"failOver",target:this});
   }
   function userAndSessionValidityWarning(theField, theValue, fieldSetBy)
   {
      this.debug("userAndSessionValidityWarning ()");
      if(edu.cmu.hcii.ctat.CTATUtil.checkStringValid(theValue) == false || fieldSetBy == "set to default")
      {
         var _loc3_ = undefined;
         _loc3_ = _loc3_ + ("The \'" + theField + "\' appears to have not been set. It was reported set by \'" + fieldSetBy + "\'. It has a value of \'" + theValue + "\'. ");
         _loc3_ = _loc3_ + "This will likely result in ambiguous logs that possibly don\'t differentiate students or the periods in which they work. ";
         _loc3_ = _loc3_ + ("The " + theField + " is usually set by calling a logging method to set it or it is passed to the Flash tutor in the Flashvars vairable of the HTML. ");
         _loc3_ = _loc3_ + "Documentation about logging can be found at: (see <font color=\'#0000FF\'><u><a href=\'http://snipurl.com/FlashLog\' target=\'_blank\'>Logging Instructions</a></u></font>) (http://snipurl.com/FlashLog). ";
         var _loc4_ = false;
         if(_global.theShell != undefined)
         {
            _global.theShell.Feedback(_loc3_,_loc4_);
         }
         if(_global.theLoggingAgent != undefined)
         {
            _global.theLoggingAgent.Feedback(_loc3_,_loc4_);
         }
      }
   }
   function checkUserAndSessionValidity(theField, theValue, fieldSetBy)
   {
      this.debug("checkUserAndSessionValidity ()");
      var _loc4_ = undefined;
      if(checkValid(theValue) == false || fieldSetBy == "set to default")
      {
         var _loc6_ = undefined;
         _loc6_ = _loc6_ + ("The \'" + theField + "\' appears to have not been set. It was reported set by \'" + fieldSetBy + "\'. It has a value of \'" + theValue + "\'. ");
         _loc6_ = _loc6_ + "This will likely result in ambiguous logs that possibly don\'t differentiate students or the periods in which they work. ";
         _loc6_ = _loc6_ + ("The " + theField + " is usually set by calling a logging method to set it or it is passed to the Flash tutor in the Flashvars vairable of the HTML. ");
         _loc6_ = _loc6_ + "Documentation about logging can be found at: (see <font color=\'#0000FF\'><u><a href=\'http://snipurl.com/FlashLog\' target=\'_blank\'>Logging Instructions</a></u></font>) (http://snipurl.com/FlashLog). ";
         this.debug("EXCEPTION : " + _loc6_);
         _loc4_ = {valid:false,description:_loc6_};
         return _loc4_;
      }
      _loc6_ = _loc6_ + ("The " + theField + " is valid. It has a value of \'" + theValue + "\'. It was reported set by \'" + fieldSetBy + "\'. ");
      return {valid:true,description:_loc6_};
   }
   function traceSessionData(sessionObj, cSource)
   {
      this.debug("traceSessionData : " + cSource + ": " + "getlog_service_url() = " + sessionObj.getlog_service_url() + " " + "getauth_token() = " + sessionObj.getauth_token() + " " + "getsession_id() = " + sessionObj.getsession_id() + " " + "getuser_guid() = " + sessionObj.getuser_guid() + " " + "getclass_id() = " + sessionObj.getclass_id() + " " + "gettreatment_id() = " + sessionObj.gettreatment_id() + " " + "getassignment_id() = " + sessionObj.getassignment_id() + " " + "getinfo_type() = " + sessionObj.getinfo_type() + " ");
   }
}
