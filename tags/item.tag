<hn-item>
  <h2>{ data.title }</h2>
  <p>Item id { id }</p>

  <script>
    this.id = opts.id || 'null'

    var self = this
    var fetchBaseUrl = 'https://node-hnapi.herokuapp.com/item/'
    this.fetching = false
    this.data = [];

    this.on('mount', function() {
      self.fetchItem(self.id)
    })

    this.on('update', function() {
      if (!self.fetching) {
        self.fetching = true
        self.fetchItem(self.id)
      } else {
        self.fetching = false
      }
    })

    // this.on('*', function(eventName) {
    //   console.info(eventName)
    // })

    fetch(url) {
      return new Promise(function(resolve, reject) {
        var request = new XMLHttpRequest()
        request.onerror = reject
        request.onload = function() {
          resolve({
            json: function() {
              return Promise.resolve(request.responseText).then(JSON.parse)
            }
          })
        }
        request.open('get', url);
        request.send();
      })
    }

    makeFetch(url) {
      return self.fetch(url).then(function(response) {
        return response.json().then(function(data) {
          return data;
        });
      }).catch(function(reject) {
        return Promise.reject(reject);
      });
    }

    fetchItem(id) {
      if (id) {
        var url = fetchBaseUrl + id;
        self.makeFetch(url).then(function(data) {
          console.log(data)
          self.data = data
          self.update()
        });
      }
    }
  </script>
</hn-item>