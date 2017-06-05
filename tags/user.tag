<hn-user>
  <div if="{ user.id }">
    <h1>User: { user.id }</h1>
    <p>Created: { user.created }</p>
    <p>Karma: { user.karma }</p>
    <br>
    <div>
      <a href="https://news.ycombinator.com/submitted?id={ user.id }">sumbmissions</a>
      <a href="https://news.ycombinator.com/threads?id={ user.id }">comments</a>
      <a href="https://news.ycombinator.com/favorites?id={ user.id }">favorites</a>
    </div>
  </div>

  <div if="{ !user.id }">
    <h1>User not found</h1>
  </div>

  <script>
    this.user = {}
    this.id = opts.id || null

    var self = this
    var fetchBaseUrl = 'https://node-hnapi.herokuapp.com/user/'
    this.fetching = false
    this.data = [];

    this.on('mount', function() {
      if (!self.fetching) {
        self.fetching = true
        self.fetchUser(self.id)
      } else {
        self.fetching = false
      }
    })

    this.on('update', function() {
      if (!self.fetching) {
        self.fetching = true
        self.fetchUser(self.id)
      } else {
        self.fetching = false
      }
    })

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

    fetchUser(id) {
      if (id) {
        var url = fetchBaseUrl + id;
        self.makeFetch(url).then(function(data) {
          self.user = data
          self.update()
        });
      }
    }
  </script>
</hn-user>