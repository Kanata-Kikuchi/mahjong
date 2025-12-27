'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e29c33c48b15c74f23058fffcc1e5e5e",
"assets/AssetManifest.bin.json": "94405ed20f456732336cc13ba5d218d5",
"assets/AssetManifest.json": "c11df2471fc67e148895b80dd082787c",
"assets/assets/images/back.png": "6e82306a3cb02f585c6e1b44142a321a",
"assets/assets/images/game_stick.png": "8bdc1cee496e124003730ab0ca1d8a4a",
"assets/assets/images/manzu_1.png": "42e4019c8955d4e29a1d45ee9dab7d8b",
"assets/assets/images/manzu_2.png": "091220b01d18e922efbfced00f0843ea",
"assets/assets/images/manzu_3.png": "d952962a41fe333f4d0e8d398c6ec9c9",
"assets/assets/images/manzu_4.png": "b872f0ebe00c795d1a2ff5d18302caef",
"assets/assets/images/manzu_5.png": "7a54b26d61c924f67b6ac0690f3e8772",
"assets/assets/images/manzu_5r.png": "219077fcabc617a2f2c2e6257513b136",
"assets/assets/images/manzu_6.png": "1ca0c9b9ba7a478db339bd0966f0f14e",
"assets/assets/images/manzu_7.png": "72288017f1c6b1afbcbcff242df0e078",
"assets/assets/images/manzu_8.png": "362eacf74f8abdafa6b45f5f4e8ee55e",
"assets/assets/images/manzu_9.png": "26b2e4a3ffa780c13b0339111f229c78",
"assets/assets/images/pinzu_1.png": "a91a78b82c5f9bbf49f4e9af7f27b0b4",
"assets/assets/images/pinzu_2.png": "92b452fbc7791dd5c2bfaba00b5cdb4f",
"assets/assets/images/pinzu_3.png": "6121f8631b93b6a010e89b5b94e684a2",
"assets/assets/images/pinzu_4.png": "7ceb95de8d29fd8f6872693161635140",
"assets/assets/images/pinzu_5.png": "6c8dc3ff6d4a6d4db74e7ca359eec988",
"assets/assets/images/pinzu_5r.png": "4b11fafb4b8f565b884415a8029b1f4c",
"assets/assets/images/pinzu_6.png": "499d5a88780a22d3f5335a8c3eb7db5b",
"assets/assets/images/pinzu_7.png": "7d5f4b0cde33938be5c5e84ceb11cdb0",
"assets/assets/images/pinzu_8.png": "ce44c68de55e6c85693b1ba4ce1c0e57",
"assets/assets/images/pinzu_9.png": "6b7da385aec0c189efd0e26bca387b90",
"assets/assets/images/reach_stick.png": "3ead0939fe4e13a7ab633801932bf798",
"assets/assets/images/souzu_1.png": "59561b4c155a7edbb31962b360a79268",
"assets/assets/images/souzu_2.png": "4d9fc800fb1d282dbac1b8b1a4b1ae11",
"assets/assets/images/souzu_3.png": "8d8329b472bde6e17f7f6deed070d3f2",
"assets/assets/images/souzu_4.png": "e8c47258a19a1617337c051f4c73fb0b",
"assets/assets/images/souzu_5.png": "23c677a710775e4aa60e97bc85e018b9",
"assets/assets/images/souzu_5r.png": "16a10e2734894041477670c6467ce87f",
"assets/assets/images/souzu_6.png": "8158428f1f0e1a05780fd156fbf95fa4",
"assets/assets/images/souzu_7.png": "38d27b6010b2dccd2afab6c99240e146",
"assets/assets/images/souzu_8.png": "bd4495c64e429a3ad042b7b3b0ff503c",
"assets/assets/images/souzu_9.png": "dfc18aedf7c71db826d07953b7d7d43c",
"assets/assets/images/zihai_1.png": "290b2368eb89a0039641c3c6ad836faa",
"assets/assets/images/zihai_2.png": "53c8087f345f572c221bc2c04b8cca4a",
"assets/assets/images/zihai_3.png": "1335ca0d9a9775b658b1c712b0aa8166",
"assets/assets/images/zihai_4.png": "0ad3e5d2b5807f608034222404730c1e",
"assets/assets/images/zihai_5.png": "57da9933c51eedbc952798c32f228ced",
"assets/assets/images/zihai_6.png": "ec32c71285cfe089aae005fad4ab0723",
"assets/assets/images/zihai_7.png": "406830ca44fc3432276c5c7892da6c63",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "03f7c8954a40d4a385ef690f96bc364f",
"assets/NOTICES": "9ba185d113f259ed526ec4608e0f601e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "ae0257a44f1c3212b2df96329d769477",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2d768df5c75112b732d7e4adf50b414b",
"/": "2d768df5c75112b732d7e4adf50b414b",
"main.dart.js": "72fd58e815de9ab90662bf3549d71b83",
"manifest.json": "0e40ac541df0c45ea942283b4d362ab4",
"version.json": "1a03dadffd71beff6651c790f04e24bd"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
