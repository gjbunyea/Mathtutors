class edu.cmu.hcii.ctat.CTATJessProcessor extends edu.cmu.hcii.ctat.CTATJessBase
{
   function CTATJessProcessor()
   {
      super();
      this.setClassType("CTATJessProcessor");
      this.debug("CTATJessProcessor ()");
   }
   function process(widgetType, an_instance, values)
   {
      this.debug("process (" + widgetType + "," + an_instance + "," + values + ")");
      var vals = values.getValues();
      if(widgetType == "CommComboBox")
      {
         this.debug("Instantiating CommComboBox with commtype: " + eval(an_instance).commType);
         this.debug("Removing " + eval(an_instance).length + " instances");
         eval(an_instance).replace(vals);
         return undefined;
      }
      if(widgetType == "CommImage")
      {
         this.debug("Instantiating CommImage with commtype: " + eval(an_instance).commType);
         this.debug("Setting image url to: " + vals[0]);
         eval(an_instance).ImageURL = vals[0];
         return undefined;
      }
      if(widgetType == "CommVideoAudio")
      {
         this.debug("Instantiating CommVideoAudio with commtype: " + eval(an_instance).commType);
         this.debug("Setting video url to: " + vals[0]);
         eval(an_instance).streamMedia(vals[0]);
         return undefined;
      }
      if(widgetType == "CommNumberBar")
      {
         this.debug("Instantiating CommNumberBar with commtype: " + eval(an_instance).commType);
         this.debug("Setting numberbar display to: " + values[0]);
         eval(an_instance).Display = vals[0];
         eval(an_instance).parseValueParameters(values.getNode("NumberBar"));
         return undefined;
      }
      if(eval(an_instance).setValues != undefined)
      {
         this.debug("The selected component has a \'setValues\' method, calling ...");
         eval(an_instance).setValues(vals[0]);
      }
      else
      {
         this.debug("The selected component does not have a \'setValues\' method");
      }
   }
}
