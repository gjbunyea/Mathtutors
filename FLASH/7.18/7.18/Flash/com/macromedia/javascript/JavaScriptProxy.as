class com.macromedia.javascript.JavaScriptProxy
{
   function JavaScriptProxy(lcId, instance)
   {
      if(lcId == undefined || instance == undefined)
      {
         return undefined;
      }
      this.instance = instance;
      this.lcId = lcId;
      this.receiving_lc = new LocalConnection();
      this.receiving_lc.controller = this;
      this.receiving_lc.callFlash = this.callFlash;
      this.receiving_lc.connect(this.lcId);
   }
   function callFlash(args)
   {
      var _loc2_ = this.controller;
      var _loc3_ = args.shift();
      var _loc4_ = _loc2_.instance[_loc3_];
      _loc4_.apply(_loc2_.instance,args);
   }
   function __resolve(functionName)
   {
      var _loc3_ = function()
      {
         arguments.splice(0,0,functionName);
         var _loc3_ = this.call;
         _loc3_.apply(this,arguments);
      };
      return _loc3_;
   }
   function call(functionName)
   {
      var _loc4_ = arguments.length;
      var _loc3_ = "";
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = _loc3_ + com.macromedia.javascript.JavaScriptSerializer.serializeItem(arguments[_loc2_]);
         if(_loc2_ != _loc4_ - 1)
         {
            _loc3_ = _loc3_ + ",";
         }
         _loc2_ = _loc2_ + 1;
      }
      var _loc5_ = "javascript:FlashProxy.callJS(" + _loc3_ + ");";
      getURL(_loc5_,"");
   }
}
