class mx.controls.alertClasses.AlertForm extends mx.core.UIComponent
{
   static var symbolOwner = mx.core.UIComponent;
   var idNames = ["text_mc","icon_mc"];
   var defButtonName = undefined;
   function AlertForm()
   {
      super();
   }
   function init(Void)
   {
      super.init();
   }
   function setDefaultButton()
   {
      this._parent.focusManager.defaultPushButton = this[this.defButtonName];
   }
   function createChildren(Void)
   {
      this.tabChildren = true;
      this.tabEnabled = false;
      if(this.text_mc == undefined)
      {
         this.createClassObject(mx.controls.TextArea,"text_mc",0,{styleName:this,borderStyle:"none",readOnly:true});
      }
      this.text_mc.tabEnabled = false;
      this.text_mc.tabChildren = false;
      this.text_mc.hScrollPolicy = "off";
      this.text_mc.vScrollPolicy = "off";
      this.text_mc.label.selectable = false;
      if(this.textMeasure_mc == undefined)
      {
         this.createTextField("textMeasure_mc",-1,0,0,0,0);
      }
      this.textMeasure_mc._visible = false;
      this.textMeasure_mc.multiline = true;
      this.textMeasure_mc.wordWrap = true;
      this.textMeasure_mc.autoSize = "left";
      if(this.icon_mc == undefined && this._parent.icon != undefined)
      {
         this.setSkin(1,this._parent.icon);
      }
      this.buttons = new Array();
      var _loc2_ = this._parent.defButton;
      if(this._parent.okButton)
      {
         this.createButton("okButton",mx.controls.Alert.okLabel,mx.controls.Alert.OK);
         if(_loc2_ == mx.controls.Alert.OK)
         {
            this.defButtonName = "okButton";
         }
      }
      if(this._parent.yesButton)
      {
         this.createButton("yesButton",mx.controls.Alert.yesLabel,mx.controls.Alert.YES);
         if(_loc2_ == mx.controls.Alert.YES)
         {
            this.defButtonName = "yesButton";
         }
      }
      if(this._parent.noButton)
      {
         this.createButton("noButton",mx.controls.Alert.noLabel,mx.controls.Alert.NO);
         if(_loc2_ == mx.controls.Alert.NO)
         {
            this.defButtonName = "noButton";
         }
      }
      if(this._parent.cancelButton)
      {
         this.createButton("cancelButton",mx.controls.Alert.cancelLabel,mx.controls.Alert.CANCEL);
         if(_loc2_ == mx.controls.Alert.CANCEL)
         {
            this.defButtonName = "cancelButton";
         }
      }
      if(this.defButtonName != undefined)
      {
         this[this.defButtonName].emphasized = true;
         this[this.defButtonName].redraw(true);
         this.doLater(this,"setDefaultButton");
      }
   }
   function createButton(name, title, detail)
   {
      var _loc3_ = mx.controls.Alert.buttonStyleDeclaration;
      var _loc2_ = (mx.controls.Button)this.createClassChildAtDepth(mx.controls.Button,mx.managers.DepthManager.kTop,{falseUpSkin:mx.controls.Alert.buttonUp,falseDownSkin:mx.controls.Alert.buttonDown,falseOverSkin:mx.controls.Alert.buttonOver,falseOverSkinEmphasized:mx.controls.Alert.buttonOverEmphasized,falseUpSkinEmphasized:mx.controls.Alert.buttonUpEmphasized,falseDownSkinEmphasized:mx.controls.Alert.buttonDownEmphasized,styleName:(_loc3_ != undefined?mx.controls.Alert.buttonStyleDeclaration:this),validateNow:true});
      _loc2_.setLabel(title);
      _loc2_.setSize(mx.controls.Alert.buttonWidth,mx.controls.Alert.buttonHeight);
      this.buttons.push(_loc2_);
      _loc2_.clickHandler = this.onClick;
      _loc2_.detail = detail;
      this[name] = _loc2_;
   }
   function getSize(Void)
   {
      var _loc2_ = new Object();
      _loc2_.height = this.buttons[0].height + 24;
      var _loc8_ = this._parent.back_mc.title_mc._getTextFormat();
      this.extent = _loc8_.getTextExtent2(this._parent.title);
      _loc2_.width = Math.max(Math.max(2,this.buttons.length) * (this.buttons[0].width + 8),this.extent.width + 4 + 8);
      var _loc6_ = this.text_mc._getTextFormat();
      this.extent = _loc6_.getTextExtent2(this._parent.text);
      this.textMeasure_mc._width = 2 * _loc2_.width;
      this.textMeasure_mc.setNewTextFormat(this.text_mc._getTextFormat());
      this.textMeasure_mc.text = this._parent.text;
      _loc2_.height = _loc2_.height + (this.textMeasure_mc.textHeight + 8);
      var _loc4_ = Math.ceil(this.textMeasure_mc.textHeight / this.extent.height);
      if(_loc4_ > 1)
      {
         this.extent.width = 2 * _loc2_.width;
         this.text_mc.__set__wordWrap(true);
      }
      var _loc3_ = Math.min(this.extent.width + 4 + 8,2 * _loc2_.width);
      var _loc7_ = _loc2_.width;
      _loc2_.width = Math.max(_loc3_,_loc2_.width) + 8;
      if(this.icon_mc != undefined)
      {
         this.extent.width = this.extent.width + (this.icon_mc.width + 8);
         _loc3_ = Math.min(this.extent.width + 4 + 8,2 * _loc7_);
         _loc2_.width = Math.max(_loc3_,_loc2_.width) + 8;
         var _loc5_ = this.icon_mc.height - _loc4_ * (this.extent.height + 4);
         if(_loc5_ > 0)
         {
            _loc2_.height = _loc2_.height + _loc5_;
         }
      }
      return _loc2_;
   }
   function draw(Void)
   {
      this.size();
      this._parent.visible = true;
   }
   function size(Void)
   {
      var _loc4_ = this.__get__height() - this.buttons[0].height - 8;
      var _loc3_ = this.buttons.length * (this.buttons[0].width + 8) - 8;
      _loc3_ = (this.__get__width() - _loc3_) / 2;
      var _loc2_ = 0;
      while(_loc2_ < this.buttons.length)
      {
         this.buttons[_loc2_].move(_loc3_,_loc4_);
         this.buttons[_loc2_].tabIndex = _loc2_ + 1;
         _loc3_ = _loc3_ + (this.buttons[_loc2_].width + 8);
         _loc2_ = _loc2_ + 1;
      }
      _loc4_ = _loc4_ - 8;
      _loc3_ = Math.max((this.__get__width() - this.extent.width - 4) / 2,8);
      if(this.icon_mc != undefined)
      {
         this.icon_mc.move(_loc3_,(this.__get__height() - this.buttons[0].height - this.icon_mc.height) / 2);
         _loc3_ = _loc3_ + (this.icon_mc.width + 8);
      }
      this.text_mc.move(_loc3_,8);
      this.text_mc.setSize(this.__get__width() - _loc3_ - 8,_loc4_ - 8);
      if(this._parent.text == undefined)
      {
         this.text_mc.__set__text("");
      }
      else
      {
         this.text_mc.__set__text(this._parent.text);
      }
   }
   function onClick(evt)
   {
      var _loc2_ = (mx.controls.Alert)this._parent._parent;
      _loc2_.__set__visible(false);
      _loc2_.dispatchEvent({type:"click",detail:this.detail});
      _loc2_.deletePopUp();
   }
}
