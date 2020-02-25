class edu.cmu.hcii.ctat.CTATXML2Object extends edu.cmu.hcii.ctat.CTATBase
{
   var oResult = new Object();
   function CTATXML2Object()
   {
      super();
   }
   function __get__xml()
   {
      return this.oXML;
   }
   function parseXML(sFile)
   {
      this.oResult = new Object();
      this.oXML = sFile;
      this.oResult = this.translateXML();
      return this.oResult;
   }
   function translateXML(from, path, name, position)
   {
      var _loc2_ = undefined;
      var _loc9_ = undefined;
      var _loc4_ = undefined;
      var _loc10_ = undefined;
      if(path == undefined)
      {
         path = this;
         name = "oResult";
      }
      path = path[name];
      if(from == undefined)
      {
         from = this.xml;
         from.ignoreWhite = true;
      }
      if(from.hasChildNodes())
      {
         _loc9_ = from.childNodes;
         if(position != undefined)
         {
            _loc10_ = path;
            path = path[position];
         }
         while(_loc9_.length > 0)
         {
            _loc4_ = _loc9_.shift();
            _loc2_ = _loc4_.nodeName;
            if(_loc2_ != undefined)
            {
               var _loc5_ = new Object();
               _loc5_.attributes = _loc4_.attributes;
               _loc5_.data = _loc4_.firstChild.nodeValue;
               if(position != undefined)
               {
                  _loc10_ = path;
               }
               if(path[_loc2_] != undefined)
               {
                  if(path[_loc2_].__proto__ == Array.prototype)
                  {
                     path[_loc2_].push(_loc5_);
                     name = _loc4_.nodeName;
                     position = path[_loc2_].length - 1;
                  }
                  else
                  {
                     var _loc8_ = path[_loc2_];
                     path[_loc2_] = new Array();
                     path[_loc2_].push(_loc8_);
                     path[_loc2_].push(_loc5_);
                     name = _loc2_;
                     position = path[_loc2_].length - 1;
                  }
               }
               else
               {
                  path[_loc2_] = _loc5_;
                  name = _loc2_;
                  position = undefined;
               }
            }
            if(_loc4_.hasChildNodes())
            {
               this.translateXML(_loc4_,path,name,position);
            }
         }
      }
      return this.oResult;
   }
}
