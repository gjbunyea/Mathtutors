class edu.cmu.hcii.ctat.CTATConnectionProxy extends edu.cmu.hcii.ctat.CTATBase
{
   var shellinfo = new Array();
   var shelldata = new Array();
   var loggingdata = new Array();
   var tutorinfo = new Array();
   var flashvars = new Array();
   var envvars = new Array();
   var globals = new Array();
   var serviceinfo = new Array();
   var performanceString = "";
   function CTATConnectionProxy()
   {
      super();
      this.setClassType("CTATConnectionProxy");
      this.debug("CTATConnectionProxy ()");
   }
   function SafeGetURL(a_url, a_target, a_method)
   {
      this.debug("SafeGetURL (" + a_url + "," + a_target + "," + a_method + ")");
      this.loader_mc = _root.createEmptyMovieClip("loader_mc",_root.getNextHighestDepth());
      this.loader_mc.shellinfo = new Array();
      this.loader_mc.shelldata = new Array();
      this.loader_mc.loggingdata = new Array();
      this.loader_mc.tutorinfo = new Array();
      this.loader_mc.flashvars = new Array();
      this.loader_mc.envvars = new Array();
      this.loader_mc.globals = new Array();
      this.loader_mc.serviceinfo = new Array();
      var _loc3_ = 0;
      _loc3_ = 0;
      while(_loc3_ < this.shellinfo.length)
      {
         this.loader_mc.shellinfo.push(this.shellinfo[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < this.shelldata.length)
      {
         this.loader_mc.shelldata.push(this.shelldata[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < this.loggingdata.length)
      {
         this.loader_mc.loggingdata.push(this.loggingdata[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < this.flashvars.length)
      {
         this.loader_mc.flashvars.push(this.flashvars[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < this.tutorinfo.length)
      {
         this.loader_mc.tutorinfo.push(this.tutorinfo[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < this.envvars.length)
      {
         this.loader_mc.envvars.push(this.envvars[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < this.globals.length)
      {
         this.loader_mc.globals.push(this.globals[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < this.serviceinfo.length)
      {
         this.loader_mc.serviceinfo.push(this.serviceinfo[_loc3_]);
         _loc3_ = _loc3_ + 1;
      }
      this.loader_mc.performanceString = this.performanceString;
      this.loader_mc.getURL(a_url,a_target,a_method);
   }
   function SafeURLPOST(a_url, a_text)
   {
      this.debug("SafeGetURLAnonymous (" + a_url + "," + a_text + ")");
      var _loc2_ = new LoadVars();
      var _loc3_ = new LoadVars();
      _loc2_.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.getResults);
      _loc2_.text = a_text;
      _loc2_.sendAndLoad(a_url,_loc3_,"POST");
   }
   function getResults()
   {
      this.debug("getResults ()");
   }
}
