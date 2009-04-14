From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: s1d13xxxfb adding fillrect acceleration,
	but out of range requests
Date: Tue, 14 Apr 2009 18:58:53 +0200
Message-ID: <20090414185853.3263267e.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1LtljO-0003j7-Ja
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Apr 2009 16:43:30 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LtljA-00085Y-Hf for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 14 Apr 2009 16:43:25 +0000
Received: by fxm25 with SMTP id 25so2680729fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 14 Apr 2009 09:43:14 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Greetings,

Somewhat confused atm. I added a function to handle hardware accelerated
fill rect and replaced the cfb with that one.
What Im seeing now is that it works outside the normal xres,yres range
(got 640x240 on my jornada). 

So in essence Im getting requests for fill_rect that are outside
my screen. Is there something im missing here?

I almost suspect that I should divide the dy and dx with 8, but
that would cripple it for xorg?

Strangly enough Im not getting any garbage on my
screen....??


example from my debug log :
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=256, stride=1280, dest=327680
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=264, stride=1280, dest=337920
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=272, stride=1280, dest=348160
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=280, stride=1280, dest=358400
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=288, stride=1280, dest=368640
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=296, stride=1280, dest=378880
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=304, stride=1280, dest=389120
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=312, stride=1280, dest=399360
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=320, stride=1280, dest=409600
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=328, stride=1280, dest=419840
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt : request solid_fill
         dx=0, dy=336, stride=1280, dest=430080
         rect_width=640, rect_height=8
s1d13xxxfb_bitblt : xres=640, yres=240, bpp=16


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
