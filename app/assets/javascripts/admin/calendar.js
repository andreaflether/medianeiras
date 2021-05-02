$(document).ready(function () {
  var Calendar = FullCalendar.Calendar;

	var calendarEl = document.getElementById('calendar');

	var calendar = new Calendar(calendarEl, {
		themeSystem: 'bootstrap',
		events: $('#calendar').attr('data-src'),
		locale: 'pt-br',
		headerToolbar: {
			left  : 'prev,next today',
			center: 'title',
			right : 'dayGridMonth,timeGridWeek,timeGridDay'
		},
		eventTimeFormat: {
			hour: 'numeric',
			minute: '2-digit',
			meridiem: false
		}
	});

	calendar.render();
})