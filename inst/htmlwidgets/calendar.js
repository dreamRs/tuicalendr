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
        if (x.useNav) {
          var menu = document.getElementById(el.id + "_menu");
          var renderRange = document.getElementById(el.id + "_renderRange");
          renderRange.innerHTML = dateToYMD(cal.getDateRangeStart()) + " - " + dateToYMD(cal.getDateRangeEnd());
          var prev = menu.querySelectorAll("button[data-action='move-prev']");
          prev[0].addEventListener("click", function(e) {
            cal.prev();
            renderRange.innerHTML = dateToYMD(cal.getDateRangeStart()) + " - " + dateToYMD(cal.getDateRangeEnd());
          }, false);
          var next = menu.querySelectorAll("button[data-action='move-next']");
          next[0].addEventListener("click", function(e) {
            cal.next();
            renderRange.innerHTML = dateToYMD(cal.getDateRangeStart()) + " - " + dateToYMD(cal.getDateRangeEnd());
          }, false);
          var today = menu.querySelectorAll("button[data-action='move-today']");
          today[0].addEventListener("click", function(e) {
            cal.today();
            renderRange.innerHTML = dateToYMD(cal.getDateRangeStart()) + " - " + dateToYMD(cal.getDateRangeEnd());
          }, false);
        }
        

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});


function dateToYMD(date) {
  var d = date.getDate();
  var m = date.getMonth() + 1; //Month from 0 to 11
  var y = date.getFullYear();
  return '' + y + '-' + (m<=9 ? '0' + m : m) + '-' + (d <= 9 ? '0' + d : d);
}
