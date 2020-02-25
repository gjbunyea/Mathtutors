class edu.cmu.hcii.ctat.CTATLinkData extends edu.cmu.hcii.ctat.CTATBase
{
   var serviceInfo = null;
   function CTATLinkData()
   {
      super();
      this.setClassType("CTATLinkData");
      this.debug("CTATLinkData ()");
      this.serviceInfo = new edu.cmu.hcii.ctat.CTATTutorServiceBase();
      _global.linkData = this;
   }
}
