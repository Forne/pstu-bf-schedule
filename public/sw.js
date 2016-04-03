self.addEventListener('install', function (event) {
    self.skipWaiting();
    //console.log('Installed');
});

/*
self.addEventListener('activate', function(event) {
    //console.log('Activated');
});

self.addEventListener('push', function(event) {
    console.log('Push message received', event);
});

self.addEventListener('fetch', function(event) {
    console.log(event.request.url);
});*/
