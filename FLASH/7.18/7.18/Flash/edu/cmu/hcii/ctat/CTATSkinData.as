class edu.cmu.hcii.ctat.CTATSkinData extends edu.cmu.hcii.ctat.CTATBase
{
   var skins = null;
   var xmlLoader = null;
   function CTATSkinData()
   {
      super();
      this.setClassType("CTATSkinData");
      this.debug("CTATSkinData ()");
      this.skins = new Array();
      this.xmlLoader = new XML();
      this.xmlLoader.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.skinDataLoaded);
   }
   function getSkins()
   {
      return this.skins;
   }
   function loadSkinData(a_url)
   {
      this.debug("loadSkinData (" + a_url + ")");
      this.xmlLoader.load(a_url);
   }
   function skinDataLoaded()
   {
      this.debug("skinDataLoaded ()");
      this.processSkins(this.xmlLoader);
   }
   function fromXML(a_string)
   {
      this.debug("fromXML (" + a_string + ")");
      var _loc2_ = new XML();
      _loc2_.parseXML(a_string);
      var _loc3_ = _loc2_;
   }
   function processSkins(a_root)
   {
      this.debug("processSkins (" + a_root.toString() + ")");
      this.skins = new Array();
      this.debug("Looking for skin info ...");
      this.debug("fromXML (" + a_root.toString() + ")");
      return this.skins;
   }
}
