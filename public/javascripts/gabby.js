GabberTimer = function() {
  this.idle = 15; // number of minutes before idle
  this.idle_counter = this.idle;
  this.is_idle  = false;
  this.timer_id = null;
}

GabberTimer.prototype = {
  resetIdleStatus: function() {
    if (this.is_idle) Gabber.setOnline();
    
    this.idle_counter = this.idle;
    this.is_idle  = false;
  }
  ,
  
  // Called by the timer
  timerCallback: function() {
    if (!this.is_idle) {
      this.idle_counter--;
      if (this.idle_counter <= 0) {
        this.is_idle = true;
        Gabber.setIdle();
      } // end if <= 0
    } // end if !idle
  }
  ,
  
  // Starts a one-minute timer
  start: function() {
    var gT = this;
    if (this.timer_id != null) return;
    this.timer_id = window.setInterval(function() { 
      gT.timerCallback();
    }, 60000);
  }
  ,
  
  // Stops the timer
  stop: function() {
    if (this.timer_id == null) return;
    window.clearInterval(this.timer_id);
    this.timer_id = null;
  }
};

Gabber = function() {
}

Gabber.setIdle = function() {
  new Ajax.Request('/gabber/idle');
}

Gabber.setOnline = function() {
  new Ajax.Request('/gabber/online');
}

Gabber.setOffline = function() {
  new Ajax.Request('/gabber/offline');
}

Gabber.names = new Array();

GabberTabCompletion = function(event, textarea) {
  this.event = event;
  this.textarea = textarea;
  this.boundary = 0;
};

GabberTabCompletion.prototype = {
  complete: function() {
    word = this.currentWord();
    if (match = this.findMatch(word)) {
      if (this.boundary == 0) {
        match += ': ';
      }
      this.insertText(match.slice(word.length));
    } // end if
    
    Event.stop(this.event);
  }
  ,
  insertText: function(text) {
    var position = this.textarea.selectionStart;
    this.textarea.value = 
      this.textarea.value.substring(0, position) + text + 
      this.textarea.value.substring(position, this.textarea.value.length);       
  }
  ,
  currentWord: function() {
    var index = this.textarea.selectionStart;
    var value = this.textarea.value;
    var ch    = value[index];
    
    if (ch != null && ch != ' ') return;
    
    var boundary = 0;
    for(var i = index; i >= 0; i--) {
      if (value[i] == ' ' || value[i] == "\n") {
        boundary = i + 1;
        break;
      }
    }
    
    this.boundary = boundary;
    return value.slice(boundary, index);
  }
  ,
  findMatch: function(word) {
    var names = Gabber.names;
    var lowerWord = word.toLowerCase();
    for(var i = 0; i < names.length; i++) {
      if (names[i].slice(0, word.length).toLowerCase() == lowerWord) {
        return names[i];
      } // end if
    } // end for
    
    return null;
  }
}

GabberTabCompletion.complete = function(event, textarea) {
  var gTC = new GabberTabCompletion(event, textarea);
  return gTC.complete();
}