From: Antonino Daplas <adaplas@pol.net>
Subject: Adding an fb_sync() operation to fb_ops
Date: Thu, 30 May 2002 19:05:24 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1022899382.561.1.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DVE9-0002yQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 12:04:49 -0700
Received: from [205.136.61.69] (cwc69.compass.com.ph [205.136.61.69])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id DAA38163
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 03:04:45 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I have been tesing the 2.5 API for some time now, and I really like the
new changes.  The trend is to consolidate hardware acceleration into 3
functions, fillrect, copyarea and imageblit.  However, there is still
something bugging me. I don't think we can totally avoid mixing direct
graphics memory access with hardware blitting.  For instance, some
drivers probably will have a mixture of accelerated and unaccelerated
drawing functions which may lock up the graphics engine.

In order to avoid that, should we:

a. Just force a hardware sync after each blit?; or

b. Add a new operation, fb_sync() which will be called whenever the
framebuffer memory will be accessed? fb_sync() should guarantee that the
graphics pipeline has been flushed and that there are no pending
hardware operations.

(a) is probably simpler (matrox is already doing that) but might
decrease performance a bit (not significant since fbcon is dealing with
text)

(b) a bit more complicated, but should not be difficult to add since all
drivers probably has some form of 'wait_for_idle' which can be wrapped. 
Then we can probably just add something like:

if (info->fbops->fb_sync())
	info->fbops->fb_sync(info);

at the top of fb_write and fb_read.

Secondly (not related to the topic), I was wondering if we can change
the color value passed to fillrect and imageblit.  Presently, the
palette index is always passed regardless of the visual. Should the
color value passed be reflective of the framebuffer format instead? 
Pass a palette index if pseudocolor, an RGB value for truecolor, etc.

Doing the latter will simplify the low-level drawing function and at the
same time, it will make the drawing functions more flexible -- ie,
possiblity of exporting to userspace.

Tony 


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
