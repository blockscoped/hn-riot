<app>
  <hn-header></hn-header>

  <route></route>

  <script>
    router.routes([
      new Router.Route({path: 'news/:page', tag: 'hn-list', api: {path: 'news'}}),
      new Router.Route({path: 'newest/:page', tag: 'hn-list', api: {path: 'newest'}}),
      new Router.Route({path: 'show/:page', tag: 'hn-list', api: {path: 'show'}}),
      new Router.Route({path: 'ask/:page', tag: 'hn-list', api: {path: 'ask'}}),
      new Router.Route({path: 'jobs/:page', tag: 'hn-list', api: {path: 'jobs'}}),
      new Router.Route({path: 'item/:id', tag: 'hn-item'}),
      new Router.Route({path: 'user/:id', tag: 'hn-user'}),
      // new Router.DefaultRoute({tag: 'hn-list', api: {path: 'news'}}),
      new Router.RedirectRoute({from: '', to: 'news/1'})
    ])
    router.start()
  </script>
</app>