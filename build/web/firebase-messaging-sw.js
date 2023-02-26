importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
    apiKey: "AIzaSyCEOZ9vg6tGa6bKmV-VCt0ZwiPjY8_g894",
    authDomain: "ids-5-80a20.firebaseapp.com",
    databaseURL: "https://ids-5-80a20-default-rtdb.firebaseio.com",
    projectId: "ids-5-80a20",
    storageBucket: "ids-5-80a20.appspot.com",
    messagingSenderId: "442532211592",
    appId: "1:442532211592:web:b8b0d3f4c812801f3e283d",
    measurementId: "G-dsada"
 };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });