#Hacker News - Email Crawler

Fetches the frontpage of Hacker News (http://news.ycombinator.com) and will send a mail to you in intervalls you specify.

Additionally each Link in every Email gets an Instapaper "Read it Later" Button next to it. If available other RiL Services can be supported.

Following gems are needed:
<pre>
gem install ruby-hackernews gmail mail uri
</pre>

##Overview
Currently Email delivery works for Gmail and SMTP, should be easy to integrate your own. Just fill out the Variables at the head of the script:

First specify which Mail service you want to use:
<pre>service ="gmail" **or** "smtp"</pre>

Then continue with the following:
<pre>to_mail = "your receiver mail address"</pre>
<pre>from_mail = "your sender mail address"</pre>
<pre>subject = "your mail subject"</pre>

if you use Gmail:
<pre>from_pass = "your password for the sender address"</pre>

If you use SMTP:
<pre>server = "your mail server domain"</pre>

##Cron Job
To let the whole process work automatically for you, just put this script onto your server and create a new cronjob.

Example:
<pre>
crontab -e
0 18 * * * ruby /opt/hncrawler/crawler.rb</pre>
This will call the script every day at 18.00.

##Result
Your Result mail should look like the following:
![HN Daily Mail](http://mwermuth.com/img/hncrawler/hncrawler.png)