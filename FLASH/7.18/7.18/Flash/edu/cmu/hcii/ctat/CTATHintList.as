class edu.cmu.hcii.ctat.CTATHintList extends edu.cmu.hcii.ctat.CTATBase
{
   var hints = null;
   function CTATHintList()
   {
      super();
      this.setClassType("CTATHintList");
      this.debug("CTATHintList ()");
      this.hints = new Array();
   }
   function getFirstHint()
   {
      if(this.hints != null)
      {
         if(this.hints.length > 0)
         {
            return this.hints[0];
         }
      }
      return null;
   }
   function parseXML(xmlObject)
   {
      this.debug("parseXML ()");
      this.hints = new Array();
      var _loc3_ = xmlObject.childNodes;
      if(_loc3_.length == 0)
      {
         return undefined;
      }
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         if(_loc3_[_loc2_].nodeName == "value")
         {
            this.debug("Adding hint: " + _loc3_[_loc2_].firstChild.nodeValue);
            this.hints.push(_loc3_[_loc2_].firstChild.nodeValue);
         }
         else
         {
            this.hints.push(_loc3_[_loc2_].nodeValue);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
