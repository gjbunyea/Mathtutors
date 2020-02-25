class mx.controls.Alert extends mx.containers.Window
{
   static var symbolOwner = mx.containers.Window;
   static var version = "2.0.2.127";
   static var buttonWidth = 50;
   static var buttonHeight = 22;
   static var okLabel = "OK";
   static var yesLabel = "Yes";
   static var noLabel = "No";
   static var cancelLabel = "Cancel";
   static var buttonUp = "ButtonSkin";
   static var buttonDown = "ButtonSkin";
   static var buttonOver = "ButtonSkin";
   static var titleBackground = "TitleBackground";
   static var buttonUpEmphasized = "ButtonSkin";
   static var buttonOverEmphasized = "ButtonSkin";
   static var buttonDownEmphasized = "ButtonSkin";
   var className = "Alert";
   var allowSize = false;
   static var NONMODAL = 32768;
   static var YES = 1;
   static var NO = 2;
   static var OK = 4;
   static var CANCEL = 8;
   static var P = _root;
   function Alert()
   {
      super();
   }
   static function show(text, title, flags, parent, listener, icon, defButton)
   {
      var _loc2_ = new Object();
      var _loc6_ = !(flags & mx.controls.Alert.NONMODAL)?true:false;
      if(parent == undefined)
      {
         parent = _loc2_.parent = _root;
      }
      else
      {
         _loc2_.parent = _loc2_.parent = _root;
      }
      _loc2_.okButton = !(flags & mx.controls.Alert.OK)?false:true;
      _loc2_.cancelButton = !(flags & mx.controls.Alert.CANCEL)?false:true;
      _loc2_.yesButton = !(flags & mx.controls.Alert.YES)?false:true;
      _loc2_.noButton = !(flags & mx.controls.Alert.NO)?false:true;
      _loc2_.defButton = defButton;
      if(_loc2_.okButton == false && _loc2_.cancelButton == false && _loc2_.yesButton == false && _loc2_.noButton == false)
      {
         _loc2_.okButton = true;
         _loc2_.defButton = mx.controls.Alert.OK;
      }
      _loc2_.title = title;
      _loc2_.text = text;
      _loc2_.icon = icon;
      _loc2_.style = mx.controls.Alert.style;
      _loc2_.skinTitleBackground = mx.controls.Alert.titleBackground;
      _loc2_.titleStyleDeclaration = mx.controls.Alert.titleStyleDeclaration;
      _loc2_.validateNow = true;
      var _loc4_ = mx.managers.PopUpManager.createPopUp(_loc2_.parent = _root,mx.controls.Alert,_loc6_,_loc2_);
      if(_loc4_ == undefined)
      {
         trace("Failed to create a new alert, probably because there is no Alert in the Library");
      }
      _loc4_.addEventListener("click",listener);
      return _loc4_;
   }
   function init(Void)
   {
      super.init();
      this.__set__visible(false);
   }
   function createChildren(Void)
   {
      if(mx.controls.Alert.messageStyleDeclaration != undefined)
      {
         this.styleName = mx.controls.Alert.messageStyleDeclaration;
      }
      var _loc3_ = mx.controls.alertClasses.AlertForm;
      this.__set__contentPath(_loc3_);
      super.createChildren();
   }
   function getViewMetrics(Void)
   {
      var _loc2_ = super.getViewMetrics();
      return _loc2_;
   }
   function doLayout(Void)
   {
      super.doLayout();
   }
   function draw(Void)
   {
      var _loc9_ = this.initializing;
      super.draw();
      if(_loc9_)
      {
         var _loc5_ = new Object();
         _loc5_.x = this.parent._x;
         _loc5_.y = this.parent._y;
         this.parent.localToGlobal(_loc5_);
         var _loc7_ = this.parent.width;
         var _loc8_ = this.parent.height;
         if(this.parent == _root && this.parent._parent == undefined || _loc7_ == undefined)
         {
            var _loc6_ = mx.managers.SystemManager.__get__screen();
            _loc7_ = _loc6_.width;
            _loc8_ = _loc6_.height;
            _loc5_.x = _loc6_.x;
            _loc5_.y = _loc6_.y;
         }
         if(_global.isLivePreview)
         {
            return undefined;
         }
         _loc5_.x = _loc5_.x + (_loc7_ - this.__get__width()) / 2;
         _loc5_.y = _loc5_.y + (_loc8_ - this.__get__height()) / 2;
         this.parent.globalToLocal(_loc5_);
         this.move(_loc5_.x,_loc5_.y);
         if(this._child0.defButtonName != undefined)
         {
            this._child0[this._child0.defButtonName].setFocus();
         }
         else
         {
            this._child0.buttons[0].setFocus();
         }
      }
   }
   function size(Void)
   {
      if(_global.isLivePreview)
      {
         this.__width = this.width;
         this.__height = this.height;
      }
      else
      {
         var _loc4_ = this._child0.getSize();
         if(isNaN(_loc4_.width) || _loc4_.width < 20)
         {
            _loc4_.width = 96;
         }
         if(isNaN(_loc4_.height) || _loc4_.height < 20)
         {
            _loc4_.height = 66;
         }
         var _loc5_ = this.border_mc.__get__borderMetrics();
         if(!this.allowSize)
         {
            this.__width = _loc4_.width + 2 * _loc5_.left;
            this.__height = _loc4_.height + _loc5_.top + _loc5_.bottom + this.back_mc.height;
            this.allowSize = false;
         }
      }
      super.size();
   }
   function setSize(w, h)
   {
      this.__width = w;
      this.__height = h;
      this.initializing = this.allowSize = true;
      this.invalidate();
   }
}
