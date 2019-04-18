HTMLWidgets.widget({

  name: 'calendar',

  type: 'output',

  factory: function(el, width, height) {

    var Calendar = tui.Calendar;

    return {

      renderValue: function(x) {
        
        var options = x.options;

        var cal = new Calendar(el, options);
        var schd = x.schedules;
        cal.createSchedules(schd);
        
        // nav
        var menu = document.getElementById(el.id + "_menu");
        
        var prev = menu.querySelectorAll("button[data-action='move-prev']");
        prev[0].addEventListener("click", function(e) {
          cal.prev();
        }, false);
        var next = menu.querySelectorAll("button[data-action='move-next']");
        next[0].addEventListener("click", function(e) {
          cal.next();
        }, false);
        

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
