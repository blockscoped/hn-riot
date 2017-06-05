<hn-item>
  <header>
    <h1><a href="{ data.url }">{ data.title }</a> <span if="{ data.domain }">({ data.domain })</span></h1>
    <p>{ data.points } points | by <a href="#user/{ data.user }">{ data.user }</a> { data.time_ago }</p>
  </header>

  <section>
    <h4>{ data.comments.length } comments</h4>
    <hr>
    <hn-comment each="{ data.comments }" data="{ this }"></hn-comment>
  </section>

  <style>
    :scope {
      background: #eee;
      display: block;
    }

    :scope header {
      padding: 16px;
      box-sizing: border-box;
      border-bottom: 1px solid #dedede;
      box-shadow: 0 2px 3px rgba(0,0,0,0.15);
      margin-bottom: 16px;
      background: #fff;
    }

    :scope header h1 {
      margin: 0 0 16px 0;
      font-size: 24px;
    }

    :scope section {
      padding: 16px;
      background: #fff;
      border-top: 1px solid #dedede;
    }
  </style>

  <script>
    this.id = opts.id || 'null'

    var self = this
    var fetchBaseUrl = 'https://node-hnapi.herokuapp.com/item/'
    this.fetching = false
    this.data = [];

    this.on('mount', function() {
      if (!self.fetching) {
        self.fetching = true
        self.fetchItem(self.id)
      } else {
        self.fetching = false
      }
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

    unescapeHTML(input) {
      var doc = new DOMParser().parseFromString(input, "text/html");
      return doc.documentElement.textContent;
    }

    formatComment(input) {
      var self = this;
      var content = []
      var paragraphs = input.split(/<p>|<\/p>/)

      paragraphs.forEach(function(paragraph) {
        if (paragraph.length > 0) {
          content.push(self.unescapeHTML(paragraph))
        }
      })

      return content
    }

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
          self.data = data
          self.update()
        });
      }
    }
  </script>
</hn-item>