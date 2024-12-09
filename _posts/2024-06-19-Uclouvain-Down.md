---
layout: post
title: UCLouvain-Down
subtitle: Monitoring Service of UCLouvain's web tools
gh-repo: Tfloow/UCLouvainDown
thumbnail-img: /assets/img/uclouvain-down/icoDOWN.png
gh-badge: [star, fork, follow]
tags: [personal projects,IT,backend]
comments: true
mathjax: true
author: Thomas Debelle
---

During the exam period of January 2024, many students face various outages of UCLouvain's website leading to a flood of message "is it down for me ?","is my internet the issue ?" or "What the @!#& is going on !!!". That's for all of this reason and the personal challenge a monitoring website appealed me.

## Technology and Design Challenges

For this project, I have used [Flask](https://flask.palletsprojects.com/en/stable/) for building the backend. I had some previous experience using Flask but I've never build anything really useful.

The website is really straightforward to use, you can quickly take a look at all services and see if they are up or not. I use some ultra lightweight HTTP request to query every server and analyze their response. This wasn't an easy task as it may sounds like because the World Wide Web of today is filled with redirection, cache, CDN, ... so I had to consistently adapt and really understand and know about many many HTTP flags to make sure I could send the smallest payload possible while capturing a precise snapshot of the status of every website.

The website is hosted at [Heroku](https://www.heroku.com/) since I had over 200€ of credits through the student pack of Github. I really had the opportunity to have hands-on approaches like this. It was a tad annoying to setup at first and it caused many issues at first. Especially that Heroku web service spawns for the basic plan 2 threads leading to race conditions when querying or writing to the Database !

### Database

I first started using CSV and doing some "archiving" every night at 3 AM, running multiple threads from python to avoid paying for another task in heroku (money is the best incentive for clever implementation). But this way was such hungry in power and memory so I switched to using SQLite which is fantastic in python. Lightweight and the queries don't cost that much.

### Reporting

If you browse on the website you can see some nice and cute little graphs of every status. It wasn't like this until recently. When I thought "How can I draw a plot to quickly see the status", I thought to myself "Use matplotlib !", I was so ignorant ! While matplotlib is really sweet, it was a mess and it would monopolize every resources when plotting every 5 minutes. I also had to face a memory leak of matplotlib. You should always use `plt.close()` after plotting or saving your plot ! Otherwise, matplotlib will keep that in memory forever or until Heroku resets the app everyday at a definite time.

After this experience with matplotlib, I decided to have a more "web-based" approach and used canvas paired with `chart.js`. I would simply query the SQL file and let the user render those results on their end. Much more scalable, prettier and interactive. It embeds the SQL query inside of the web page to dynamically generate the content.

### API

Thanks to [Wouter Vermeulen](https://github.com/VermeulenWouter) who had more experience in web-based python developed, he developed a REST API allowing anyone to embed this monitoring service in any discord bot or any other applications anyone could think of.

## Conclusion

It was such a wonderful project where I had to first develop an idea, scrap some draft and re-iterate over and over until I cam with something sleek and efficient. I have learned so much about networks, hosting, responsive website and backend that he was worth it. If I had to do it all over again, I would have definitely try to use more JavaScript since I used python extensively to try not to use JS leading to some sketchy but functional workaround.

If you like the website or this little blogpost, please consider starring the repo or following me on [Github](https://github.com/Tfloow).
