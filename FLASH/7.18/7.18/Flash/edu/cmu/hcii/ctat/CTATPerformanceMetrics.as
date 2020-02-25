class edu.cmu.hcii.ctat.CTATPerformanceMetrics extends edu.cmu.hcii.ctat.CTATBase
{
   var markerStart = 0;
   var markerEnd = 0;
   function CTATPerformanceMetrics()
   {
      super();
      this.setClassType("CTATPerformanceMetrics");
      this.debug("CTATPerformanceMetrics ()");
   }
   function startMarker()
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return undefined;
      }
      this.debug("startMarker ()");
      var _loc2_ = new Date();
      this.markerStart = _loc2_.getTime();
      this.markerEnd = this.markerStart;
   }
   function readMarker()
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return "";
      }
      this.debug("readMarker ()");
      var _loc3_ = new Date();
      this.markerEnd = _loc3_.getTime();
      var _loc2_ = this.markerEnd - this.markerStart;
      return _loc2_.toString();
   }
   function startMarkerAndReset()
   {
      if(edu.cmu.hcii.ctat.CTATGlobal.suppressDebug == true)
      {
         return "";
      }
      this.debug("startMarkerAndReset ()");
      var _loc3_ = new Date();
      this.markerEnd = _loc3_.getTime();
      var _loc2_ = this.markerEnd - this.markerStart;
      this.markerStart = this.markerEnd;
      return _loc2_.toString();
   }
   static function getPaddedTime()
   {
      var _loc2_ = new Date();
      var _loc1_ = "";
      _loc1_ = _loc1_ + (_loc2_.getFullYear() + "-");
      _loc1_ = _loc1_ + (edu.cmu.hcii.ctat.CTATPerformanceMetrics.padNumber(_loc2_.getMonth() + 1,2) + "-");
      _loc1_ = _loc1_ + (edu.cmu.hcii.ctat.CTATPerformanceMetrics.padNumber(_loc2_.getDate(),2) + " ");
      _loc1_ = _loc1_ + (edu.cmu.hcii.ctat.CTATPerformanceMetrics.padNumber(_loc2_.getHours(),2) + ":");
      _loc1_ = _loc1_ + (edu.cmu.hcii.ctat.CTATPerformanceMetrics.padNumber(_loc2_.getMinutes(),2) + ":");
      _loc1_ = _loc1_ + (edu.cmu.hcii.ctat.CTATPerformanceMetrics.padNumber(_loc2_.getSeconds(),2) + ".");
      _loc1_ = _loc1_ + edu.cmu.hcii.ctat.CTATPerformanceMetrics.padNumber(_loc2_.getMilliseconds(),3);
      return _loc1_;
   }
   static function padNumber(num, len)
   {
      var _loc4_ = num.toString();
      var _loc1_ = _loc4_.length;
      var _loc2_ = "";
      while(_loc1_ < len)
      {
         _loc2_ = _loc2_ + "0";
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_ + _loc4_;
   }
}
