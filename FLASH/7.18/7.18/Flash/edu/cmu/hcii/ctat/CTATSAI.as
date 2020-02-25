class edu.cmu.hcii.ctat.CTATSAI extends edu.cmu.hcii.ctat.CTATBase
{
   var selection = "undefined";
   var action = "undefined";
   var input = "undefined";
   var transaction = "undefined";
   var prompt = "undefined";
   var selObject = null;
   function CTATSAI(a_val)
   {
      super();
      this.setClassType("CTATSAI");
      this.debug("CTATSAI ()");
   }
   function debugValues()
   {
      this.debug("debugValues ()");
      this.debug("selection: " + this.selection);
      this.debug("action: " + this.action);
      this.debug("input: " + this.input);
      this.debug("transaction: " + this.transaction);
      this.debug("prompt: " + this.prompt);
      this.debug("Component instance type: " + this.selObject.commType);
   }
   function parseSAI(xmlChildren)
   {
      this.debug("parseSAI ()");
      var t = 0;
      while(t < xmlChildren.length)
      {
         this.debug("Examining node: " + xmlChildren[t].nodeName);
         if(xmlChildren[t].nodeName == "Selection" || xmlChildren[t].nodeName == "selection")
         {
            var val = xmlChildren[t].firstChild;
            if(val.nodeName == "value")
            {
               this.selection = val.firstChild.nodeValue;
               this.selObject = eval(val.firstChild.nodeValue);
            }
            else
            {
               this.selection = val.nodeValue;
            }
         }
         else if(xmlChildren[t].nodeName == "Action" || xmlChildren[t].nodeName == "action")
         {
            var val = xmlChildren[t].firstChild;
            if(val.nodeName == "value")
            {
               this.action = val.firstChild.nodeValue;
            }
            else
            {
               this.action = val.nodeValue;
            }
         }
         else if(xmlChildren[t].nodeName == "Input" || xmlChildren[t].nodeName == "input")
         {
            var finalNodes = xmlChildren[t].childNodes;
            this.input = "";
            var w = 0;
            while(w < finalNodes.length)
            {
               if(w > 0)
               {
                  this.input = this.input + ",";
               }
               var val = finalNodes[w].firstChild;
               this.input = this.input + val.nodeValue;
               w++;
            }
         }
         else if(xmlChildren[t].nodeName == "transaction_id")
         {
            this.transaction = xmlChildren[t].firstChild.nodeValue;
         }
         else if(xmlChildren[t].nodeName == "prompt")
         {
            this.prompt = xmlChildren[t].firstChild.nodeValue;
         }
         t++;
      }
      this.debugValues();
   }
}
