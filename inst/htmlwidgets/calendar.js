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
        

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
