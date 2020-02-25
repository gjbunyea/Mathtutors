class edu.cmu.hcii.ctat.CTATJsProxy extends edu.cmu.hcii.ctat.CTATBase
{
   var proxy = null;
   var proxyTutor = false;
   var tools = null;
   function CTATJsProxy()
   {
      super();
      this.setClassType("CTATJsProxy");
      this.debug("CTATJsProxy ()");
      this.debug("Javascript Proxy: " + _root.lcId);
      this.tools = new edu.cmu.hcii.ctat.CTATUtil();
      if(_root.lcId != undefined)
      {
         if(_root.lcId != null)
         {
            this.debug("Creating Javascript Proxy ...");
            this.proxy = new com.macromedia.javascript.JavaScriptProxy(_root.lcId,this);
            this.jsMessage(_level0.info);
            if(_root.useJsTutorService != undefined)
            {
               if(_root.useJsTutorService != null)
               {
                  this.proxyTutor = true;
               }
            }
         }
         else
         {
            this.debug("No indication found that we have a proxy, disabling javascript logging support");
         }
      }
      else
      {
         this.debug("No indication found that we have a proxy, disabling javascript logging support");
      }
   }
   function jsDataShopLog(a_string)
   {
      return undefined;
   }
   function jsTrace(a_string)
   {
      return undefined;
   }
   function jsMessage(a_string)
   {
      this.debug("jsMessage () - external interface");
      if(this.proxy != null)
      {
         var _loc2_ = new edu.cmu.hcii.ctat.CTATHTMLManager();
         flash.external.ExternalInterface.call("javaScriptInfo(\'" + _loc2_.entitiesConvert(a_string) + "\')");
      }
   }
   function callJsTutorService(an_xml_string)
   {
      this.debug("callJsTutorService ()");
   }
   function processJsTutorService(an_xml_string)
   {
      this.debug("processJsTutorService ()");
   }
}
