From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Subject: RE: Adding an fb_sync() operation to fb_ops
Date: Thu, 30 May 2002 14:25:49 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2B4461BF89BAD511A86100508B66D53802080A35@fmsmsx112.fm.intel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from fmr01.intel.com ([192.55.52.18] helo=hermes.fm.intel.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DXQh-0006fv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 14:25:55 -0700
Received: from petasus.fm.intel.com (petasus.fm.intel.com [10.1.192.37])
	by hermes.fm.intel.com (8.11.6/8.11.6/d: outer.mc,v 1.48 2002/05/24 00:39:04 root Exp $) with ESMTP id g4ULQOY06708
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 21:26:24 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxv042-1.fm.intel.com [132.233.48.110])
	by petasus.fm.intel.com (8.11.6/8.11.6/d: inner.mc,v 1.22 2002/05/24 00:38:22 root Exp $) with SMTP id g4ULNre19907
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 21:23:53 GMT
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
Content-Transfer-Encoding: 7bit
To: 'Antonino Daplas' <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


I agree, I have some API's that I've been using for embedded applications
and it always seems that if you allow mmap() you must have a sync()
function. (A flush is nice too but not required)

If you are going to allow user apps to drive the blitter you don't want to
force a sync after each call. An application that is doing a lot of blitting
would be wasting lots of time syncing when there is only need for just one
sync at the end. The whole point of ring buffers is to pipeline
instructions, you'd loose this if you always synced.

-Matt



-----Original Message-----
From: Antonino Daplas [mailto:adaplas@pol.net]
Sent: Friday, May 31, 2002 8:07 PM
To: fbdev
Subject: [Linux-fbdev-devel] Adding an fb_sync() operation to fb_ops


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

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
