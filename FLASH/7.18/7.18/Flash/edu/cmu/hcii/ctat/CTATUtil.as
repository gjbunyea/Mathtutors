class edu.cmu.hcii.ctat.CTATUtil extends edu.cmu.hcii.ctat.CTATStringUtil
{
   var temper = new String();
   function CTATUtil()
   {
      super();
      this.setClassType("CTATUtil");
      this.debug("CTATUtil ()");
      String.prototype.replace = function(searchStr, replaceStr)
      {
         var _loc2_ = this.split(searchStr);
         return _loc2_.join(replaceStr);
      };
   }
   function objectToString(an_obj, s, t)
   {
      if(an_obj == undefined)
      {
         this.debug("Error: input object undefined for \'objectToString ()\'");
         return null;
      }
      if(t == undefined)
      {
         t = "\t";
      }
      else
      {
         t = t + "\t";
      }
      if(s == undefined)
      {
         s = "Object: {";
      }
      else
      {
         s = s + "{";
      }
      for(var _loc5_ in an_obj)
      {
         s = s + ("\n" + t);
         if(an_obj[_loc5_] instanceof Array)
         {
            s = s + (_loc5_ + ": [" + an_obj[_loc5_] + "]");
         }
         else if(typeof an_obj[_loc5_] == "function")
         {
            s = s + (_loc5_ + ": (function)");
         }
         else
         {
            s = s + (_loc5_ + ": " + an_obj[_loc5_]);
         }
      }
      return s + "\n" + t.slice(0,-1) + "}";
   }
   static function countQuotes(a_string)
   {
      var _loc1_ = a_string.split("\"").length;
      _loc1_ = _loc1_ - 1;
      if(_loc1_ < 0)
      {
         _loc1_ = 0;
      }
      return _loc1_;
   }
   static function fixURL(a_url)
   {
      return a_url;
   }
   static function equalsIgnoreCase(string1, string2)
   {
      if(string1.toLowerCase() == string2.toLowerCase())
      {
         return true;
      }
      return false;
   }
   static function isaNumber(sValue)
   {
      return true;
   }
   static function FormatTimeStamp(timeStamp)
   {
      var _loc1_ = "";
      var _loc8_ = timeStamp.getUTCFullYear();
      _loc1_ = _loc1_ + (_loc8_ + "/");
      var _loc3_ = timeStamp.getUTCMonth();
      _loc3_ = _loc3_ + 1;
      _loc1_ = _loc1_ + ((_loc3_ >= 10?_loc3_:"0" + _loc3_) + "/");
      var _loc4_ = timeStamp.getUTCDate();
      _loc1_ = _loc1_ + ((_loc4_ >= 10?_loc4_:"0" + _loc4_) + " ");
      var _loc7_ = timeStamp.getUTCHours();
      _loc1_ = _loc1_ + ((_loc7_ >= 10?_loc7_:"0" + _loc7_) + ":");
      var _loc5_ = timeStamp.getUTCMinutes();
      _loc1_ = _loc1_ + ((_loc5_ >= 10?_loc5_:"0" + _loc5_) + ":");
      var _loc6_ = timeStamp.getUTCSeconds();
      _loc1_ = _loc1_ + (_loc6_ >= 10?_loc6_:"0" + _loc6_);
      return _loc1_;
   }
   static function removeLevel(widgetString)
   {
      var _loc2_ = String(widgetString);
      var _loc1_ = _loc2_.indexOf("_level0.");
      if(_loc1_ != -1)
      {
         _loc1_ = _loc1_ + 8;
         _loc2_ = _loc2_.substring(_loc1_);
      }
      return _loc2_;
   }
   static function removeAQuote(str)
   {
      return str.split("\"").join("");
   }
   static function removeLeadSpace(widgetString)
   {
      return edu.cmu.hcii.ctat.CTATUtil.stripWhiteSpace(widgetString);
   }
   static function removeEndSpace(widgetString)
   {
      return edu.cmu.hcii.ctat.CTATUtil.stripWhiteSpace(widgetString);
   }
   static function stripWhiteSpace(str)
   {
      return str.split("\r").join("").split("\n").join("").split("\t").join("");
   }
   static function stripAllWhiteSpace(str)
   {
      return str.split("\r").join("").split("\n").join("").split("\t").join("").split(" ").join("");
   }
   static function convertApost(widgetString, recursionStep)
   {
      var _loc1_ = String(widgetString);
      var _loc3_ = undefined;
      var _loc2_ = _loc1_.indexOf(String.fromCharCode(39));
      if(recursionStep > 50)
      {
         return _loc1_;
      }
      if(_loc2_ == -1)
      {
         return _loc1_;
      }
      if(_loc2_ == 0)
      {
         _loc1_ = "&apos;" + _loc1_.substring(1);
         var _loc5_ = recursionStep + 1;
         _loc3_ = edu.cmu.hcii.ctat.CTATUtil.convertApost(_loc1_,_loc5_);
      }
      else if(_loc2_ > 0)
      {
         _loc1_ = _loc1_.substring(0,_loc2_) + "&apos;" + _loc1_.substring(_loc2_ + 1);
         _loc5_ = recursionStep + 1;
         _loc3_ = edu.cmu.hcii.ctat.CTATUtil.convertApost(_loc1_,_loc5_);
      }
      return _loc3_;
   }
   static function convertQuotes(widgetString, recursionStep)
   {
      var _loc1_ = String(widgetString);
      var _loc3_ = undefined;
      var _loc2_ = _loc1_.indexOf(String.fromCharCode(34));
      if(recursionStep > 50)
      {
         return _loc1_;
      }
      if(_loc2_ == -1)
      {
         return _loc1_;
      }
      if(_loc2_ == 0)
      {
         _loc1_ = "&quot;" + _loc1_.substring(1);
         var _loc5_ = recursionStep + 1;
         _loc3_ = edu.cmu.hcii.ctat.CTATUtil.convertQuotes(_loc1_,_loc5_);
      }
      else if(_loc2_ > 0)
      {
         _loc1_ = _loc1_.substring(0,_loc2_) + "&quot;" + _loc1_.substring(_loc2_ + 1);
         _loc5_ = recursionStep + 1;
         _loc3_ = edu.cmu.hcii.ctat.CTATUtil.convertQuotes(_loc1_,_loc5_);
      }
      return _loc3_;
   }
   static function escapeXML(xmlToEscape)
   {
      xmlToEscape = xmlToEscape.split("&amp;").join("&");
      xmlToEscape = xmlToEscape.split("&").join("&amp;");
      xmlToEscape = xmlToEscape.split("<").join("&lt;");
      xmlToEscape = xmlToEscape.split(">").join("&gt;");
      xmlToEscape = xmlToEscape.split("=").join("&#61;");
      return xmlToEscape;
   }
   static function escapeLoneXML(xmlToEscape)
   {
      xmlToEscape = xmlToEscape.split("< ").join("&lt; ");
      xmlToEscape = xmlToEscape.split("&amp; ").join("& ");
      xmlToEscape = xmlToEscape.split("& ").join("&amp; ");
      xmlToEscape = xmlToEscape.split("< ").join("&lt; ");
      xmlToEscape = xmlToEscape.split(" >").join(" &gt;");
      xmlToEscape = xmlToEscape.split(" = ").join("&#61;");
      return xmlToEscape;
   }
   static function unescapeXML(xmlToUnescape)
   {
      xmlToUnescape = xmlToUnescape.split("&amp;").join("&");
      xmlToUnescape = xmlToUnescape.split("&lt;").join("<");
      xmlToUnescape = xmlToUnescape.split("&gt;").join(">");
      xmlToUnescape = xmlToUnescape.split("&#61;").join("=");
      return xmlToUnescape;
   }
   static function checkValid(aVariable)
   {
      if(aVariable == null || aVariable == undefined || aVariable == "")
      {
         return false;
      }
      return true;
   }
   static function checkStringValid(aVariable)
   {
      return edu.cmu.hcii.ctat.CTATUtil.checkValid(aVariable);
   }
   static function checkStringValidAndNotNA(aVariable)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.checkValid(aVariable) == false || aVariable == "NA")
      {
         return false;
      }
      return true;
   }
   static function checkNumberValid(aVariable)
   {
      if(aVariable == null || aVariable == undefined)
      {
         return false;
      }
      return true;
   }
   static function checkBooleanValid(aVariable)
   {
      if(aVariable == true || aVariable == false)
      {
         return true;
      }
      return false;
   }
   static function caseInsIndexOf(string1, string2)
   {
      var _loc1_ = string1.toLowerCase();
      var _loc2_ = string2.toLowerCase();
      if(string1 == undefined || string2 == undefined)
      {
         return false;
      }
      if(_loc1_.indexOf(_loc2_) != -1)
      {
         return true;
      }
      return false;
   }
   static function stringToBoolean(theValue)
   {
      return edu.cmu.hcii.ctat.CTATUtil.convertStringToBoolean(theValue);
   }
   static function convertStringToBoolean(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"t"))
      {
         return true;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"f"))
      {
         return false;
      }
      return true;
   }
   static function convertStringToBooleanDefaultTrue(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"t"))
      {
         return true;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"f"))
      {
         return false;
      }
      return true;
   }
   static function convertStringToBooleanDefaultFalse(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"t"))
      {
         return true;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"f"))
      {
         return false;
      }
      return false;
   }
   static function convertStringToBooleanDefaultUndefined(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"t"))
      {
         return true;
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"f"))
      {
         return false;
      }
      return undefined;
   }
   static function convertStringBooleanErrors(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"t"))
      {
         return "true";
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"f"))
      {
         return "false";
      }
      return "true";
   }
   static function getMediaType(theValue)
   {
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"mp3"))
      {
         return "audio";
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"flv"))
      {
         return "video";
      }
      if(edu.cmu.hcii.ctat.CTATUtil.caseInsIndexOf(theValue,"jpg"))
      {
         return "image";
      }
      return "text";
   }
   static function randomizeStringArray(anArray)
   {
      var _loc1_ = anArray;
      var _loc6_ = undefined;
      var _loc5_ = _loc1_.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc5_)
      {
         var _loc4_ = Math.round(Math.random() * (_loc5_ - 1));
         var _loc3_ = Math.round(Math.random() * (_loc5_ - 1));
         _loc6_ = _loc1_[_loc4_];
         _loc1_[_loc4_] = _loc1_[_loc3_];
         _loc1_[_loc3_] = _loc6_;
         _loc2_ = _loc2_ + 1;
      }
      return _loc1_;
   }
   static function replaceSpacesWithUnderscores(theValue)
   {
      theValue = theValue.split(" ").join("_");
      return theValue;
   }
   static function replaceCommasWithUnderscores(theValue)
   {
      theValue = theValue.split(",").join("_");
      return theValue;
   }
   static function stripExtension(fileName)
   {
      var _loc2_ = undefined;
      if(fileName.substring(fileName.length - 4) == ".brd")
      {
         _loc2_ = fileName.length - 4;
      }
      else
      {
         _loc2_ = fileName.length;
      }
      return fileName.substring(fileName.lastIndexOf("/") + 1,_loc2_);
   }
   function strstr(_s, _k)
   {
      this.debug("strstr ()");
      var _loc2_ = _s.indexOf(_k);
      if(_loc2_ >= 0)
      {
         return _s.substr(_loc2_ + _k.length);
      }
      return false;
   }
   static function getTrueInstance(aWidget)
   {
      if(aWidget._name == "textbox")
      {
         return aWidget._parent;
      }
      return aWidget;
   }
   static function getTextBoxInstance(aWidget)
   {
      if((aWidget.commType == "textInput" || aWidget.commType == "textArea") && aWidget._name != "textbox")
      {
         return aWidget.textbox;
      }
      return aWidget;
   }
   static function inLivePreview()
   {
      var _loc1_ = new edu.cmu.hcii.ctat.CTATBase();
      return _loc1_.isLivePreview();
   }
   static function getTopLeftLocalToGlobal(theMC)
   {
      var _loc1_ = {x:theMC._x,y:theMC._y};
      theMC.localToGlobal(_loc1_);
      return _loc1_;
   }
   static function getBottomRightLocalToGlobal(theMC)
   {
      var _loc3_ = theMC._x + theMC._width;
      var _loc4_ = theMC._y + theMC._height;
      var _loc2_ = {x:_loc3_,y:_loc4_};
      theMC.localToGlobal(_loc2_);
      return _loc2_;
   }
   static function getTopLeftGlobalToLocal(theMC)
   {
      var _loc1_ = {x:theMC._x,y:theMC._y};
      theMC.globalToLocal(_loc1_);
      return _loc1_;
   }
   static function getBottomRightGlobalToLocal(theMC)
   {
      var _loc3_ = theMC._x + theMC._width;
      var _loc4_ = theMC._y + theMC._height;
      var _loc2_ = {x:_loc3_,y:_loc4_};
      theMC.globalToLocal(_loc2_);
      return _loc2_;
   }
   static function translateLocalCoordsAtoC(AParent, AItem, CParent)
   {
      var _loc1_ = {x:1,y:2};
      AParent.localToGlobal(_loc1_);
      CParent.globalToLocal(_loc1_);
      return _loc1_;
   }
   static function printArray(theArray, cSource)
   {
      var _loc1_ = 0;
      while(_loc1_ < theArray.length)
      {
         _loc1_ = _loc1_ + 1;
      }
   }
   static function getBRDPath(theValue)
   {
      return theValue.substring(0,theValue.lastIndexOf("/"));
   }
   function fixXML(theMsg)
   {
      this.temper = theMsg;
      while(this.temper.indexOf("\'") != -1)
      {
         this.temper = this.temper.split("\'").join("#");
      }
      while(this.temper.indexOf("#") != -1)
      {
         this.temper = this.temper.split("#").join("\\\\\'");
      }
      return this.temper;
   }
   function isMassProductionVariable(a_var)
   {
      if(a_var == null || a_var == undefined)
      {
         return false;
      }
      if(a_var.indexOf("%(") != -1 && a_var.indexOf(")%"))
      {
         return true;
      }
      return false;
   }
   function createAbsoluteURL(a_url)
   {
      this.debug("createAbsoluteURL (" + a_url + ")");
      if(a_url.indexOf("http://") != -1)
      {
         this.debug("We already have a full http indicator, returning as-is");
         return a_url;
      }
      if(a_url.indexOf("/") == 0)
      {
         this.debug("The url starts with a /, processing [" + _level0.curriculum_service_url + "]...");
         if(_level0.curriculum_service_url != undefined && _level0.curriculum_service_url != null)
         {
            if(_level0.curriculum_service_url.indexOf("http:") != -1)
            {
               var _loc5_ = new edu.cmu.hcii.ctat.CTATURL(_level0.curriculum_service_url);
               _loc5_.path = a_url;
               return _loc5_.toString();
            }
            this.debug("The curriculum service url does not start with an http marker, returning as-is");
            return a_url;
         }
         this.debug("We do not have a curriculum service url, returning as-is");
         return a_url;
      }
      var _loc4_ = "";
      if(_level0.student_interface != undefined && _level0.student_interface != null)
      {
         _loc4_ = edu.cmu.hcii.ctat.CTATStringUtil.beforeLast(_level0.student_interface,"/");
      }
      var _loc3_ = _loc4_ + "/" + a_url;
      if(_loc3_.indexOf("http://") == -1)
      {
         if(_loc3_.indexOf("/") != 0)
         {
            _loc3_ = "/" + _loc3_;
         }
      }
      return _loc3_;
   }
}
