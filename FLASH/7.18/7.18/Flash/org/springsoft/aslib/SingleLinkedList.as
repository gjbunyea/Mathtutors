class org.springsoft.aslib.SingleLinkedList
{
   function SingleLinkedList()
   {
      this.head_ = null;
   }
   function isEmpty(Void)
   {
      return null != this.head_?false:true;
   }
   function insert(data)
   {
      this.insertFront(new org.springsoft.aslib.ObjectListNode(data));
   }
   function insertTail(data)
   {
      if(this.isEmpty())
      {
         this.insert(data);
      }
      else
      {
         var _loc3_ = null;
         var _loc2_ = this.head_;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.getNext();
         }
         this.insertEnd(new org.springsoft.aslib.ObjectListNode(data),_loc3_);
      }
   }
   function §get§(key)
   {
      var _loc2_ = this.head_;
      while(_loc2_ != null)
      {
         if(key == _loc2_.getKey())
         {
            break;
         }
         _loc2_ = _loc2_.getNext();
      }
      return _loc2_;
   }
   function getData(key)
   {
      return this["get"](key)["get"]();
   }
   function getAt(index)
   {
      var _loc2_ = this.head_;
      var _loc3_ = 0;
      while(_loc2_ != null)
      {
         if(index == _loc3_)
         {
            break;
         }
         _loc3_ = _loc3_ + 1;
         _loc2_ = _loc2_.getNext();
      }
      return _loc2_;
   }
   function getDataAt(index)
   {
      return this.getAt(index)["get"]();
   }
   function remove(key)
   {
      var _loc3_ = this.head_;
      var _loc2_ = this.head_;
      while(_loc2_ != null)
      {
         if(key == _loc2_.getKey())
         {
            if(this.isFront(_loc2_))
            {
               return this.removeFront();
            }
            if(this.isEnd(_loc2_))
            {
               return this.removeEnd(_loc3_);
            }
            return this.removeMiddle(_loc3_);
         }
         _loc3_ = _loc2_;
         _loc2_ = _loc2_.getNext();
      }
      return null;
   }
   function removeData(key)
   {
      return this.remove(key)["get"]();
   }
   function removeAt(index)
   {
      var _loc3_ = this.head_;
      var _loc4_ = 0;
      var _loc2_ = this.head_;
      while(_loc2_ != null)
      {
         if(index == _loc4_)
         {
            if(this.isFront(_loc2_))
            {
               return this.removeFront();
            }
            if(this.isEnd(_loc2_))
            {
               return this.removeEnd(_loc3_);
            }
            return this.removeMiddle(_loc3_);
         }
         _loc4_ = _loc4_ + 1;
         _loc3_ = _loc2_;
         _loc2_ = _loc2_.getNext();
      }
      return null;
   }
   function removeDataAt(index)
   {
      return this.removeAt(index)["get"]();
   }
   function removeAll()
   {
      var _loc3_ = this.head_;
      var _loc2_ = this.head_;
      while(_loc2_ != null)
      {
         if(null == _loc2_.getNext() && null != _loc3_.getNext())
         {
            _loc2_ = null;
         }
         if(_loc3_ != _loc2_)
         {
            _loc3_.setNext(null);
            _loc3_ = null;
         }
         _loc3_ = _loc2_;
         _loc2_ = _loc2_.getNext();
      }
      if(null != this.head_)
      {
         this.head_.setNext(null);
         this.head_ = null;
      }
   }
   function getFront(canDelete)
   {
      var _loc2_ = this.head_;
      if(canDelete)
      {
         this.removeFront();
      }
      return _loc2_;
   }
   function getFrontData(canDelete)
   {
      return this.getFront(canDelete)["get"]();
   }
   function print(Void)
   {
      trace("=======================");
      trace("Single Linked List HEAD");
      var _loc2_ = this.head_;
      while(_loc2_ != null)
      {
         trace(_loc2_.toString());
         _loc2_ = _loc2_.getNext();
      }
      trace("Single Linked List TAIL");
      trace("=======================");
   }
   function size(Void)
   {
      var _loc2_ = this.head_;
      var _loc3_ = 0;
      while(_loc2_ != null)
      {
         _loc3_ = _loc3_ + 1;
         _loc2_ = _loc2_.getNext();
      }
      return _loc3_;
   }
   function isFront(node)
   {
      return this.head_ != node?false:true;
   }
   function isEnd(node)
   {
      return null != node.getNext()?false:true;
   }
   function hasOneNode(Void)
   {
      if(null == this.head_.getNext() && this.isEmpty())
      {
         return true;
      }
      return false;
   }
   function insertFront(node)
   {
      if(this.isEmpty())
      {
         this.head_ = node;
         node.setNext(null);
      }
      else
      {
         node.setNext(this.head_);
         this.head_ = node;
      }
   }
   function removeFront()
   {
      var _loc2_ = null;
      if(!this.isEmpty())
      {
         if(this.hasOneNode())
         {
            _loc2_ = this.head_;
            this.head_ = null;
         }
         else
         {
            _loc2_ = this.head_;
            this.head_ = this.head_.getNext();
         }
      }
      return _loc2_;
   }
   function insertMiddle(node, targetNode)
   {
      node.setNext(targetNode.getNext());
      targetNode.setNext(node);
   }
   function removeMiddle(previous)
   {
      var _loc1_ = previous.getNext();
      previous.setNext(_loc1_.getNext());
      return _loc1_;
   }
   function insertEnd(node, targetNode)
   {
      targetNode.setNext(node);
      node.setNext(null);
   }
   function removeEnd(previous)
   {
      var _loc1_ = previous.getNext();
      previous.setNext(null);
      return _loc1_;
   }
}
