class edu.cmu.hcii.ctat.CTATSkill extends edu.cmu.hcii.ctat.CTATBase
{
   var level = 0;
   var name = "undefined";
   var label = "undefined";
   var description = "undefined";
   var category = "undefined";
   var texted = false;
   var textfield = null;
   var touched = false;
   function CTATSkill()
   {
      super();
      this.setClassType("CTATSkill");
      this.debug("CTATSkill ()");
   }
}
