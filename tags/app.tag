<app>
  <hn-header></hn-header>

  <route></route>

  <script>
    router.routes([
      new Router.Route({path: 'top', tag: 'hn-list', api: {path: 'news'}}),
      new Router.Route({path: 'news', tag: 'hn-list', api: {path: 'newest'}}),
      new Router.Route({path: 'show', tag: 'hn-list', api: {path: 'show'}}),
      new Router.Route({path: 'ask', tag: 'hn-list', api: {path: 'ask'}}),
      new Router.Route({path: 'jobs', tag: 'hn-list', api: {path: 'jobs'}}),
      new Router.Route({path: 'item/:id', tag: 'hn-item'}),
      new Router.Route({path: 'user/:id', tag: 'hn-user'}),
      new Router.DefaultRoute({tag: 'hn-stage', api: {path: 'top'}})
    ])
    router.start()
  </script>
</app>