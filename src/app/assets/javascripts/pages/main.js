$(document).ready(function() {
  AOS.init({
    duration: 800,
    easing: 'slide',
    once: true
  });

  $('.activity-overlay').hover(function() {
    $(this).toggleClass('activate');
  })

  $('.volunteer').hover(function() {
    $(this).toggleClass('hoverEffect');
  })

  const $dropdown = $(".dropdown");
  const $dropdownToggle = $(".dropdown-toggle");
  const $dropdownMenu = $(".dropdown-menu");
  const showClass = "show";
 
  $(window).on("load resize", function() {
    if (this.matchMedia("(min-width: 768px)").matches) {
      $dropdown.hover(
        function() {
          const $this = $(this);
          $this.addClass(showClass);
          $this.find($dropdownToggle).attr("aria-expanded", "true");
          $this.find($dropdownMenu).addClass(showClass);
        },
        function() {
          const $this = $(this);
          $this.removeClass(showClass);
          $this.find($dropdownToggle).attr("aria-expanded", "false");
          $this.find($dropdownMenu).removeClass(showClass);
        }
      );
    } else {
      $dropdown.off("mouseenter mouseleave");
    }
  });

  window.onscroll = function() {scrollFunction()};

  function scrollFunction() {
    if (document.body.scrollTop > 80 || document.documentElement.scrollTop > 80) {
      // document.getElementById("navbar").style.padding = "30px 10px";
      document.getElementById("logo").style.width = "40%";
    } else {
      
      document.getElementById("logo").style.width = "55%";
    }
  }

  $(window).on('scroll', function() {
    if ($(this).scrollTop() > 400) {
        $('#scroll-to-top').fadeIn();
    } else {
        $('#scroll-to-top').fadeOut();
    }
  });

  $("#scroll-to-top").click(function() {
    $("html, body").animate({ scrollTop: 0 }, "slow");
    return false;
  });

  $('.nav-link').each(function () {
    var curr_page = ($(this)).attr('href');
    if (window.location.pathname == curr_page) {
      $(this).closest('li').addClass('active')
    }
  });
})