class edu.cmu.hcii.ctat.CTATStringUtil extends edu.cmu.hcii.ctat.CTATBase
{
   var temper = new String();
   function CTATStringUtil()
   {
      super();
      this.setClassType("CTATStringUtil");
      this.debug("CTATStringUtil ()");
   }
   static function beforeLast(p_string, p_char)
   {
      if(p_string == null)
      {
         return "";
      }
      var _loc1_ = p_string.lastIndexOf(p_char);
      if(_loc1_ == -1)
      {
         return "";
      }
      return p_string.substr(0,_loc1_);
   }
   function replace(thisStr, searchStr, replaceStr)
   {
      var _loc1_ = thisStr.split(searchStr);
      if(_loc1_ < 2)
      {
         return thisStr;
      }
      return _loc1_.join(replaceStr);
   }
   function stringToMils(a_time)
   {
      this.debug("stringToMils ()");
      var _loc3_ = a_time.split(".");
      var _loc2_ = _loc3_[0].split(":");
      return new Number(_loc2_[0]) * 60 * 80 * 1000 + new Number(_loc2_[1]) * 60 * 60 * 1000 + new Number(_loc2_[2]) * 1000 + new Number(_loc3_[1]);
   }
}
