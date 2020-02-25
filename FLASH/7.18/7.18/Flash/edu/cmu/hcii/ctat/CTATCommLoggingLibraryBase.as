class edu.cmu.hcii.ctat.CTATCommLoggingLibraryBase extends edu.cmu.hcii.ctat.CTATCommLoggingLibraryCore
{
   var className = "CTATCommLoggingLibraryBase";
   var theDataObj = null;
   var theSessionObj = null;
   var sessionEstablished = false;
   var proxies = null;
   var initialized = false;
   var url = null;
   var nolog = false;
   function CTATCommLoggingLibraryBase()
   {
      super();
      this.setClassType("CTATCommLoggingLibraryBase");
      this.debug("CTATCommLoggingLibraryBase ()");
      this.proxies = new Array();
      this.setDefaultSessionObj();
      System.security.allowInsecureDomain("*");
      System.security.allowInsecureDomain("pslc-qa.andrew.cmu.edu");
      System.security.allowInsecureDomain("localhost");
      System.security.allowInsecureDomain("127.0.0.1");
      System.security.allowInsecureDomain("learnlab.web.cmu.edu");
      System.security.allowInsecureDomain("digger.pslc.cs.cmu.edu");
      System.security.allowDomain("*");
      System.security.allowDomain("pslc-qa.andrew.cmu.edu");
      System.security.allowDomain("localhost");
      System.security.allowDomain("127.0.0.1");
      System.security.allowDomain("learnlab.web.cmu.edu");
      System.security.allowDomain("digger.pslc.cs.cmu.edu");
   }
   function init(urls)
   {
      this.debug("init ()");
      if(urls == undefined || urls == null)
      {
         if(this.url != undefined && this.url != null)
         {
            var _loc2_ = new edu.cmu.hcii.ctat.CTATCommLoggingLibraryProxy(this.url,0,this.theSessionObj);
            _loc2_.setMode("SEND");
            _loc2_.lockURL(false);
            _loc2_.addEventListener("proxyReady",mx.utils.Delegate.create(this,this.processProxyReady));
            _loc2_.addEventListener("failOver",mx.utils.Delegate.create(this,this.processFailOver));
            this.proxies.push(_loc2_);
         }
         else
         {
            this.debug("Warning! No log url set defined, reverting to backup startup ...");
            _loc2_ = new edu.cmu.hcii.ctat.CTATCommLoggingLibraryProxy("http://digger.pslc.cs.cmu.edu/log/server/sandboxlogger-stream1.php",0,this.theSessionObj);
            _loc2_.setMode("SEND");
            _loc2_.lockURL(false);
            _loc2_.addEventListener("proxyReady",mx.utils.Delegate.create(this,this.processProxyReady));
            _loc2_.addEventListener("failOver",mx.utils.Delegate.create(this,this.processFailOver));
            this.proxies.push(_loc2_);
            var _loc6_ = new edu.cmu.hcii.ctat.CTATCommLoggingLibraryProxy("http://tutors.pslc.cs.cmu.edu/tutorshop/log/server",1);
            _loc6_.setMode("CONNECT");
            _loc6_.lockURL(true);
            _loc6_.addEventListener("proxyReady",mx.utils.Delegate.create(this,this.processProxyReady));
            _loc6_.addEventListener("failOver",mx.utils.Delegate.create(this,this.processFailOver));
            this.proxies.push(_loc6_);
            var _loc5_ = new edu.cmu.hcii.ctat.CTATCommLoggingLibraryProxy("http://pact-cvs.pact.cs.cmu.edu/tutorshop/log/server",2);
            _loc5_.setMode("CONNECT");
            _loc5_.lockURL(true);
            _loc5_.addEventListener("proxyReady",mx.utils.Delegate.create(this,this.processProxyReady));
            _loc5_.addEventListener("failOver",mx.utils.Delegate.create(this,this.processFailOver));
            this.proxies.push(_loc5_);
         }
      }
      else
      {
         var _loc3_ = 0;
         while(_loc3_ < urls.length)
         {
            _loc2_ = new edu.cmu.hcii.ctat.CTATCommLoggingLibraryProxy(urls[_loc3_],0,this.theSessionObj);
            if(_loc3_ == 0)
            {
               _loc2_.setMode("SEND");
            }
            else
            {
               _loc2_.setMode("CONNECT");
            }
            _loc2_.lockURL(false);
            _loc2_.addEventListener("proxyReady",mx.utils.Delegate.create(this,this.processProxyReady));
            _loc2_.addEventListener("failOver",mx.utils.Delegate.create(this,this.processFailOver));
            this.proxies.push(_loc2_);
            _loc3_ = _loc3_ + 1;
         }
      }
      this.debug("init () done");
   }
   function setDefaultSessionObj()
   {
      this.setTheSessionObj(new edu.cmu.hcii.ctat.CTATSessionMessageTransferData());
      return this.getTheSessionObj();
   }
   function setTheSessionObj(theValue)
   {
      this.theSessionObj = theValue;
   }
   function getTheSessionObj()
   {
      return this.theSessionObj;
   }
   function setsessionEstablished(newValue)
   {
      this.sessionEstablished = newValue;
   }
   function getsessionEstablished()
   {
      return this.sessionEstablished;
   }
   function setNoLog(a_val)
   {
      this.nolog = a_val;
   }
   function getNoLog()
   {
      return this.nolog;
   }
   function logSessionMessage(plog_service_url, pauth_token, psession_id, puser_guid)
   {
      this.debug("logSessionMessage ()");
      this.simpleSessionLog(plog_service_url,pauth_token,psession_id,puser_guid);
   }
   function simpleSessionLog(plog_service_url, pauth_token, psession_id, puser_guid)
   {
      this.debug("simpleSessionLog ()");
      if(this.nolog == true)
      {
         this.debug("Logging is globally disabled, aborting but indicating to the shell we\'re ok ...");
         this.dispatchEvent({type:"LoggingInitialized",target:this});
         return undefined;
      }
      if(this.sessionEstablished == true)
      {
         this.debug("We\'ve already sent a session message to the log server, aborting ...");
         return undefined;
      }
      if(this.isLivePreview() == true || _global.theShell.BehaviorRecorder == "AuthorTime")
      {
         this.debug("We\'re operating in live preview mode or are working in author time");
         return undefined;
      }
      this.resetStatus();
      var _loc3_ = 0;
      while(_loc3_ < this.proxies.length)
      {
         this.debug("Setting session object for proxy: " + _loc3_);
         this.debug("Calling simpleSessionLog on proxy: " + _loc3_);
         this.proxies[_loc3_].simpleSessionLog(plog_service_url,pauth_token,psession_id,puser_guid);
         _loc3_ = _loc3_ + 1;
      }
      this.sessionEstablished = true;
   }
   function SendLog(infoString, theActionMsgDescription)
   {
      this.debug("SendLog ()");
      this.debug("Raw log stream: " + infoString);
      if(this.nolog == true)
      {
         this.debug("Logging is globally disabled, aborting ...");
         return undefined;
      }
      if(this.isLivePreview() == true || _global.theShell.BehaviorRecorder == "AuthorTime")
      {
         this.debug("We\'re operating in live preview mode or are working in author time");
         return undefined;
      }
      if(this.sessionEstablished == false)
      {
         this.debug("The tutor hasn\'t processed an end of start state yet, we shouldn\'t log yet other than the session record");
         return undefined;
      }
      this.resetStatus();
      var _loc3_ = 0;
      while(_loc3_ < this.proxies.length)
      {
         this.debug("Setting session object for proxy: " + _loc3_);
         this.debug("Calling SendLog on proxy: " + _loc3_);
         this.proxies[_loc3_].SendLog(infoString,theActionMsgDescription);
         _loc3_ = _loc3_ + 1;
      }
   }
   function resetStatus()
   {
      this.debug("resetStatus ()");
      var _loc2_ = 0;
      while(_loc2_ < this.proxies.length)
      {
         this.debug("Resetting proxy: " + _loc2_);
         this.proxies[_loc2_].setStatus("NOTOK");
         _loc2_ = _loc2_ + 1;
      }
   }
   function processProxyReady()
   {
      this.debug("processProxyReady ()");
      var _loc2_ = 0;
      var _loc3_ = true;
      this.debug("Inspecing proxies ...");
      _loc2_ = 0;
      while(_loc2_ < this.proxies.length)
      {
         this.debug("Inspecing proxy " + _loc2_ + " with mode " + this.proxies[_loc2_].getMode());
         if(this.proxies[_loc2_].getMode() == "SENDING")
         {
            if(this.proxies[_loc2_].getStatus() == "NOTOK")
            {
               this.debug("Proxy " + _loc2_ + " is in sending mode and reports NOTOK");
               _loc3_ = false;
            }
            else
            {
               this.debug("Proxy " + _loc2_ + " is in sending mode and reports OK");
            }
         }
         if(this.proxies[_loc2_].getMode() == "CONNECT")
         {
            if(this.proxies[_loc2_].getStatus() == "NOTOK")
            {
               this.debug("Proxy " + _loc2_ + " is in connect mode and reports NOTOK");
               _loc3_ = false;
            }
            else
            {
               this.debug("Proxy " + _loc2_ + " is in connect mode and reports OK");
            }
         }
         if(this.proxies[_loc2_].getMode() == "DORMANT")
         {
            this.debug("Proxy " + _loc2_ + " is in dormant mode");
         }
         _loc2_ = _loc2_ + 1;
      }
      if(_loc3_ == true)
      {
         if(this.initialized == false)
         {
            this.dispatchEvent({type:"LoggingInitialized",target:this});
            this.initialized = true;
         }
      }
   }
   function getSafeLogger()
   {
      this.debug("getSafeLogger ()");
      var _loc2_ = 0;
      _loc2_ = 0;
      while(_loc2_ < this.proxies.length)
      {
         if(this.proxies[_loc2_].getFailed() == false)
         {
            return this.proxies[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      return null;
   }
   function processFailOver()
   {
      this.debug("processFailOver ()");
      var _loc2_ = 0;
      _loc2_ = 0;
      while(_loc2_ < this.proxies.length)
      {
         if(this.proxies[_loc2_].getFailed() == true)
         {
            var _loc3_ = this.getSafeLogger();
            if(_loc3_ == null)
            {
               var _loc4_ = new edu.cmu.hcii.ctat.CTATShellTools();
               _loc4_.displayMessage("The tutor was not able to establish a connection to a log server. To ensure no data is lost we are disabling the tutor",null,"FATAL");
            }
            else
            {
               this.failOver(this.proxies[_loc2_],_loc3_);
            }
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function failOver(from, to)
   {
      this.debug("processFailOver ()");
      if(from.getQueueSize() <= from.maxqueue)
      {
         if(from.getStatus() == "NOTOK")
         {
         }
      }
      to.setMode("SEND");
   }
}
