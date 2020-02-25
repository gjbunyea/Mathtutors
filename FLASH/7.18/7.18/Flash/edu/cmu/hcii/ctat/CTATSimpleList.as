class edu.cmu.hcii.ctat.CTATSimpleList extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATSimpleList()
   {
      super();
      this.setClassType("CTATSimpleList");
      this.debug("CTATSimpleList ()");
      this.arList = new Array();
   }
   function insert(obj, theSelection)
   {
      this.getList().push({theObj:obj,selection:theSelection});
      return undefined;
   }
   function getList()
   {
      return this.arList;
   }
   function getItemByIndex(num)
   {
      return this.getList()[num].theObj;
   }
   function getItemByInstanceName(name)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.getList().length)
      {
         if(name == this.getList()[_loc2_].selection)
         {
            return this.getList()[_loc2_].theObj;
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function getLength()
   {
      return this.getList().length;
   }
   function getListLength()
   {
      return this.getLength();
   }
   function isEmpty(Void)
   {
      if(this.getList().length == 0)
      {
         return true;
      }
      return false;
   }
   function removeItemAtIndex(idx)
   {
      this.getList().splice(idx,1);
      return undefined;
   }
   function removeItemWithName(name)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.getList().length)
      {
         if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(name,this.getList()[_loc2_].selection))
         {
            this.getList()[_loc2_].splice(_loc2_,1);
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function print(Void)
   {
      this.debug("=============================");
      this.debug("SimpleList");
      var _loc2_ = 0;
      while(_loc2_ < this.getList().length)
      {
         this.debug(this.getList()[_loc2_].selection);
         _loc2_ = _loc2_ + 1;
      }
      this.debug("=============================");
   }
}
