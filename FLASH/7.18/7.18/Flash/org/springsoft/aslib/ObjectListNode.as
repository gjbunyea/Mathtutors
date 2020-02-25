class org.springsoft.aslib.ObjectListNode implements org.springsoft.aslib.ListNode
{
   function ObjectListNode(data)
   {
      this.next_ = null;
      this.data_ = data;
   }
   function §get§(Void)
   {
      return this.data_;
   }
   function getNext(Void)
   {
      return this.next_;
   }
   function setNext(node)
   {
      this.next_ = (org.springsoft.aslib.ObjectListNode)node;
   }
   function §set§(data)
   {
      this.data_ = data;
   }
   function toString(Void)
   {
      return this.data_.toString();
   }
   function getKey(Void)
   {
      return this.data_.getKey();
   }
}
