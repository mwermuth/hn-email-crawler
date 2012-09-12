require 'rubygems'
require 'ruby-hackernews'
require 'gmail'
require 'mail'
require 'uri'

service = "gmail"

to_mail = "foo@bar.com"
from_mail = "foo@bar.com"
from_pass = "xxxxx"
subject_txt = "Hacker News Daily"


items = RubyHackernews::Entry.all

items.map! do |item|
  {
    :title => item.link.title,
    :site => item.link.site,
    :href => item.link.href,
    :number => item.number,
    :score => item.voting.score,
    :user => item.user.name,
    :comments => item.comments_count,
    :item_id => item.id
  }
end

time = Time.now.gmtime
headline = "#{time.year}-#{sprintf("%.2d", time.month)}-#{sprintf("%.2d", time.mday)}"

html_body ="<h1>Hacker News Daily - #{headline}</h1>" 
html_body += "<ul>"

items.map! do |item|
  unless item[:title].include? 'Ask'
    html_body += "<li>"
    html_body += "<a style='color:grey; text-decoration: none; font-wight:bold;' href=http://www.instapaper.com/hello2?url=#{URI.encode(item[:href])}&title=#{URI.encode(item[:title])}>READ IT LATER</a>"
    html_body += "&nbsp;&nbsp; - &nbsp;&nbsp;<a href=#{item[:href]}>#{item[:title]}</a> &nbsp;&nbsp;<a style='color:grey; text-decoration:none;'>(#{item[:site]})</span>"
    html_body += "</li>"
  end
end

html_body += "</ul>"

if service == "gmail"
  gmail = Gmail.new(from_mail, from_pass)

  gmail.deliver do
    to to_mail
    subject subject_txt
    html_part do
      content_type 'text/html; charset=UTF-8'
      body "#{html_body}"
    end
  end
  gmail.logout

elsif service == "smtp"
  mail = Mail.deliver do
    to      to_mail
    from    from_mail
    subject subject_txt

    html_part do
      content_type 'text/html; charset=UTF-8'
      body "#{html_body}"
    end
  end
  mail.to_s
end


