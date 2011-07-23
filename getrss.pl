#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;
use XML::RSS;
use Time::Local;

my $feed_url = 'http://hpv.cc/~maty/pukiwiki1/index.php?cmd=rss&ver=1.0';
my $input = get($feed_url);

my $rss = XML::RSS->new;

# feed parse
$rss->parse($input);

# 1day ago
my $onedayago = time() - 86400;

for (@{$rss->{items}}) {

  # rss unixtime
  my $rss_time = timelocal(substr($_->{dc}->{date}, 17, 2 ),
                           substr($_->{dc}->{date}, 14, 2 ),
                           substr($_->{dc}->{date}, 11, 2 ),
                           substr($_->{dc}->{date},  8, 2 ),
                           substr($_->{dc}->{date},  5, 2 )-1,
                           substr($_->{dc}->{date},  0, 4 )-1900);

  # new post only
  if($rss_time >= $onedayago ){
    print "$_->{title}\n";
    print "$_->{link}\n";


  }
}

__END__
rss を取得し，1日以内の更新のtitle/url を表示
