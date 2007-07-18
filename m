From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Text console scrolling
Date: Thu, 19 Jul 2007 00:08:56 +0800
Message-ID: <1184774936.4523.64.camel@daplas>
References: <Pine.LNX.4.62.0707181708020.15632@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBC5c-00009c-Ax for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 09:09:24 -0700
Received: from nz-out-0506.google.com ([64.233.162.233])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IBC5a-0005KB-Oa
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 09:09:24 -0700
Received: by nz-out-0506.google.com with SMTP id f1so550150nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Jul 2007 09:09:21 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0707181708020.15632@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Geert.Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>

On Wed, 2007-07-18 at 17:10 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> Yesterday, FBINFO_READS_FAST was faster in some cases, but much slower in
> others, so I didn't really know whether I should enable it or not.
> 
> Today, FBINFO_READS_FAST is faster in all test cases, so the choice is clear.
> 

The improvement of scroll_move is courtesy of Ondrej's smart blitter
patch. Basically, it only does an actual move if the content of the
source is different from the destination.  If the source == destination,
the actual move is skipped.
 
> Note that there are still a few cases where today's fastest option is a bit
> slower than yesterday's fastest option.
> 

All things equal, the speed of the smart blitter will depend on:

1. the amount of text to be scrolled;
2. the difference of the content of the screen to be scrolled and of the
contents of the screen to be scrolled into; and 
3. the amount of time the cpu spends for the comparison.

The less different the contents, the more the smart blitter will speed
up (because less characters are actually moved). If the contents are
totally different, then the blitter spends as much time as the old
(dumb) blitter plus the time spent on the compare. 

For the old (dumb) scroll_move, the scrolling speed is only dependent on
the amount of text to be scrolled. No cpu time is spent on the compare.

For the most common usage (screen has lots of whitespaces and blank
lines), I bet the smart blitter will perform very well.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
