const OFFLINE_URL = '/offline.html';
const CACHE_VERSION = 1;
let CURRENT_CACHES = {
    offline: 'offline-v' + CACHE_VERSION
};

self.addEventListener('install', function (event) {
    event.waitUntil(
        fetch(createCacheBustedRequest(OFFLINE_URL)).then(function (response) {
            return caches.open(CURRENT_CACHES.offline).then(function (cache) {
                return cache.put(OFFLINE_URL, response);
            });
        })
    );
});

function createCacheBustedRequest(url) {
    let request = new Request(url, {cache: 'reload'});
    // See https://fetch.spec.whatwg.org/#concept-request-mode
    // This is not yet supported in Chrome as of M48, so we need to explicitly check to see
    // if the cache: 'reload' option had any effect.
    if ('cache' in request) {
        return request;
    }

    // If {cache: 'reload'} didn't have any effect, append a cache-busting URL parameter instead.
    let bustedUrl = new URL(url, self.location.href);
    bustedUrl.search += (bustedUrl.search ? '&' : '') + 'cachebust=' + Date.now();
    return new Request(bustedUrl);
}

self.addEventListener('fetch', function (event) {
    if (event.request.mode === 'navigate' ||
        (event.request.method === 'GET' &&
        event.request.headers.get('accept').includes('text/html'))) {
        //console.log('Handling fetch event for', event.request.url);
        event.respondWith(
            fetch(createCacheBustedRequest(event.request.url)).catch(function (error) {
                console.log('Fetch failed; returning offline page instead.', error);
                return caches.match(OFFLINE_URL);
            })
        );
    }
});