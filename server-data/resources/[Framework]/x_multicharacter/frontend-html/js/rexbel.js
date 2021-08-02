$(function() {
    "use strict";
    $(window).on("load", function() {
        $("#preloader").fadeOut(600), $(".preloader-bg").delay(400).fadeOut(600), setTimeout(function() {
            $(".fadeIn-element").delay(600).css({
                display: "none"
            }).fadeIn(800)
        }, 0)
    }), $(".slick-services").slick({
        arrows: !0,
        initialSlide: 0,
        infinite: !0,
        slidesToShow: 1,
        slidesToScroll: 1,
        prevArrow: "<i class='slick-prev icon ion-chevron-left'></i>",
        nextArrow: "<i class='slick-next icon ion-chevron-right'></i>",
        fade: !1,
        autoplay: !1,
        autoplaySpeed: 4e3,
        cssEase: "ease",
        speed: 500
    }), $(".slick-fullscreen-slideshow").slick({
        arrows: !1,
        initialSlide: 0,
        infinite: !0,
        slidesToShow: 1,
        slidesToScroll: 1,
        fade: !0,
        autoplay: !0,
        autoplaySpeed: 4e3,
        cssEase: "ease",
        speed: 1600,
        draggable: !0,
        dots: !1,
        pauseOnDotsHover: !1,
        pauseOnFocus: !1,
        pauseOnHover: !1
    }), $(".slick-fullscreen-slideshow-zoom-fade").slick({
        arrows: !1,
        initialSlide: 0,
        infinite: !0,
        slidesToShow: 1,
        slidesToScroll: 1,
        prevArrow: "<i class='slick-prev icon ion-chevron-left'></i>",
        nextArrow: "<i class='slick-next icon ion-chevron-right'></i>",
        fade: !0,
        autoplay: !0,
        autoplaySpeed: 4e3,
        cssEase: "cubic-bezier(0.7, 0, 0.3, 1)",
        speed: 1600,
        draggable: !0,
        dots: !1,
        pauseOnDotsHover: !0,
        pauseOnFocus: !1,
        pauseOnHover: !1
    }), $("#testimonials-carousel").owlCarousel({
        loop: !0,
        center: !0,
        items: 1,
        margin: 0,
        autoplay: !0,
        autoplaySpeed: 1e3,
        autoplayTimeout: 4e3,
        smartSpeed: 450,
        nav: !1
    }), $("#works-page-img-carousel").owlCarousel({
        loop: !1,
        center: !1,
        items: 3,
        margin: 0,
        autoplay: !1,
        autoplaySpeed: 1e3,
        autoplayTimeout: 5e3,
        smartSpeed: 450,
        nav: !0,
        navText: ["<i class='owl-custom ion-chevron-left'></i>", "<i class='owl-custom ion-chevron-right'></i>"],
        responsive: {
            0: {
                items: 1
            },
            768: {
                items: 2
            },
            1170: {
                items: 3
            }
        }
    }), $(".popup-photo").magnificPopup({
        type: "image",
        gallery: {
            enabled: !0,
            tPrev: "",
            tNext: "",
            tCounter: "%curr% / %total%"
        },
        removalDelay: 300,
        mainClass: "mfp-fade"
    }), $(".menu-state, .c-btn-services, .c-btn-about, .social-icons-launcher").on("click", function() {
        $("#menu-mobile").removeClass("activated"), $("#menu-mobile-caller").removeClass("lines-close")
    }), $("a.menu-state").on("click", function() {
        $("a.menu-state").removeClass("active"), $(this).addClass("active")
    }), $("#fullpage").fullpage({
        anchors: [""],
        navigation: !1,
        navigationPosition: "right",
        navigationTooltips: [""],
        responsiveWidth: 1024,
        autoScrolling: !0,
        scrollBar: !1,
        afterResponsive: function(e) {}
    }), $("#bgndVideo").YTPlayer(), $(".c-btn-services, .c-btn-about").on("click", function() {
        var e = $(this).attr("data-id");
        $(this).hasClass("open") ? ($(this).removeClass("open"), $("." + e).addClass("open")) : ($(this).addClass("open"), $("." + e).addClass("open"))
    }), $(".services-more-launch, .navigation-icon").on("click", function() {
        $(".panel-from-left, .panel-from-right, .panel-overlay-from-left, .panel-overlay-from-right").removeClass("open")
    }), $(".about-more-launch, .navigation-icon").on("click", function() {
        $(".panel-from-left-about, .panel-from-right-about, .panel-overlay-from-left-about, .panel-overlay-from-right-about").removeClass("open")
    }), $("form#form").on("submit", function() {
        $("form#form .error").remove();
        var e = !1;
        if ($(".requiredField").each(function() {
                if ("" === jQuery.trim($(this).val())) $(this).prev("label").text(), $(this).parent().append('<span class="error">This field is required</span>'), $(this).addClass("inputError"), e = !0;
                else if ($(this).hasClass("email")) {
                    /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test(jQuery.trim($(this).val())) || ($(this).prev("label").text(), $(this).parent().append('<span class="error">Invalid email address</span>'), $(this).addClass("inputError"), e = !0)
                }
            }), !e) {
            $("form#form input.submit").fadeOut("normal", function() {
                $(this).parent().append("")
            });
            var s = $(this).serialize();
            $.post($(this).attr("action"), s, function() {
                $("form#form").slideUp("fast", function() {
                    $(this).before('<div class="success">Your email was sent successfully.</div>')
                })
            })
        }
        return !1
    }), $.fn.duplicate = function(e, s, a) {
        for (var o, i = []; e--;) o = this.clone(s), a && a.call(o), i.push(o.get()[0]);
        return this.pushStack(i)
    }, $("<div class='upper-page'></div>").appendTo(".horizontal-stripes"), $("<div class='running-teardrop'></div>").duplicate(4).appendTo(".upper-page"), $("<div class='all-bg-wapper'></div>").appendTo(".horizontal-stripes-sections"), $("<div class='running-teardrop'></div>").duplicate(4).appendTo(".horizontal-stripes-sections .all-bg-wapper"), $(".social-icons-launcher").on("click", function() {
        $(".social-icons-wrapper").hasClass("social-icons-wrapper-reveal-show") ? ($(".social-icons-wrapper").removeClass("social-icons-wrapper-reveal-show").addClass("social-icons-wrapper-reveal-hide"), $(".welcome-message").removeClass("welcome-message-reveal-hide").addClass("welcome-message-reveal-show")) : ($(".social-icons-wrapper").removeClass("social-icons-wrapper-reveal-hide").addClass("social-icons-wrapper-reveal-show"), $(".welcome-message").addClass("welcome-message-reveal-hide").removeClass("welcome-message-reveal-show"))
    }), $(".navigation-icon, .logo").on("click", function() {
        $(".social-icons-wrapper").removeClass("social-icons-wrapper-reveal-show").addClass("social-icons-wrapper-reveal-hide"), $(".welcome-message").removeClass("welcome-message-reveal-hide").addClass("welcome-message-reveal-show")
    }), $(".show-skillbar").appear(function() {
        $(".skillbar").skillBars({
            from: 0,
            speed: 4e3,
            interval: 100,
            decimals: 0
        })
    });
    var e = new Swiper(".swiper-slider-top", {
            direction: "vertical",
            nextButton: ".swiper-button-next",
            prevButton: ".swiper-button-prev",
            autoplay: 4e3,
            speed: 1600,
            spaceBetween: 0,
            centeredSlides: !0,
            slidesPerView: "auto",
            touchRatio: 1,
            loop: !0,
            slideToClickedSlide: !0,
            mousewheelControl: !1,
            keyboardControl: !1
        }),
        s = new Swiper(".swiper-slider-bottom", {
            direction: "horizontal",
            spaceBetween: 10,
            centeredSlides: !0,
            slidesPerView: "auto",
            touchRatio: 1,
            loop: !0,
            slideToClickedSlide: !0,
            mousewheelControl: !1,
            keyboardControl: !1
        });
    e.params.control = s, s.params.control = e
});