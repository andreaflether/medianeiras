/* initialize the calendar
 -----------------------------------------------------------------*/
//Date for the calendar events (dummy data)
$(document).ready(function() {
  var date = new Date()
  var d    = date.getDate(),
      m    = date.getMonth(),
      y    = date.getFullYear()

  var Calendar = FullCalendar.Calendar;
  var calendarEl = $('#calendar');

  // initialize the external events
  // -----------------------------------------------------------------
  var calendar = new Calendar(calendarEl[0], {
    plugins: [ 'bootstrap', 'dayGrid', 'timeGrid' ],
    header    : {
      left  : 'prev,next today',
      center: 'title',
      right : 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    'themeSystem': 'bootstrap',
    locale: 'pt-br',
    //Random default events
    events    : calendarEl.data('xhr'),
    editable  : false,
    droppable : false, // this allows things to be dropped onto the calendar !!!
  });

  calendar.render();
  });
  // $('#calendar').fullCalendar()
