class edu.cmu.hcii.ctat.CTATCommLoggingLibraryCore extends edu.cmu.hcii.ctat.CTATMovieClipBase
{
   var className = "CTATCommLoggingLibraryCore";
   var publicVersion = "2.5.4F";
   static var version = "2.5.4F";
   static var DTDversion = "4";
   var outgoingQueue = null;
   var maxqueue = 15;
   var sendQueued = false;
   function CTATCommLoggingLibraryCore()
   {
      super();
      this.setClassType("CTATCommLoggingLibraryCore");
      this.debug("CTATCommLoggingLibraryCore ()");
      this.outgoingQueue = new Array();
   }
   function FormatTimeStamp(stamp)
   {
      var _loc1_ = "";
      var _loc8_ = stamp.getUTCFullYear();
      _loc1_ = _loc1_ + (_loc8_ + "/");
      var _loc3_ = stamp.getUTCMonth();
      _loc3_ = _loc3_ + 1;
      _loc1_ = _loc1_ + ((_loc3_ >= 10?_loc3_:"0" + _loc3_) + "/");
      var _loc4_ = stamp.getUTCDate();
      _loc1_ = _loc1_ + ((_loc4_ >= 10?_loc4_:"0" + _loc4_) + " ");
      var _loc7_ = stamp.getUTCHours();
      _loc1_ = _loc1_ + ((_loc7_ >= 10?_loc7_:"0" + _loc7_) + ":");
      var _loc5_ = stamp.getUTCMinutes();
      _loc1_ = _loc1_ + ((_loc5_ >= 10?_loc5_:"0" + _loc5_) + ":");
      var _loc6_ = stamp.getUTCSeconds();
      _loc1_ = _loc1_ + (_loc6_ >= 10?_loc6_:"0" + _loc6_);
      var _loc9_ = stamp.getUTCMilliseconds();
      _loc1_ = _loc1_ + ".";
      _loc1_ = _loc1_ + _loc9_;
      return _loc1_;
   }
   function calculateServerOffset(localStamp, serverStamp)
   {
   }
   function gettabLevel()
   {
      return this.tabLevel;
   }
   function setTabLevel()
   {
      this.tabLevel = new Array();
      var _loc3_ = "";
      var _loc2_ = 0;
      while(_loc2_ < 20)
      {
         this.tabLevel.push(_loc3_);
         _loc3_ = _loc3_ + "\t";
         _loc2_ = _loc2_ + 1;
      }
   }
   function escapeXML(xmlToEscape1)
   {
      var _loc1_ = String(xmlToEscape1);
      _loc1_ = _loc1_.split("&amp;").join("&");
      _loc1_ = _loc1_.split("&").join("&amp;");
      _loc1_ = _loc1_.split("<").join("&lt;");
      _loc1_ = _loc1_.split(">").join("&gt;");
      _loc1_ = _loc1_.split("=").join("&#61;");
      return _loc1_;
   }
   function caseInsIndexOf(string1, string2)
   {
      var _loc1_ = string1.toLowerCase();
      var _loc2_ = string2.toLowerCase();
      if(string1 == undefined || string2 == undefined)
      {
         return false;
      }
      if(_loc1_.indexOf(_loc2_) != -1)
      {
         return true;
      }
      return false;
   }
   function getGuid()
   {
      return edu.cmu.hcii.ctat.CTATGuid.create();
   }
   function getClassVersion()
   {
      return this.publicVersion;
   }
   function getDTDversion()
   {
      return edu.cmu.hcii.ctat.CTATCommLoggingLibraryCore.DTDversion;
   }
   function ExternalLogging(theMsg)
   {
      if(_global.theShell.jsProxy != undefined && _global.theShell.jsProxy != null)
      {
         _global.theShell.jsProxy.jsDataShopLog(theMsg);
      }
   }
   function createOutoingMessage()
   {
      this.debug("createOutoingMessage ()");
      var _loc2_ = this.outgoingQueue.length;
      this.outgoingQueue[_loc2_] = new edu.cmu.hcii.ctat.CTATOutgoingMessage();
      this.outgoingQueue[_loc2_].xmlobj = new XML("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
      this.outgoingQueue[_loc2_].xmlobj.ignoreWhite = true;
      this.outgoingQueue[_loc2_].receiveXMLContent = new XML();
      this.outgoingQueue[_loc2_].receiveXMLContent.onData = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.receiveData);
      this.outgoingQueue[_loc2_].receiveXMLContent.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.receiveLoad);
      this.outgoingQueue[_loc2_].receiveXMLContent.onHTTPStatus = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.receiveHTTPStatus);
      return this.outgoingQueue[_loc2_];
   }
   function processQueue()
   {
      this.debug("processQueue ()");
      this.debug("Currently " + this.outgoingQueue.length + " in the queue");
      var _loc3_ = false;
      var _loc2_ = null;
      while(_loc3_ == false && this.outgoingQueue.length != 0)
      {
         _loc2_ = this.outgoingQueue[0];
         if(_loc2_.sent == true)
         {
            this.debug("Removing one outgoing message from the queue");
            this.outgoingQueue.splice(0,1);
            this.debug("Currently " + this.outgoingQueue.length + " in the queue");
            _loc2_ = null;
         }
         else
         {
            _loc3_ = true;
         }
      }
      return _loc2_;
   }
   function receiveData(src)
   {
      this.debug("receiveData (" + src + ")");
   }
   function receiveLoad(success)
   {
      this.debug("receiveLoad (" + success.toString() + ")");
   }
   function receiveHTTPStatus(httpStatus)
   {
      this.debug("receiveHTTPStatus (" + httpStatus + ")");
   }
   function showStatus(msg)
   {
      this.debug("showStatus ()");
      switch(msg.xmlobj.status)
      {
         case 0:
            this.debug("(STATUS) No error; parse was completed successfully.");
            break;
         case -2:
            this.debug("(STATUS) A CDATA section was not properly terminated.");
            break;
         case -3:
            this.debug("(STATUS) The XML declaration was not properly terminated.");
            break;
         case -4:
            this.debug("(STATUS) The DOCTYPE declaration was not properly terminated.");
            break;
         case -5:
            this.debug("(STATUS) A comment was not properly terminated.");
            break;
         case -6:
            this.debug("(STATUS) An XML element was malformed.");
            break;
         case -7:
            this.debug("(STATUS) Out of memory.");
            break;
         case -8:
            this.debug("(STATUS) An attribute value was not properly terminated.");
            break;
         case -9:
            this.debug("(STATUS) A start-tag was not matched with an end-tag.");
            break;
         case -10:
            this.debug("(STATUS) An end-tag was encountered without a matching start-tag.");
            break;
         default:
            this.debug("(STATUS) An unknown error has occurred.");
      }
   }
}
