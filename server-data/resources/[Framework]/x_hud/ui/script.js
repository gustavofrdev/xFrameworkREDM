
$(document).ready(function () {
  var thrist = 0;
  var hunger = 0;
  var life = 0;
  var temp = 0;
  var show = false;
  var healthValue = 0
  var showingHearth = false 
  var switched_event_switch = false 

  var hearth = document.getElementsByClassName("hud vida")[0]
  hearth.style.opacity = 100

  window.addEventListener("message", function (event) {
    var __data = event.data;

    
  //  if(__data.hearth == true ){
  //     switched_event_switch = true 
  //     hearthUpdates.addHearth()
  //     showingHearth = true 
  //  } else if (__data.hearth == false) {
  //    switched_event_switch = true 
  //    hearthUpdates.removeHearth()
  //    showingHearth = false 
  // }
   
    if (event.data.showhud == undefined && __data.fome != null && __data.sede != null ) {
      thrist = __data.fome;
      hunger = __data.sede ;
      healthValue = __data.healthValue ;
      temp = __data.temp;
    }
    if (__data.showhud == true || __data.showhud == false) {
      show = __data.showhud;
    }
      // console.log("update")
      $('#huds').fadeIn();
      setProgressThrist(thrist, '.progress-thrist');
      setProgressHunger(hunger, '.progress-hunger');
      setProgressTemp(temp, '.progress-temp');
      setProgressHealth(healthValue, '.progress-vida')

    
    
  });


  const hearthUpdates = {
    removeHearth: () => {
      if( switched_event_switch){
      if(showingHearth && switched_event_switch){
      var hearth = document.getElementsByClassName("hud vida")[0]
      hearth.style.opacity = 0
        }
      }
    },
    addHearth: () =>{
      if( switched_event_switch){
      if(!showingHearth){
        console.log("abc")
      var health = document.getElementsByClassName("hud vida")[0]
      health.style.opacity = 100
      }
    }
    } 
  }
  // Functions
  function setProgressThrist(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var x = document.getElementById("test1");
    if (percent < 80) {
      x.style.stroke = "#fff";
    }
    if (percent >= 80) {
      x.style.stroke = "#ffaf02";
    }
    if (percent >= 90) {
      x.style.stroke = " #FF0245";
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 100) / 100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  function setProgressHealth(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var x = document.getElementById("test4");
    if (percent > 20) {
      x.style.stroke = "#fff";
    }
    if (percent <= 20) {
      x.style.stroke = "#ffaf02";
    }
    if (percent <= 10) {
      x.style.stroke = " #FF0245";
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 100) / 100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }
  function setProgressHunger(percent, element) {
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var x2 = document.getElementById("test2");
    if (percent < 80) {
      x2.style.stroke = "#fff";
    }
    if (percent >= 80) {
      x2.style.stroke = "#ffaf02";
    }
    if (percent >= 90) {
      x2.style.stroke = " #FF0245";
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent * 100) / 100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  function setProgressTemp(percent, element) {
    var circle = document.querySelector(element);
    var iner = document.getElementById('iner');
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var x3 = document.getElementById("test3");
    if (percent > 30) {
      x3.style.stroke = "#cf0000";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 30) {
      x3.style.stroke = "#eb3b00";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 25) {
      x3.style.stroke = "#ffc800";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 20) {
      x3.style.stroke = "#fff";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 10) {
      x3.style.stroke = "#0084ff";
      iner.innerHTML = parseInt(percent);
    }
    if (percent <= 0) {
      x3.style.stroke = "#0011ff";
      iner.innerHTML = parseInt(percent);
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - (((-percent * 100) / 100) / 100 * circumference) * 2.5;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

});
