<hn-list>
  <div class="paging">
    <a if="{ page > 1 }" href="#{ path }/{ page - 1 }" class="prev">< Prev</a>
    <a if="{ page <= 1 }" class="prev disabled">< Prev</a>
    <p>Page { page }</p>
    <a if="{ data.length >= 30 }" href="#{ path }/{ parseInt(page, 10) + 1 }" class="next">Next ></a>
    <a if="{ data.length < 30 }" class="next disabled">Next ></a>
  </div>

  <ul>
    <li each="{ item, index in data }" id="{ id }">
      <span class="index">{ (index + 1) + (30 * (parseInt(page, 10) - 1)) }</span>
      <span class="title">
        <a href="{ item.url }">{ item.title }</a>
        <span class="host">({ item.domain })</span>
      </span>
      <span class="meta">
        <span class="score">{ item.points } points</span>
        <span class="by">by <a href="#/user/{ item.user }">{ item.user }</a></span>
        <span class="time">{ item.time_ago }</span>
        <span class="comments_link">
          | <a href="#item/{ item.id }">{ item.comments_count } comments</a>
        </span>
      </span>
    </li>
  </ul>

  <style>
    :scope {
      background: #eee;
      display: block;
      padding: 16px;
    }

    :scope .paging  {
      display: flex;
      justify-content: space-between;
    }

    :scope ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    :scope ul li {
      position: relative;
      padding: 16px 16px 16px 56px;
      box-sizing: border-box;
      margin: 16px 0;
      border: 1px solid #dedede;
      box-shadow: 0 2px 3px rgba(0,0,0,0.15);
      background: #fff;
    }

    :scope ul li > * {
      display: block;
    }

    :scope .index {
      position: absolute;
      left: 16px;
      top: 50%;
      transform: translateY(-50%);
    }

    :scope .title {
      display: block;
      margin-bottom: 8px; 
    }
  </style>

  <script>
    var self = this
    var fetchBaseUrl = 'https://node-hnapi.herokuapp.com'
    this.fetching = false
    this.data = [];
    this.page = opts.page || 1
    this.path = opts.path || 'top'

    this.on('mount', function() {
      console.log(self.page)

      if (!self.fetching) {
        self.fetching = true
        self.fetchList(self.path, self.page)
      } else {
        self.fetching = false
      }
    })

    this.on('update', function() {
      console.log(self.page)

      if (!self.fetching) {
        self.fetching = true
        self.fetchList(self.path, self.page)
      } else {
        self.fetching = false
      }
    })

    this.on('*', function(eventName) {
      console.info(eventName)
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

    fetchList(path, page) {
      if (path) {
        var url = fetchBaseUrl + '/' + path;
        if (page) {
          url += '?page=' + page;
        }
        self.makeFetch(url).then(function(data) {
          self.data = data
          self.update()
        });
      }
    }
  </script>
</hn-list>