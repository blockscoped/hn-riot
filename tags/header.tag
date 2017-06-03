<hn-header class="hn-header">
  <nav>
    <ul>
      <li each={ views }><a href="#{ route }">{ name }</a></li>
    </ul>
  </nav>

  <style>
    :scope {
      display: flex;
      justify-content: center;
      background: #e41e48;
      color: #fff;
    }

    :scope nav {
      display: inline-block;
    }

    :scope ul {
      list-style: none;
      margin: 0;
      padding: 0;
    }

    :scope ul li {
      display: inline-block;
    }

    :scope ul li a {
      display: block;
      padding: 16px;
      min-width: 80px;
      box-sizing: border-box;
      text-align: center;
      text-decoration: none;
      color: #fff;
    }

    :scope ul li a:hover {
      text-decoration: underline;
    }

    :scope ul li a:active,
    :scope ul li a.active {
      border-bottom: 3px solid fff;
    }
  </style>

  <script type="text/javascript">
    this.views = [
      {name: 'Top', route: 'top'},
      {name: 'New', route: 'news'},
      {name: 'Show', route: 'show'},
      {name: 'Ask', route: 'ask'},
      {name: 'Jobs', route: 'jobs'}
    ]
  </script>
</hn-header>