class edu.cmu.hcii.ctat.CTATURL extends edu.cmu.hcii.ctat.CTATBase
{
   var formatted = "";
   var prot = "http:";
   var host = "localhost";
   var port = "80";
   var path = "/";
   var quer = "";
   function CTATURL(strURL)
   {
      super();
      this.setClassType("CTATURL");
      this.debug("CTATURL ()");
      if(!strURL)
      {
         throw new Error("URL :: Constructor :: ERROR -> A URL string must be passed as a parameter.");
      }
      else
      {
         this.m_strURL = strURL;
         this.prot = this.InternalGetProtocol().toLowerCase();
         this.host = this.InternalGetHost().toLowerCase();
         this.port = this.InternalGetPort().toLowerCase();
         this.path = this.InternalGetPath();
         this.quer = this.GetQueryAsString();
      }
   }
   function InternalGetProtocol()
   {
      var _loc3_ = this.valueOf();
      var _loc2_ = _loc3_.indexOf(":");
      if(_loc2_ != -1)
      {
         return _loc3_.substring(0,_loc2_ + 1);
      }
      return "";
   }
   function InternalGetHost()
   {
      var _loc2_ = this.valueOf();
      _loc2_ = _loc2_.substring(this.InternalGetProtocol().length,_loc2_.length);
      _loc2_ = _loc2_.slice(2,_loc2_.length);
      var _loc3_ = _loc2_.indexOf("/");
      if(_loc3_ != -1)
      {
         _loc2_ = _loc2_.slice(0,_loc3_);
         _loc2_ = _loc2_.split("/").join("");
      }
      var _loc4_ = _loc2_.indexOf(":");
      if(_loc4_ != -1)
      {
         _loc2_ = _loc2_.substring(0,_loc4_);
      }
      return _loc2_;
   }
   function InternalGetDomain()
   {
      if(!this.IsIPAddress(this.InternalGetHost()))
      {
         var _loc3_ = this.InternalGetHost();
         var _loc2_ = _loc3_.split(".");
         if(_loc2_.length > 2)
         {
            return _loc2_.slice(1,_loc2_.length).join(".");
         }
         return _loc2_.join(".");
      }
      return "";
   }
   function InternalGetPort()
   {
      var _loc2_ = this.valueOf();
      _loc2_ = _loc2_.substring(this.InternalGetProtocol().length,_loc2_.length);
      var _loc3_ = _loc2_.indexOf(":");
      if(_loc3_ != -1)
      {
         var _loc4_ = _loc2_.indexOf("/",_loc3_);
         return _loc2_.substring(_loc3_ + 1,_loc4_ == -1?_loc2_.length:_loc4_);
      }
      return "";
   }
   function InternalGetPath()
   {
      var _loc2_ = this.valueOf();
      var _loc6_ = this.InternalGetHost();
      var _loc7_ = _loc2_.indexOf(_loc6_);
      var _loc5_ = _loc2_.substring(_loc7_ + _loc6_.length,_loc2_.length).split("/");
      _loc2_ = _loc5_.splice(1,_loc5_.length - 1).join("/");
      var _loc4_ = _loc2_.indexOf("#");
      var _loc3_ = _loc2_.indexOf("?");
      if(_loc4_ != -1 || _loc3_ != -1)
      {
         _loc2_ = _loc2_.substring(0,Math.min(_loc4_ == -1?_loc2_.length:_loc4_,_loc3_ == -1?_loc2_.length:_loc3_));
      }
      return _loc2_;
   }
   function InternalGetHash()
   {
      var _loc2_ = this.valueOf();
      var _loc3_ = _loc2_.indexOf("#");
      if(_loc3_ != -1)
      {
         var _loc4_ = _loc2_.indexOf("?",_loc3_);
         return _loc2_.substring(_loc3_ + 1,_loc4_ == -1?_loc2_.length:_loc4_);
      }
      return "";
   }
   function GetQueryAsString()
   {
      var _loc2_ = this.valueOf();
      var _loc3_ = _loc2_.indexOf("?");
      if(_loc3_ != -1)
      {
         var _loc4_ = _loc2_.indexOf("#",_loc3_);
         return _loc2_.substring(_loc3_ + 1,_loc4_ == -1?_loc2_.length:_loc4_);
      }
      return "";
   }
   function IsSecure()
   {
      return this.InternalGetProtocol() == "https:";
   }
   function IsEqualTo(objURL)
   {
      return this.m_strURL == objURL.valueOf();
   }
   function IsIPAddress(strHost)
   {
      var _loc2_ = strHost.split(".");
      if(_loc2_.length < 4)
      {
         return false;
      }
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         if(isNaN(parseInt(_loc2_[_loc1_])))
         {
            return false;
         }
         _loc1_ = _loc1_ + 1;
      }
      return true;
   }
   function toString()
   {
      this.formatted = this.prot;
      this.formatted = this.formatted + "//";
      this.formatted = this.formatted + this.host;
      if(this.port != "")
      {
         this.formatted = this.formatted + ":";
         this.formatted = this.formatted + this.port;
      }
      if(this.path != "")
      {
         var _loc2_ = this.path.indexOf("/");
         if(_loc2_ != 0)
         {
            this.formatted = this.formatted + "/";
         }
         this.formatted = this.formatted + this.path;
      }
      return this.formatted;
   }
   function getQueryString()
   {
      return this.quer;
   }
   function valueOf()
   {
      return this.m_strURL.concat();
   }
}
