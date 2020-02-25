class pact.datastructures.SingletonList extends edu.cmu.hcii.ctat.CTATBase
{
   static var className = "SingletonList";
   function SingletonList()
   {
      super();
      this.list = new Array();
      this.linkedList = new org.springsoft.aslib.SingleLinkedList();
   }
   function classType()
   {
      return pact.datastructures.SingletonList.className;
   }
   static function getInstance()
   {
      if(pact.datastructures.SingletonList._singletonList == null || pact.datastructures.SingletonList._singletonList == undefined)
      {
         pact.datastructures.SingletonList._singletonList = new pact.datastructures.SingletonList();
      }
      return pact.datastructures.SingletonList._singletonList;
   }
   function insert(obj)
   {
      this.getList().push(obj);
      edu.cmu.hcii.ctat.CTATComponentList.addComponent(obj);
   }
   function update(obj)
   {
      edu.cmu.hcii.ctat.CTATComponentList.updateComponent(obj);
   }
   function getAtIndex(num)
   {
      return this.getList()[num];
   }
   function getItemByInstanceName(name)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.getList().length)
      {
         if(name == this.getList()[_loc2_]._name)
         {
            return this.getList()[_loc2_];
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function getList()
   {
      return this.list;
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
         if(edu.cmu.hcii.ctat.CTATUtil.equalsIgnoreCase(name,this.getList()[_loc2_]._name))
         {
            this.getList()[_loc2_].splice(_loc2_,1);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function print(Void)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.getList().length)
      {
         _loc2_ = _loc2_ + 1;
      }
   }
}
