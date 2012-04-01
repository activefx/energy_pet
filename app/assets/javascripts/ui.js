var Ui = function(id){
  
  this.canvas = document.getElementById(id);
  this.context = this.canvas.getContext('2d');
  if(window.devicePixelRatio) {
    ratio = window.devicePixelRatio;
  } else {
    ratio = 1;
  }
  if(this.isTouchDevice()) {
    this.canvas.width = window.innerWidth * ratio;
    this.canvas.height = window.innerHeight * ratio;
    this.canvas.style.width = window.innerWidth + 'px';
    this.canvas.style.height = window.innerHeight + 'px';
    this.width = window.innerWidth;
    this.height = window.innerHeight;
    function preventTouchMove(e) {e.preventDefault()}
    this.canvas.addEventListener('touchmove', preventTouchMove, false);
  } else {
    this.canvas.width = 480 * ratio;
    this.canvas.height = 320 * ratio;
    this.canvas.style.width = '480px';
    this.canvas.style.height = '320px';
    this.width = 480;
    this.height = 320;
    this.canvas.style.borderWidth = '2px'
  }
  this.context.scale(ratio, ratio);
  this.setListeners();
  this.buttons = [];
  
  this.clear();

};


Ui.prototype.isTouchDevice = function(){
  return (window.Touch) ? true : false;
};


Ui.prototype.handleTouch = function(e){
  for(i in this.buttons){
    var b = this.buttons[i],
    touchx = e.changedTouches[0].clientX,
    touchy = e.changedTouches[0].clientY;
    if(utils.pointInPoly(b.coords, [touchx, touchy])) {
      b.callback.call();
    }
  }
};


Ui.prototype.handleClick = function(e){
  e.preventDefault();
  for(i in this.buttons){
    var b = this.buttons[i],
    clickx = e.clientX - this.canvas.offsetLeft,
    clicky = e.clientY - this.canvas.offsetTop;
    if(utils.pointInPoly(b.coords, [clickx, clicky])) {
      b.callback();
    }
  }
};

Ui.prototype.setListeners = function(){
  var self = this;
  if(this.isTouchDevice()) {
    this.canvas.addEventListener('touchstart', function(e){self.handleTouch.call(self, e)});
  } else {
    this.canvas.addEventListener('click', function(e){self.handleClick.call(self, e)});
  }
};


Ui.prototype.addButton = function(button){
  this.buttons.push(button);
  this.drawButtons();
};


Ui.prototype.drawButtons = function(){
  for(i in this.buttons){
    var button = this.buttons[i];
    if(button.fill) {
      this.context.fillStyle = button.fill;
      this.context.fillRect(button.coords[0][0], button.coords[0][1],
        button.coords[1][0] - button.coords[0][0],
        button.coords[3][1] - button.coords[0][1])
    } else if(button.image) {
      //this.context.drawImage();
    }
  }
};


Ui.prototype.addText = function(text, pos){
  this.context.fillStyle = '#000';
  this.context.font = 'bold 45px Arial';
  this.context.fillText(text, pos[0], pos[1]);
};


Ui.prototype.clear = function(clearButtons){
  var self = this;
  this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
  this.context.fillStyle ='#eee';
  this.context.fillRect(0,0,this.canvas.width, this.canvas.height);
  if(clearButtons) {
    this.buttons = new Array();
  } else {
    this.drawButtons();
  }
};


Ui.button = function(rect, fill, callback){
  this.coords = rect;
  if(typeof(fill) == 'string') {
    this.fill = fill;
  } else {
    this.image = fill;
  }
  this.callback = callback;
};

Ui.prototype.drawSprite = function(s){
  this.context.drawImage(s.image,
    s.sx, s.sy,
    s.sWidth, s.sHeight,
    s.dx, s.dy,
    s.dWidth, s.dHeight
  );
};


//Sprite


var Sprite = function(p){
  this.load = false;
  
  var setLoad = function(){
    this.load = true;
  }
  
  var image = new Image();
  image.src = p.image;
  var that = this;
  image.onload = function(){setLoad.call(that)};
  this.image = image;
  this.sx = p.sx;
  this.sy = p.sy;
  this.sWidth = p.sWidth;
  this.sHeight = p.sHeight;
  this.dx = p.dx;
  this.dy = p.dy;
  this.dWidth = p.dWidth;
  this.dHeight = p.dHeight;
};


//Utilities


var utils = {};
utils.pointInPoly = function(poly, pt){
  
  if(poly) {
  
	for(var c = false, i = -1, l = poly.length, j = l - 1; ++i < l; j = i)
		((poly[i][1] <= pt[1] && pt[1] < poly[j][1]) ||
     (poly[j][1] <= pt[1] && pt[1] < poly[i][1]))&&
    (pt[0] < (poly[j][0] - poly[i][0]) * (pt[1] - poly[i][1]) / (poly[j][1] - poly[i][1]) + poly[i][0]) &&
    (c = !c);
	return c;
  }
};

utils.colorConv = function(color) {
  var rgb = [
    parseInt(color.substring(0,2),16), 
    parseInt(color.substring(2,4),16), 
    parseInt(color.substring(4,6),16)
  ];
    
  return rgb;
};
