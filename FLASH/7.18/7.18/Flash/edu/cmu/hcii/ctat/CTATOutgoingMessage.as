class edu.cmu.hcii.ctat.CTATOutgoingMessage extends edu.cmu.hcii.ctat.CTATBase
{
   var url = "http://127.0.0.1";
   var data = "unassigned";
   var xmlobj = null;
   var sent = false;
   var receiveXMLContent = null;
   function CTATOutgoingMessage()
   {
      super();
      this.setClassType("CTATOutgoingMessage");
      this.debug("CTATOutgoingMessage ()");
   }
}
