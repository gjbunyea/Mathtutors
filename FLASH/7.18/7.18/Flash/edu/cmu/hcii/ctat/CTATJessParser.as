class edu.cmu.hcii.ctat.CTATJessParser extends edu.cmu.hcii.ctat.CTATJessBase
{
   function CTATJessParser(a_string)
   {
      super();
      this.setClassType("CTATJessParser");
      this.debug("CTATJessParser ()");
      this.jessString = a_string;
      this.parse(a_string);
   }
   function generateStringArray(fragmented)
   {
      this.debug("generateStringArray ()");
      var _loc7_ = new Array();
      var _loc5_ = false;
      var _loc2_ = "";
      var _loc3_ = 0;
      while(_loc3_ < fragmented.length)
      {
         if(edu.cmu.hcii.ctat.CTATUtil.countQuotes(fragmented[_loc3_]) > 1)
         {
            var _loc6_ = edu.cmu.hcii.ctat.CTATUtil.removeAQuote(fragmented[_loc3_]);
            var _loc8_ = edu.cmu.hcii.ctat.CTATUtil.removeAQuote(_loc6_);
            _loc2_ = _loc2_ + edu.cmu.hcii.ctat.CTATUtil.removeAQuote(fragmented[_loc3_]);
            this.debug("Adding straightup string: " + _loc2_);
            _loc7_.push(edu.cmu.hcii.ctat.CTATUtil.stripWhiteSpace(_loc2_));
            _loc2_ = "";
         }
         else if(fragmented[_loc3_].indexOf("\"") != -1)
         {
            if(_loc5_ == false)
            {
               _loc5_ = true;
               _loc2_ = _loc2_ + edu.cmu.hcii.ctat.CTATUtil.removeAQuote(fragmented[_loc3_]);
               _loc2_ = _loc2_ + " ";
            }
            else
            {
               _loc5_ = false;
               _loc2_ = _loc2_ + edu.cmu.hcii.ctat.CTATUtil.removeAQuote(fragmented[_loc3_]);
               this.debug("Adding fixed string: " + _loc2_);
               _loc7_.push(edu.cmu.hcii.ctat.CTATUtil.stripWhiteSpace(_loc2_));
               _loc2_ = "";
            }
         }
         else if(_loc5_ == true)
         {
            _loc2_ = _loc2_ + fragmented[_loc3_];
            _loc2_ = _loc2_ + " ";
         }
         _loc3_ = _loc3_ + 1;
      }
      return _loc7_;
   }
   function stringToXML(jess_statement)
   {
      var _loc1_ = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
      var _loc2_ = undefined;
      var _loc6_ = false;
      var _loc5_ = false;
      var _loc3_ = "";
      var _loc7_ = [];
      var _loc4_ = 0;
      while(_loc4_ < jess_statement.length)
      {
         _loc2_ = jess_statement.charAt(_loc4_);
         switch(_loc2_)
         {
            case "(":
               if(_loc6_)
               {
                  _loc1_ = _loc1_ + _loc2_;
               }
               else
               {
                  _loc1_ = _loc1_ + "<";
                  _loc5_ = true;
                  _loc3_ = "";
               }
               break;
            case ")":
               if(_loc6_)
               {
                  _loc1_ = _loc1_ + _loc2_;
               }
               else
               {
                  _loc1_ = _loc1_ + ("</" + _loc7_.pop() + ">");
               }
               break;
            case "\"":
               _loc6_ = !_loc6_;
               _loc1_ = _loc1_ + _loc2_;
               break;
            case "<":
               _loc1_ = _loc1_ + "&lt;";
               break;
            case ">":
               _loc1_ = _loc1_ + "&gt;";
               break;
            case " ":
            case "\t":
            case "\n":
               if(_loc5_)
               {
                  if(_loc3_.length > 0)
                  {
                     _loc5_ = false;
                     _loc1_ = _loc1_ + ">";
                     _loc7_.push(_loc3_);
                     _loc3_ = "";
                  }
               }
               else
               {
                  _loc1_ = _loc1_ + " ";
               }
               break;
            default:
               _loc1_ = _loc1_ + _loc2_;
               if(_loc5_)
               {
                  _loc3_ = _loc3_ + _loc2_;
                  break;
               }
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc9_ = new XML(_loc1_);
      return _loc9_;
   }
   function parse(a_string)
   {
      this.debug("parse (" + a_string + ")");
      this.jessXML = this.stringToXML(a_string);
      var _loc4_ = 0;
      if(this.values == null)
      {
         this.values = new Array();
      }
      else
      {
         this.values = [];
      }
      var _loc5_ = a_string.split(" ");
      var _loc3_ = this.generateStringArray(_loc5_);
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         this.values[_loc4_] = _loc3_[_loc2_];
         _loc4_ = _loc4_ + 1;
         _loc2_ = _loc2_ + 1;
      }
   }
   function getValue(tag)
   {
      return this.findNode(this.jessXML,tag).firstChild.toString();
   }
   function findNode(node, tag)
   {
      if(node.nodeName == tag)
      {
         return node;
      }
      if(node.hasChildNodes())
      {
         var _loc3_ = undefined;
         var _loc2_ = node.firstChild;
         while(_loc2_ != null)
         {
            _loc3_ = this.findNode(_loc2_,tag);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
            _loc2_ = _loc2_.nextSibling;
         }
      }
      return null;
   }
   function getNode(tag)
   {
      return this.findNode(this.jessXML,tag);
   }
   function getValues()
   {
      var _loc2_ = this.getValue("value");
      _loc2_ = this.getValue("value");
      if(_loc2_ == undefined || _loc2_ == null)
      {
         _loc2_ = this.getValue("values");
      }
      this.debug("getValues " + _loc2_);
      _loc2_ = _loc2_.split("&quot;").join("\"");
      _loc2_ = _loc2_.split("&lt;").join("<");
      _loc2_ = _loc2_.split("&gt;").join(">");
      var _loc4_ = _loc2_.split(" ");
      var _loc3_ = this.generateStringArray(_loc4_);
      this.debug("getValues " + _loc3_);
      return _loc3_;
   }
}
