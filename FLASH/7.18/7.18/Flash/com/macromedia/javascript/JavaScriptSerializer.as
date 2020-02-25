class com.macromedia.javascript.JavaScriptSerializer
{
   function JavaScriptSerializer()
   {
   }
   static function serializeItem(item)
   {
      var _loc3_ = typeof item;
      var _loc1_ = undefined;
      switch(_loc3_)
      {
         case "string":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeString(String(item));
            break;
         case "number":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeNumber(Number(item));
            break;
         case "boolean":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeBoolean(Boolean(item));
            break;
         case "null":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeNull();
            break;
         case "undefined":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeUndefined();
            break;
         case "object":
            if(item instanceof Date)
            {
               _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeDate(new Date(item.getTime()));
            }
            else if(item instanceof Array)
            {
               _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeArray(item);
            }
            else
            {
               _loc1_ = com.macromedia.javascript.JavaScriptSerializer.serializeObject(item);
            }
      }
      return _loc1_;
   }
   static function serializeObject(o)
   {
      var _loc2_ = "{";
      for(var _loc3_ in o)
      {
         if(typeof _loc3_[o] != "function")
         {
            _loc2_ = _loc2_ + (_loc3_ + ":" + com.macromedia.javascript.JavaScriptSerializer.serializeItem(o[_loc3_]) + ",");
         }
      }
      if(_loc2_.substring(_loc2_.length - 1) == ",")
      {
         _loc2_ = _loc2_.substring(0,_loc2_.length - 1);
      }
      _loc2_ = _loc2_ + "}";
      return _loc2_;
   }
   static function serializeArray(o)
   {
      var _loc3_ = o.length;
      var _loc2_ = "[";
      var _loc1_ = 0;
      while(_loc1_ < _loc3_)
      {
         _loc2_ = _loc2_ + com.macromedia.javascript.JavaScriptSerializer.serializeItem(o[_loc1_]);
         if(_loc1_ != _loc3_ - 1)
         {
            _loc2_ = _loc2_ + ",";
         }
         _loc1_ = _loc1_ + 1;
      }
      _loc2_ = _loc2_ + "]";
      return _loc2_;
   }
   static function serializeString(s)
   {
      return "\'" + s + "\'";
   }
   static function serializeNumber(n)
   {
      return String(n);
   }
   static function serializeBoolean(b)
   {
      return String(b);
   }
   static function serializeUndefined(Void)
   {
      return "undefined";
   }
   static function serializeNull(Void)
   {
      return "null";
   }
   static function serializeDate(d)
   {
      return "new Date(" + d.getTime() + ")";
   }
   static function deserializeItem(type, data)
   {
      var _loc1_ = undefined;
      switch(type)
      {
         case "str":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.deserializeString(data);
            break;
         case "num":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.deserializeNumber(data);
            break;
         case "bool":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.deserializeBoolean(data);
            break;
         case "null":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.deserializeNull();
            break;
         case "undf":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.deserializeUndefined();
            break;
         case "date":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.deserializeDate(data);
            break;
         case "xser":
            _loc1_ = com.macromedia.javascript.JavaScriptSerializer.deserializeXMLSerializedItem(data);
            trace(data);
      }
      return _loc1_;
   }
   static function deserializeString(s)
   {
      return s;
   }
   static function deserializeNumber(s)
   {
      return Number(s);
   }
   static function deserializeBoolean(s)
   {
      return Boolean(s);
   }
   static function deserializeUndefined(s)
   {
      return undefined;
   }
   static function deserializeNull(s)
   {
      return null;
   }
   static function deserializeDate(s)
   {
      return new Date(Number(s));
   }
   static function deserializeXMLSerializedItem(data)
   {
      var _loc1_ = new XML();
      _loc1_.ignoreWhite = true;
      _loc1_.parseXML(data);
      var _loc2_ = com.macromedia.javascript.JavaScriptSerializer.parseNode(_loc1_.firstChild.firstChild,new Object());
      return _loc2_;
   }
   static function parseNode(x, o)
   {
      var _loc9_ = x.nodeName;
      var _loc8_ = x.firstChild.nodeValue;
      var _loc4_ = x.attributes.name;
      var _loc5_ = x.childNodes;
      var _loc6_ = _loc5_.length;
      switch(_loc9_)
      {
         case "obj":
            if(_loc4_ == null)
            {
               o = new Object();
            }
            else
            {
               o[_loc4_] = new Object();
            }
         case "str":
            if(_loc4_ == undefined)
            {
               o = String(_loc8_);
            }
            else
            {
               o[_loc4_] = _loc8_;
            }
         case "num":
            if(_loc4_ == null)
            {
               o = Number(_loc8_);
            }
            else
            {
               o[_loc4_] = Number(_loc8_);
            }
         case "bool":
            if(_loc4_ == null)
            {
               o = Boolean(_loc8_);
            }
            else
            {
               o[_loc4_] = Boolean(_loc8_);
            }
         case "null":
            if(_loc4_ == null)
            {
               o = null;
            }
            else
            {
               o[_loc4_] = null;
            }
         case "undf":
            if(_loc4_ == null)
            {
               o = undefined;
            }
            else
            {
               o[_loc4_] = undefined;
            }
         case "date":
            if(_loc4_ == null)
            {
               o = new Date(Number(_loc8_));
            }
            else
            {
               o[_loc4_] = new Date(Number(_loc8_));
            }
         default:
            var _loc2_ = 0;
            while(_loc2_ < _loc6_)
            {
               com.macromedia.javascript.JavaScriptSerializer.parseNode(_loc5_[_loc2_],o);
               _loc2_ = _loc2_ + 1;
            }
            return o;
         case "array":
            var _loc7_ = undefined;
            if(_loc4_ == null)
            {
               o = new Array();
               _loc7_ = o;
            }
            else
            {
               o[_loc4_] = new Array();
               _loc7_ = o[_loc4_];
            }
            x = 0;
            while(x < _loc6_)
            {
               _loc7_.push(com.macromedia.javascript.JavaScriptSerializer.parseNode(_loc5_[x],o));
               x = x + 1;
            }
            return _loc7_;
      }
   }
}
