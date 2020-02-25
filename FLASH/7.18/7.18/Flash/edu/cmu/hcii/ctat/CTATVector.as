class edu.cmu.hcii.ctat.CTATVector extends edu.cmu.hcii.ctat.CTATBase
{
   function CTATVector(initialCapacity, capacityIncrement)
   {
      super();
      this.setClassType("CTATVector");
      this.debug("CTATVector ()");
      this.m_size = 0;
      this.m_capacity = initialCapacity;
      this.m_pData = new Array(this.m_capacity);
      this.m_increment = capacityIncrement;
   }
   function capacity()
   {
      return this.m_capacity;
   }
   function contains(elem)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_size)
      {
         if(this.m_pData[_loc2_] == elem)
         {
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function copyInto(array)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_size)
      {
         array[_loc2_] = this.m_pData[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
   }
   function convertToString()
   {
      var _loc3_ = "";
      var _loc2_ = 0;
      while(_loc2_ < this.m_size)
      {
         _loc3_ = _loc3_ + this.m_pData[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   function elementAt(index)
   {
      return this.m_pData[index];
   }
   function §get§(index)
   {
      return this.m_pData[index];
   }
   function firstElement()
   {
      if(this.m_size == 0)
      {
         trace("Vector.firstElement - array is empty");
      }
      return this.m_pData[0];
   }
   function indexOf(elem)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_size)
      {
         if(this.m_pData[_loc2_] == elem)
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
   function isEmpty()
   {
      return this.m_size == 0;
   }
   function lastElement()
   {
      if(this.m_size == 0)
      {
         trace("Vector.lastElement - its empty");
      }
      return this.m_pData[this.m_size - 1];
   }
   function lastIndexOf(elem)
   {
      if(this.m_size == 0)
      {
         return -1;
      }
      var _loc2_ = this.m_size;
      while(true)
      {
         _loc2_ = _loc2_ - 1;
         if(this.m_pData[_loc2_] == elem)
         {
            break;
         }
         if(_loc2_ == 0)
         {
            return -1;
         }
      }
      return _loc2_;
   }
   function size()
   {
      return this.m_size;
   }
   function addElement(obj)
   {
      if(this.m_size == this.m_capacity)
      {
         this.ensureCapacity(this.m_capacity + this.m_increment);
      }
      this.m_size = this.m_size + 1;
      this.m_pData[this.m_size] = obj;
   }
   function ensureCapacity(minCapacity)
   {
      if(minCapacity > this.m_capacity)
      {
         var _loc2_ = undefined;
         this.m_capacity = minCapacity;
         var _loc3_ = new Array.this.m_capacity();
         _loc2_ = 0;
         while(_loc2_ < this.m_size)
         {
            _loc3_[_loc2_] = this.m_pData[_loc2_];
            _loc2_ = _loc2_ + 1;
         }
         delete this.m_pData;
         this.m_pData = _loc3_;
      }
   }
   function insertElementAt(obj, index)
   {
      if(index == this.m_size)
      {
         this.addElement(obj);
      }
      else
      {
         this.verifyIndex(index);
         if(this.m_size == this.m_capacity)
         {
            this.ensureCapacity(this.m_capacity + this.m_increment);
         }
         var _loc3_ = obj;
         var _loc4_ = undefined;
         var _loc2_ = index;
         while(_loc2_ <= this.m_size)
         {
            _loc4_ = this.m_pData[_loc2_];
            this.m_pData[_loc2_] = _loc3_;
            if(_loc2_ != this.m_size)
            {
               _loc3_ = _loc4_;
               _loc2_ = _loc2_ + 1;
               continue;
            }
            break;
         }
         this.m_size = this.m_size + 1;
      }
   }
   function removeAllElements()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_size)
      {
         delete this.m_pData.register2;
         _loc2_ = _loc2_ + 1;
      }
      this.m_size = 0;
   }
   function removeElement(obj)
   {
      var _loc2_ = 0;
      while(_loc2_ < this.m_size)
      {
         if(this.m_pData[_loc2_] == obj)
         {
            this.removeElementAt(_loc2_);
            return true;
         }
         _loc2_ = _loc2_ + 1;
      }
      return false;
   }
   function removeElementAt(index)
   {
      this.verifyIndex(index);
      delete this.m_pData.index;
      var _loc2_ = index + 1;
      while(_loc2_ < this.m_size)
      {
         this.m_pData[_loc2_ - 1] = this.m_pData[_loc2_];
         _loc2_ = _loc2_ + 1;
      }
      this.m_pData[_loc2_];
      this.m_size = this.m_size - 1;
   }
   function setElementAt(obj, index)
   {
      this.verifyIndex(index);
      this.m_pData[index] = obj;
   }
   function setSize(newSize)
   {
      if(newSize > this.m_capacity)
      {
         this.ensureCapacity(newSize);
      }
      else if(newSize < this.m_size)
      {
         var _loc2_ = newSize;
         while(_loc2_ < this.m_size)
         {
            delete this.m_pData.register2;
            _loc2_ = _loc2_ + 1;
         }
         this.m_size = newSize;
      }
   }
   function trimToSize()
   {
      if(this.m_size != this.m_capacity)
      {
         var _loc3_ = new Array.this.m_size();
         var _loc2_ = undefined;
         _loc2_ = 0;
         while(_loc2_ < this.m_size)
         {
            _loc3_[_loc2_] = this.m_pData[_loc2_];
            _loc2_ = _loc2_ + 1;
         }
         delete this.m_pData;
         this.m_pData = _loc3_;
         this.m_capacity = this.m_size;
      }
   }
   function min(left, right)
   {
      return left >= right?right:left;
   }
   function verifyIndex(index)
   {
      if(index >= this.m_size)
      {
         trace("Vector.verifyIndex - is too big");
      }
   }
   function clone()
   {
      var _loc3_ = new edu.cmu.hcii.ctat.CTATVector();
      var _loc2_ = undefined;
      _loc2_ = 0;
      while(_loc2_ < this.m_size)
      {
         _loc3_.addElement(this.m_pData[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
}
