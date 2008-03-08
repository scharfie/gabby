GabberTimer = function() {
  this.idle = 15; // number of minutes before idle
  this.idle_counter = this.idle;
  this.is_idle  = false;
  this.timer_id = null;
}

GabberTimer.prototype = {
  resetIdleStatus: function() {
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
        alert("You are now idle");  
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
}