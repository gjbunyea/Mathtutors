class edu.cmu.hcii.ctat.CTATLabeledComponent extends edu.cmu.hcii.ctat.CTATImageBasedComponent
{
   static var symbolName = "CTATLabeledComponent";
   static var symbolOwner = edu.cmu.hcii.ctat.CTATLabeledComponent;
   var className = "CTATLabeledComponent";
   var ParentClassName = "CTATImageBasedComponent";
   var buttonLabel = null;
   static var LABEL = "Label";
   var sgText = edu.cmu.hcii.ctat.CTATLabeledComponent.LABEL;
   var labelDepth = -1;
   var sgWordWrap = false;
   var textCheck = edu.cmu.hcii.ctat.CTATLabeledComponent.LABEL;
   var useLabel = true;
   var labels = null;
   var label_fmt = null;
   var sgCentered = true;
   var sgRollOverHighlight = true;
   var sgShowLabelBorder = false;
   function CTATLabeledComponent()
   {
      super();
   }
   function setUseLabel(a_val)
   {
      this.useLabel = a_val;
      if(this.buttonLabel != null)
      {
         this.removeLabel(this.buttonLabel);
      }
   }
   function getUseLabel()
   {
      return this.useLabel;
   }
   function setCentered(a_val)
   {
      this.sgCentered = a_val;
   }
   function getCentered()
   {
      return this.sgCentered;
   }
   function setText(a_label)
   {
      this.debug("setText (" + a_label + ")");
      this.sgText = a_label;
      this.setLabelProps();
   }
   function getText()
   {
      return this.sgText;
   }
   function init()
   {
      super.init();
      this.debug("init");
      this.labels = new Array();
   }
   function createChildren()
   {
      super.createChildren();
      this.debug("createChildren ()");
   }
   function componentInit()
   {
      this.debug("componentInit ()");
      this.setLabelProps();
   }
   function setLabelProps()
   {
      this.debug("setLabelProps (" + this._name + ")");
      if(this.useLabel == false)
      {
         this.debug("We\'re not using labels in this component, aborting text formatting");
         return undefined;
      }
      if(this.buttonLabel != null)
      {
         this.buttonLabel.removeTextField();
         this.buttonLabel = null;
      }
      this.createLabel();
      if(this.buttonLabel == null)
      {
         this.debug("Error: no button label available");
         return undefined;
      }
      this.label_fmt = new TextFormat();
      this.debug("Setting label font to: " + this.sgFontColor + "," + this.sgFontName + "," + this.sgFontSize + "," + this.sgFontBold + "," + this.sgFontItalic + "," + this.sgFontUnderline);
      if(this.tutoringState == "Neutral")
      {
         this.debug("Setting button label to the default color");
         this.label_fmt.color = this.sgFontColor;
      }
      else if(this.tutoringState == "Correct")
      {
         this.debug("Setting button label to the \'Correct\' color");
         this.label_fmt.color = 65280;
      }
      else
      {
         this.debug("Setting button label to the \'Incorrect\' color");
         this.label_fmt.color = 16711680;
      }
      this.label_fmt.font = this.sgFontName;
      this.label_fmt.size = this.sgFontSize;
      this.label_fmt.bold = this.sgFontBold;
      this.label_fmt.italic = this.sgFontItalic;
      this.label_fmt.underline = this.sgFontUnderline;
      this.buttonLabel.setTextFormat(this.label_fmt);
      this.fit();
   }
   function createLabel()
   {
      this.labelDepth = this.getNextHighestDepth();
      this.debug("createLabel (" + this.labelDepth + ")");
      if(this.useLabel == false)
      {
         return undefined;
      }
      this.buttonLabel = this.target.createTextField(this.createInstanceName(),this.labelDepth,2,2,this.wFixed - 4,this.hFixed - 4);
      if(this.buttonLabel != null)
      {
         if(this.sgCentered == true)
         {
            this.buttonLabel.autoSize = "centered";
         }
         else
         {
            this.buttonLabel.autoSize = false;
         }
         this.buttonLabel.text = this.sgText;
         this.buttonLabel.selectable = false;
         this.buttonLabel.hitArea = this.target;
         this.buttonLabel.border = this.sgShowLabelBorder;
         this.buttonLabel.wordWrap = this.sgWordWrap;
         this.buttonLabel.multiline = false;
      }
      else
      {
         this.debug("Unable to instantiate text field");
      }
   }
   function createNewLabel()
   {
      this.labelDepth = this.getNextHighestDepth();
      var _loc2_ = this.target.createTextField(this.createInstanceName(),this.labelDepth,2,2,this.wFixed - 4,this.hFixed - 4);
      if(_loc2_ != null)
      {
         if(this.sgCentered == true)
         {
            _loc2_.autoSize = "centered";
         }
         else
         {
            _loc2_.autoSize = false;
         }
         _loc2_.text = "";
         _loc2_.selectable = false;
         _loc2_.hitArea = this.target;
      }
      return _loc2_;
   }
   function createNewLabelParams(a_root, labelDepth, a_x, a_y, a_width, a_height)
   {
      this.debug("createNewLabelParams ()");
      if(a_root == null)
      {
         this.debug("Internal error: no movieclip pointer available to create textfield on");
         return null;
      }
      labelDepth = this.getNextHighestDepth();
      var _loc2_ = a_root.createTextField(this.createInstanceName(),labelDepth,a_x,a_y,a_width,a_height);
      if(_loc2_ != null)
      {
         if(this.sgCentered == true)
         {
            _loc2_.autoSize = "centered";
         }
         else
         {
            _loc2_.autoSize = false;
         }
         _loc2_.text = "";
         _loc2_.align = "center";
         _loc2_.selectable = false;
         _loc2_.hitArea = this.target;
      }
      else
      {
         this.debug("Unable to create new label");
      }
      return _loc2_;
   }
   function removeLabel(a_label)
   {
      if(a_label != null && a_label != undefined)
      {
         a_label.removeTextField();
      }
   }
   function clearDynamicLabels()
   {
      var _loc2_ = 0;
      while(_loc2_ < this.labels.length)
      {
         this.removeLabel(this.labels[_loc2_]);
         _loc2_ = _loc2_ + 1;
      }
      this.labels = new Array();
   }
   function draw()
   {
      super.draw();
   }
   function size()
   {
      super.size();
      this.fit();
   }
   function fit()
   {
      this.debug("fit (" + this._name + ")");
      if(this.useLabel == false)
      {
         return undefined;
      }
      if(this.buttonLabel != null)
      {
         var _loc3_ = this.wFixed;
         var _loc2_ = this.hFixed;
         var _loc5_ = this.buttonLabel.textWidth;
         var _loc4_ = this.buttonLabel.textHeight;
         _loc3_ = this.wFixed;
         _loc2_ = this.hFixed;
         _loc5_ = this.buttonLabel.textWidth;
         _loc4_ = this.buttonLabel.textHeight;
         if(this.sgCentered == true)
         {
            this.buttonLabel._x = _loc3_ / 2 - _loc5_ / 2;
            this.buttonLabel._y = _loc2_ / 2 - _loc4_ / 2 - 2;
         }
      }
   }
}
