To Do
=====

## Javascript
- Use first/last 4 words to mark start/end of bs, and then jquery all words to color them brown.
- store bs in evernote, dropbox, or some other bookmarking or text data store api (maybe reddit?)
- EX: my database stores a list of URLs that are bullshit, and when the browser extension finds one, it loads the data from reddit, where the actual text that was called BS is stored (includes the reddit post ID ie: http://www.reddit.com/by_id/t3_6nw57.json, http://www.reddit.com/comments/6nw57.json). JS then parses out that text, and highlights it on the page. Also it loads the comments and vote count from reddit in new UI elements.

## APIs
- Reddit looks really promising, and could be an awesome second entry to popular posts...
  - https://apigee.com/console/reddit
  - https://github.com/reddit/reddit/wiki/API
  - example calls:
      - http://www.reddit.com/by_id/t3_6nw57.json
      - (With comments)[http://www.reddit.com/comments/6nw57.json]
  - They are paranoid about hurting the server though... It would be simple to post
- Github GIST service
- Pastebin
- Evernote
- Dropbox (fairly restricted)
- del.icio.us (yup still exists, but not sure I wanna rely on it...)
- s3, for storage of text and comments?
- http://api.sharefile.com/rest.aspx ???
- http://www.nimbits.com/
- http://pinterest.com/developers/api/
- http://twtmore.com/api (long tweet service)
- http://retroavatar.appspot.com/


## UI
- switch to brown text on white highlight
- Add an indicator with the BS locations down beside the scrollbar, show visible area (like scroll handle), each bullshit can be transparent shade of brown, so that the more people that call bs or comment make the brown darker.
