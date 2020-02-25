class edu.cmu.hcii.ctat.CTATHTMLManager extends edu.cmu.hcii.ctat.CTATStringUtil
{
   var aryEntities = null;
   var temper = new String();
   var singleQuoteEscape = true;
   var maxEntities = 50;
   function CTATHTMLManager()
   {
      super();
      this.setClassType("CTATHTMLManager");
      this.debug("CTATHTMLManager ()");
   }
   function showEntities()
   {
      this.debug("showEntities ()");
      for(var _loc2_ in this.aryEntities)
      {
         this.debug(_loc2_);
      }
   }
   function initEntities()
   {
      if(this.aryEntities == null)
      {
         this.aryEntities = new Array();
         this.aryEntities["&amp;"] = "*!*";
         this.aryEntities["&nbsp;"] = " ";
         this.aryEntities["&iexcl;"] = "¡";
         this.aryEntities["&cent;"] = "¢";
         this.aryEntities["&pound;"] = "£";
         this.aryEntities["&curren;"] = "¤";
         this.aryEntities["&yen;"] = "¥";
         this.aryEntities["&brvbar;"] = "¦";
         this.aryEntities["&sect;"] = "§";
         this.aryEntities["&uml;"] = "¨";
         this.aryEntities["&copy;"] = "©";
         this.aryEntities["&reg;"] = "®";
         this.aryEntities["&deg;"] = "°";
         this.aryEntities["&plusmn;"] = "±";
         this.aryEntities["&sup1;"] = "¹";
         this.aryEntities["&sup2;"] = "²";
         this.aryEntities["&sup3;"] = "³";
         this.aryEntities["&acute;"] = "´";
         this.aryEntities["&micro;"] = "µ";
         this.aryEntities["&frac14;"] = "¼";
         this.aryEntities["&frac12;"] = "½";
         this.aryEntities["&frac34;"] = "¾";
         this.aryEntities["&iquest;"] = "¿";
         this.aryEntities["&Agrave;"] = "À";
         this.aryEntities["&Aacute;"] = "Á";
         this.aryEntities["&Acirc;"] = "Â";
         this.aryEntities["&Atilde;"] = "Ã";
         this.aryEntities["&Auml;"] = "Ä";
         this.aryEntities["&Aring;"] = "Å";
         this.aryEntities["&AElig;"] = "Æ";
         this.aryEntities["&Ccedil;"] = "Ç";
         this.aryEntities["&Egrave;"] = "È";
         this.aryEntities["&Eacute;"] = "É";
         this.aryEntities["&Ecirc;"] = "Ê";
         this.aryEntities["&Euml;"] = "Ë";
         this.aryEntities["&Igrave;"] = "Ì";
         this.aryEntities["&Iacute;"] = "Í";
         this.aryEntities["&Icirc;"] = "Î";
         this.aryEntities["&Iuml;"] = "Ï";
         this.aryEntities["&ETH;"] = "Ð";
         this.aryEntities["&Ntilde;"] = "Ñ";
         this.aryEntities["&Ograve;"] = "Ò";
         this.aryEntities["&Oacute;"] = "Ó";
         this.aryEntities["&Ocirc;"] = "Ô";
         this.aryEntities["&Otilde;"] = "Õ";
         this.aryEntities["&Ouml;"] = "Ö";
         this.aryEntities["&Oslash;"] = "Ø";
         this.aryEntities["&Ugrave;"] = "Ù";
         this.aryEntities["&Uacute;"] = "Ú";
         this.aryEntities["&Ucirc;"] = "Û";
         this.aryEntities["&Uuml;"] = "Ü";
         this.aryEntities["&Yacute;"] = "Ý";
         this.aryEntities["&THORN;"] = "Þ";
         this.aryEntities["&szlig;"] = "ß";
         this.aryEntities["&agrave;"] = "à";
         this.aryEntities["&aacute;"] = "á";
         this.aryEntities["&acirc;"] = "â";
         this.aryEntities["&atilde;"] = "ã";
         this.aryEntities["&auml;"] = "ä";
         this.aryEntities["&aring;"] = "å";
         this.aryEntities["&aelig;"] = "æ";
         this.aryEntities["&ccedil;"] = "ç";
         this.aryEntities["&egrave;"] = "è";
         this.aryEntities["&eacute;"] = "é";
         this.aryEntities["&ecirc;"] = "ê";
         this.aryEntities["&euml;"] = "ë";
         this.aryEntities["&igrave;"] = "ì";
         this.aryEntities["&iacute;"] = "í";
         this.aryEntities["&icirc;"] = "î";
         this.aryEntities["&iuml;"] = "ï";
         this.aryEntities["&eth;"] = "ð";
         this.aryEntities["&ntilde;"] = "ñ";
         this.aryEntities["&ograve;"] = "ò";
         this.aryEntities["&oacute;"] = "ó";
         this.aryEntities["&ocirc;"] = "ô";
         this.aryEntities["&otilde;"] = "õ";
         this.aryEntities["&ouml;"] = "ö";
         this.aryEntities["&oslash;"] = "ø";
         this.aryEntities["&ugrave;"] = "ù";
         this.aryEntities["&uacute;"] = "ú";
         this.aryEntities["&ucirc;"] = "û";
         this.aryEntities["&uuml;"] = "ü";
         this.aryEntities["&yacute;"] = "ý";
         this.aryEntities["&thorn;"] = "þ";
         this.aryEntities["&yuml;"] = "ÿ";
         this.aryEntities["&gt;"] = ">";
         this.aryEntities["&lt;"] = "<";
         this.aryEntities["&#61;"] = "=";
         this.aryEntities["&361;"] = "=";
         this.aryEntities["&quot;"] = "\"";
      }
      if(this.singleQuoteEscape == true)
      {
         this.debug("(singleQuoteEscape==true) Replacing &apos; with: \\\'");
         this.aryEntities["&apos;"] = "\\\'";
      }
      else
      {
         this.debug("(singleQuoteEscape==false) Replacing &apos; with: \'");
         this.aryEntities["&apos;"] = "\'";
      }
   }
   function entitiesConvert(str)
   {
      this.debug("entitiesConvert ()");
      this.initEntities();
      if(str == "&")
      {
         this.temper = "&amp;";
         return this.temper;
      }
      this.temper = str;
      this.debug("Making the string javascript safe ...");
      while(this.temper.indexOf("\'") != -1)
      {
         this.temper = this.replace(this.temper,"\'","&apos;");
         this.debug("Cleaner: " + this.temper);
      }
      this.debug("Javascript safe: " + this.temper);
      this.debug("First pass replacing ...");
      var _loc2_ = false;
      var _loc3_ = false;
      var _loc4_ = 0;
      while(this.temper.indexOf("&") != -1 && _loc3_ == false)
      {
         _loc2_ = false;
         for(var _loc5_ in this.aryEntities)
         {
            this.temper = this.replace(this.temper,_loc5_,this.aryEntities[_loc5_]);
            _loc2_ = true;
         }
         if(_loc2_ == false)
         {
            this.debug("Error: unknown code found!");
            _loc3_ = true;
            return this.temper;
         }
         _loc4_ = _loc4_ + 1;
         if(_loc4_ > this.maxEntities)
         {
            this.debug("Possible endless loop detected, aborting");
            _loc3_ = true;
         }
      }
      this.debug("Intermediate result: " + this.temper);
      this.debug("Final pass replacing ...");
      while(this.temper.indexOf("*!*") != -1)
      {
         this.temper = this.replace(this.temper,"*!*","&");
      }
      return this.temper;
   }
   function entitiesGenerate(str)
   {
      this.temper = str;
      return this.temper;
   }
}
