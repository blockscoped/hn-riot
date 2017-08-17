<hn-comment>
  <div class="by">
    <a href="#user/{ data.user }">{ user }</a>
    <a href="#item/{ data.id }">{ time_ago }</a>
  </div>

  <div class="text">
    <p each={ string, i in formatComment(data.content) }>{ string }</p>
  </div>

  <div class="comments" if="{ data.comments.length }">
    <input type="checkbox" name="show-comments" value="">
    <span class="comment-toggle">
      <span>{ data.comments.length } replies collapsed</span>
    </span>
    <hn-comment each="{ data.comments }" data="{ this }"></hn-comment>
  </div>

  <style>
    :scope {
      display: block;
      padding: 16px 0;
      margin-top: -8px;
      border-top: 1px solid #dedede;
    }

    :scope .by {
      margin-bottom: 8px;
    }

    :scope .comments {
      position: relative;
      margin-top: 8px;
    }

    :scope input[type=checkbox] {
      opacity: 0;
      width: 18px;
      height: 18px;
      top: 0;
      left: 0;
      margin: 0;
      position: absolute;;
      z-index: 2;
      cursor: pointer;
    }

    :scope .comment-toggle > span{
      display: none;
    }

    :scope .comment-toggle:before {
      content: '[\2013]';
    }

    :scope input[type=checkbox]:checked ~ .comment-toggle:before {
      content: '[+]';
    }

    :scope input[type=checkbox]:checked ~ .comment-toggle > span {
      display: inline;
    }

    :scope input[type=checkbox]:checked ~ hn-comment {
      display: none;
    }

    hn-comment hn-comment {
      margin-left: 24px;
    }
  </style>

  <script>
    this.data = opts.data || []

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
  </script>
</hn-comment>