class edu.cmu.hcii.ctat.CTATGlobal extends edu.cmu.hcii.ctat.CTATRoot
{
   static var suppressDebug = false;
   static var silent = false;
   static var inited = false;
   static var temper = new String();
   static var depthIndex = 1000;
   static var uniqueindex = 1;
   static var uniquename = new String();
   static var doneMsg = null;
   static var result_lv = null;
   static var bailout_lv = null;
   function CTATGlobal()
   {
      super();
   }
   static function internalInit()
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.inited == false)
      {
         edu.cmu.hcii.ctat.CTATGlobal.inited = true;
      }
   }
   static function getNextHighestDepth()
   {
      edu.cmu.hcii.ctat.CTATGlobal.depthIndex = edu.cmu.hcii.ctat.CTATGlobal.depthIndex + 1;
      return edu.cmu.hcii.ctat.CTATGlobal.depthIndex;
   }
   static function getUniqueName()
   {
      edu.cmu.hcii.ctat.CTATGlobal.uniqueindex = edu.cmu.hcii.ctat.CTATGlobal.uniqueindex + 1;
      return "inst" + edu.cmu.hcii.ctat.CTATGlobal.uniqueindex;
   }
   static function createInstanceName()
   {
      return edu.cmu.hcii.ctat.CTATGlobal.getUniqueName();
   }
   static function dbg_remote(shell, source, message)
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return undefined;
      }
      edu.cmu.hcii.ctat.CTATGlobal.internalInit();
      var _loc1_ = "";
      var _loc2_ = new Date();
      var _loc10_ = _loc2_.getUTCFullYear();
      var _loc6_ = _loc2_.getUTCHours();
      _loc1_ = _loc1_ + ((_loc6_ >= 10?_loc6_:"0" + _loc6_) + ":");
      var _loc4_ = _loc2_.getUTCMinutes();
      _loc1_ = _loc1_ + ((_loc4_ >= 10?_loc4_:"0" + _loc4_) + ":");
      var _loc5_ = _loc2_.getUTCSeconds();
      _loc1_ = _loc1_ + (_loc5_ >= 10?_loc5_:"0" + _loc5_);
      var _loc3_ = _loc2_.getUTCMilliseconds();
      _loc1_ = _loc1_ + ".";
      if(_loc3_ < 10)
      {
         _loc1_ = _loc1_ + ("00" + _loc3_);
      }
      else if(_loc3_ < 100)
      {
         _loc1_ = _loc1_ + ("0" + _loc3_);
      }
      else
      {
         _loc1_ = _loc1_ + _loc3_;
      }
      var _loc7_ = "NotAssigned";
      if(source != null)
      {
         _loc7_ = source.classType();
      }
      var _loc8_ = "[" + _loc1_ + "] <" + _loc7_ + "> " + message;
      edu.cmu.hcii.ctat.CTATGlobal.CTATTrace(_loc8_);
   }
   static function dbg(source, message)
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return undefined;
      }
      edu.cmu.hcii.ctat.CTATGlobal.internalInit();
      var _loc7_ = "NotAssigned";
      if(source != null)
      {
         _loc7_ = source.classType();
      }
      var _loc1_ = "";
      var _loc2_ = new Date();
      var _loc10_ = _loc2_.getUTCFullYear();
      var _loc6_ = _loc2_.getUTCHours();
      _loc1_ = _loc1_ + ((_loc6_ >= 10?_loc6_:"0" + _loc6_) + ":");
      var _loc4_ = _loc2_.getUTCMinutes();
      _loc1_ = _loc1_ + ((_loc4_ >= 10?_loc4_:"0" + _loc4_) + ":");
      var _loc5_ = _loc2_.getUTCSeconds();
      _loc1_ = _loc1_ + (_loc5_ >= 10?_loc5_:"0" + _loc5_);
      var _loc3_ = _loc2_.getUTCMilliseconds();
      _loc1_ = _loc1_ + ".";
      if(_loc3_ < 10)
      {
         _loc1_ = _loc1_ + ("00" + _loc3_);
      }
      else if(_loc3_ < 100)
      {
         _loc1_ = _loc1_ + ("0" + _loc3_);
      }
      else
      {
         _loc1_ = _loc1_ + _loc3_;
      }
      var _loc8_ = "[" + _loc1_ + "] <" + _loc7_ + "> " + message;
      edu.cmu.hcii.ctat.CTATGlobal.CTATTrace(_loc8_);
   }
   static function debug_raw(message)
   {
      trace(message);
   }
   static function debug(a_class, message)
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return undefined;
      }
      edu.cmu.hcii.ctat.CTATGlobal.internalInit();
      var _loc1_ = "";
      var _loc2_ = new Date();
      var _loc8_ = _loc2_.getUTCFullYear();
      var _loc6_ = _loc2_.getUTCHours();
      _loc1_ = _loc1_ + ((_loc6_ >= 10?_loc6_:"0" + _loc6_) + ":");
      var _loc4_ = _loc2_.getUTCMinutes();
      _loc1_ = _loc1_ + ((_loc4_ >= 10?_loc4_:"0" + _loc4_) + ":");
      var _loc5_ = _loc2_.getUTCSeconds();
      _loc1_ = _loc1_ + (_loc5_ >= 10?_loc5_:"0" + _loc5_);
      var _loc3_ = _loc2_.getUTCMilliseconds();
      _loc1_ = _loc1_ + ".";
      if(_loc3_ < 10)
      {
         _loc1_ = _loc1_ + ("00" + _loc3_);
      }
      else if(_loc3_ < 100)
      {
         _loc1_ = _loc1_ + ("0" + _loc3_);
      }
      else
      {
         _loc1_ = _loc1_ + _loc3_;
      }
      var _loc7_ = "[" + _loc1_ + "] <" + a_class + "> " + message;
      edu.cmu.hcii.ctat.CTATGlobal.CTATTrace(_loc7_);
   }
   static function fixXML(theMsg)
   {
      edu.cmu.hcii.ctat.CTATGlobal.temper = theMsg;
      while(edu.cmu.hcii.ctat.CTATGlobal.temper.indexOf("\'") != -1)
      {
         edu.cmu.hcii.ctat.CTATGlobal.temper = edu.cmu.hcii.ctat.CTATGlobal.temper.replace("\'","#");
      }
      while(edu.cmu.hcii.ctat.CTATGlobal.temper.indexOf("#") != -1)
      {
         edu.cmu.hcii.ctat.CTATGlobal.temper = edu.cmu.hcii.ctat.CTATGlobal.temper.replace("#","\\\'");
      }
      return edu.cmu.hcii.ctat.CTATGlobal.temper;
   }
   static function CTATTrace(a_string)
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return undefined;
      }
      if(edu.cmu.hcii.ctat.CTATGlobal.silent == false)
      {
         trace(a_string);
         if(_global.theShell.jsProxy != undefined && _global.theShell.jsProxy != null)
         {
            _global.theShell.jsProxy.jsTrace(a_string);
         }
      }
   }
}
