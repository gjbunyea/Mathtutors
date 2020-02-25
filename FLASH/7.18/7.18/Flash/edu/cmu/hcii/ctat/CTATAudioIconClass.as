class edu.cmu.hcii.ctat.CTATAudioIconClass extends edu.cmu.hcii.ctat.CTATMovieClipBase
{
   static var version = "2.3.1";
   var publicVersion = "2.3.1";
   var label = "";
   var audioLoaded = false;
   var audioPlaying = false;
   function CTATAudioIconClass()
   {
      super();
      this.setClassType("CTATAudioIconClass");
      this.debug("CTATAudioIconClass ()");
      this.internalInit();
   }
   function getClassVersion()
   {
      return this.publicVersion;
   }
   function getAudioFileName()
   {
      return this._audioFileName;
   }
   function setAudioFileName(value)
   {
      this._audioFileName = value;
   }
   function internalInit()
   {
      this.debug("internalInit ()");
      mx.events.EventDispatcher.initialize(this);
      this.hideIcons();
      this.audioIcon_Stop._visible = true;
      this.my_sound = new Sound();
      this.onRelease = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.playSound);
      this.my_sound.onLoad = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.onLoadHander);
      this.my_sound.onSoundComplete = com.dynamicflash.utils.DelegateSource.Delegate.create(this,this.handleSoundComplete);
   }
   function handleSoundComplete(target)
   {
      this.debug("handleSoundComplete ()");
      this.setAudioPlaying(false);
      this.dispatchEvent({type:"endSound",AudioFileName:this.getFileName(this.getAudioFileName()()),duration:String(this.my_sound.duration / 1000),position:String(this.my_sound.position / 1000),target:this});
      _global.theShell.getLogClassReference().logAudioEnd(this,this.getFileName(this.getAudioFileName()),String(this.my_sound.duration / 1000),String(this.my_sound.position / 1000),"End of the audio file.");
   }
   function onLoadHander(success)
   {
      this.debug("onLoadHander ()");
      if(success)
      {
         this.my_sound.start();
      }
      else
      {
         this.debug("EXCEPTION : AudioIconClass : sound file failed to load");
      }
   }
   function logStop()
   {
      this.debug("logStop ()");
      _global.theShell.getLogClassReference().logAudioStop(this,this.getFileName(this.getAudioFileName()),String(this.my_sound.duration / 1000),String(this.my_sound.position / 1000),"Stop the audio file.");
   }
   function logPlay()
   {
      this.debug("logPlay ()");
      _global.theShell.getLogClassReference().logAudioPlay(this,this.getFileName(this.getAudioFileName()),String(this.my_sound.duration / 1000),String(this.my_sound.position / 1000),"Play the audio file.");
   }
   function getFileName(theFilePath)
   {
      this.debug("getFileName ()");
      var _loc3_ = theFilePath.lastIndexOf("/");
      var _loc2_ = theFilePath.substr(_loc3_ + 1);
      return _loc2_;
   }
   function playNewSound(theFile)
   {
      this.debug("playNewSound ()");
      this.audioLoaded = false;
      this.setAudioFileName(theFile);
      this.debug("AudioIconClass : playNewSound  audioLoaded = " + this.audioLoaded + " theFile = " + theFile + " AudioFileName = " + this.getAudioFileName());
      this.playSound();
   }
   function playSound()
   {
      this.debug("playSound ()");
      this.debug("audioLoaded = " + this.audioLoaded + " AudioFileName = " + this.getAudioFileName());
      if(this.audioLoaded == false)
      {
         this.debug("AudioIconClass : playSound : 1 : play subsequent : getAudioPlaying = " + this.getAudioPlaying());
         this.audioLoaded = true;
         this.setAudioPlaying(true);
         this.my_sound.loadSound(this.getAudioFileName(),false);
      }
      else if(this.getAudioPlaying() == false)
      {
         this.debug("AudioIconClass : playSound : 2 : play subsequent : getAudioPlaying = " + this.getAudioPlaying());
         this.setAudioPlaying(true);
         this.my_sound.start();
         this.dispatchEvent({type:"playSound",AudioFileName:this.getFileName(this.getAudioFileName()),duration:String(this.my_sound.duration / 1000),position:String(this.my_sound.position / 1000),target:this});
         this.logPlay();
      }
      else if(this.getAudioPlaying() == true)
      {
         this.debug("AudioIconClass : playSound : 3 : stop the sound : getAudioPlaying = " + this.getAudioPlaying());
         this.stopSound();
      }
   }
   function stopSound()
   {
      this.debug("stopSound ()");
      this.debug("Stop the sound if audio playing (true) : getAudioPlaying = " + this.getAudioPlaying());
      if(this.getAudioPlaying() == true)
      {
         this.setAudioPlaying(false);
         this.my_sound.stop();
         this.dispatchEvent({type:"stopSound",AudioFileName:this.getFileName(this.getAudioFileName()),duration:String(this.my_sound.duration / 1000),position:String(this.my_sound.position / 1000),target:this});
         this.logStop();
      }
   }
   function getPlayStopStatus()
   {
      this.debug("getPlayStopStatus ()");
      if(this.getAudioPlaying() == true)
      {
         this.playStopStatus = this.getAudioFileName() + " Audio Stopped.";
         return this.playStopStatus;
      }
      if(this.getAudioPlaying() == false)
      {
         this.playStopStatus = this.getAudioFileName() + " Audio Playing.";
         return this.playStopStatus;
      }
   }
   function setAudioPlaying(status)
   {
      this.debug("setAudioPlaying (" + status + ")");
      if(status != undefined)
      {
         this.audioPlaying = status;
         this.assignIcon(this.audioPlaying);
      }
      else
      {
         this.audioPlaying = !this.getAudioPlaying();
         this.assignIcon(this.audioPlaying);
      }
   }
   function getAudioPlaying()
   {
      this.debug("getAudioPlaying ()");
      return this.audioPlaying;
   }
   function assignIcon(audioPlaying)
   {
      this.debug("assignIcon ()");
      var _loc2_ = undefined;
      audioPlaying != true?_loc2_ = this.audioIcon_Stop:_loc2_ = this.audioIcon_Play;
      this.hideIcons();
      _loc2_._visible = true;
   }
   function hideIcons()
   {
      this.debug("hideIcons ()");
      this.audioIcon_Play._visible = false;
      this.audioIcon_Stop._visible = false;
   }
}
