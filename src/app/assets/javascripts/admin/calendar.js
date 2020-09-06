$(document).ready(function () {

  /* initialize the external events
   -----------------------------------------------------------------*/
  function init_events(ele) {
    ele.each(function () {
      // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
      // it doesn't need to have a start or end
      var eventObject = {
        title: $.trim($(this).text()) // use the element's text as the event title
      }
      // store the Event Object in the DOM element so we can get to it later
      $(this).data('eventObject', eventObject)
    })
  }

  init_events($('#external-events div.external-event'))

  /* initialize the calendar
   -----------------------------------------------------------------*/
  var date = new Date()
  var d    = date.getDate(),
      m    = date.getMonth(),
      y    = date.getFullYear()

  $('#calendar').fullCalendar({
    header    : {
      left  : 'prev,next today',
      center: 'title',
      right : 'month,agendaWeek,agendaDay'
    },
    locale: 'pt-br',
    buttonText: {
      today: 'Hoje',
      month: 'Mês',
      week : 'Semana',
      day  : 'Dia'
    },
    // Random default events
    events    : '/admin/events.json',
    editable  : false,
    droppable : false, // this allows things to be dropped onto the calendar
  })
})