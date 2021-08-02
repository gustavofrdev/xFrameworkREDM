let max_timer_notif = 5000 //This will let the notif display for like 5 seconds.

function Notify(event)
{
  (() => {

      //Create div id_notification this is the container for all the notification showed :
      const id_notification = document.createElement("div");
      let id = Math.random().toString(36).substr(2,10);
      id_notification.setAttribute("id", id);
      id_notification.classList.add("notif");


      //Parent div "notification ..."
      const iconPosition = event.data.data_position
      const time = event.data.data_time
      const notification = document.createElement("div");
      notification.classList.add("notification", event.data.data_type);
      notification.style.flexDirection = iconPosition;
      

      //adding nested new div for the logo :
      const iconName = event.data.data_icon
      const mainIcon = document.createElement("div");
      mainIcon.classList.add("data_icon");
      mainIcon.innerHTML = '<i class="'+ iconName + '"></i>';
      notification.innerText = event.data.data_text;

      //Main Container : 
      const notificationArea = document.getElementById("notification-area");


      //Parent system : 
      notification.appendChild(mainIcon);
      id_notification.appendChild(notification);
      notificationArea.appendChild(id_notification);


      //Sleep :
      setTimeout(()=>
      {
          var notifications = notificationArea.getElementsByClassName("notif")
            
          for(let i=0; i<notifications.length; i++)
          {
              if(notifications[i].getAttribute("id") == id)
              {
                  notifications[i].remove();
                  break;
              }
          }
      }, time);
  })();
}



window.addEventListener('message', (data) => {
  const notifyicon = data.data.icon; 
  const notifyType = data.data.type;
  const notifyText = data.data.text;
  const notifyposition = data.data.position;
  const notifyTime = data.data.time;
  if(notifyText !== null && notifyType !== null && notifyposition !== null && notifyicon !== null ) {
    Notify(data)
  }else {
    console.log("triggerError: Algum valor está faltando [???:65]")
  }
})