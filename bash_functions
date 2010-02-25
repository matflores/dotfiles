# really awesome function, use: cdgem <gem name>, cd's into your gems directory and opens gem that best matches the gem name provided
function cdgem {
  cd /var/lib/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}

# a similar one, this one goes directly to a project's directory
function code {
  cd ~/code; cd `ls|grep $1|sort|tail -1`;
}

# a similar one, this one goes directly to a site's directory
function site {
  cd ~/sites; cd `ls|grep $1|sort|tail -1`
}

# find text in files
function f {
  find $1 | xargs grep $2
}
