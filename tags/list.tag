<hn-list>
  <p>{ path }</p>
  <ul>
    <li each="{ data }" id="{ id }">
      <span class="number">{ points }</span>
      <span class="title">
        <a href="{ url }">{ title }</a>
        <span class="host">({ domain })</span>
      </span>
      <span class="meta">
        <span class="score">{ points } points</span>
        <span class="by">by <a href="#">{ user }</a></span>
        <span class="time">{ time_ago }</span>
        <span class="comments_link">
          | <a href="#item/{ id }">{ comments_count } comments</a>
        </span>
      </span>
    </li>
  </ul>

  <style>
    :scope ul {
      list-style: none;
      padding: 0 16px;
      margin: 0;
    }

    :scope ul li {
      position: relative;
      padding: 16px 16px 16px 56px;
      box-sizing: border-box;
      margin: 16px 0;
      border: 1px solid #dedede;
      box-shadow: 0 2px 3px rgba(0,0,0,0.15);
    }

    :scope ul li > * {
      display: block;
    }
    
    :scope .number {
      position: absolute;
      left: 16px;
      top: 50%;
      transform: translateY(-50%);
    }
  </style>

  <script>
    var self = this
    var fetchBaseUrl = 'https://node-hnapi.herokuapp.com'
    this.fetching = false
    this.data = [];
    this.path = opts.path || 'top'
    this.on('mount', function() {
      self.fetchList(self.path)
    })

    this.on('update', function() {
      if (!self.fetching) {
        self.fetching = true
        self.fetchList(self.path)
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

    fetchList(path, page) {
      if (path) {
        var url = fetchBaseUrl + '/' + path;
        if (page) {
          url += '?page=' + page;
        }
        self.makeFetch(url).then(function(data) {
          console.log(data)
          self.data = data
          self.update()
        });
      }
    }
  </script>
</hn-list>