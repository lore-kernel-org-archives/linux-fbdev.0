From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
Subject: RE: Making drawing functions available to use
	rland
Date: Thu, 30 May 2002 14:34:52 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <2B4461BF89BAD511A86100508B66D53802080A37@fmsmsx112.fm.intel.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from fmr02.intel.com ([192.55.52.25] helo=caduceus.fm.intel.com)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DXZP-0007X4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 14:34:55 -0700
Received: from talaria.fm.intel.com (talaria.fm.intel.com [10.1.192.39])
	by caduceus.fm.intel.com (8.11.6/8.11.6/d: outer.mc,v 1.48 2002/05/24 00:39:04 root Exp $) with ESMTP id g4ULXS524710
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 21:33:28 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxv043-1.fm.intel.com [132.233.48.128])
	by talaria.fm.intel.com (8.11.6/8.11.6/d: inner.mc,v 1.22 2002/05/24 00:38:22 root Exp $) with SMTP id g4ULcTn29743
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 21:38:29 GMT
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


If you expose the basic blit acceleration functions then there shouldn't be
any reason not to have the device independent fbdev X driver use them.
However, I would stop there. Any function that is not very easily supported
by nearly all fb drivers (Basically anything that isn't a blit) should not
be used in the fbdev driver.

If you want to have a full featured X driver (with Xv etc. ) then you need a
device dependent X driver just as you have now. Instead of the device
dependent driver touching the hardware directly it would just go through a
very thin ioctl (a device dependent one).
This is very similar to how the DRI/DRM work.

There should not be concern for "locking the kernel" If you can't make the
ioctl safe for application use then you shouldn't make it available.
Basically there is no good reason you can't make very thin device dependent
ioctls that can't be abused. The DRM's do this quite well.  During
development is the only time when you have a greater risk of hanging the
kernel... and that is only slightly more catastrophic than wedging the
graphics engine from user-space anyway.

-Matt


-----Original Message-----
From: Antonino Daplas [mailto:adaplas@pol.net]
Sent: Friday, May 31, 2002 8:08 PM
To: fbdev
Subject: [Linux-fbdev-devel] Making drawing functions available to
userland


Hi again,

In my other e-mail, I touched on the possibility of exporting the
drawing functions to userspace.  Actually, I was delving a little on
that.  I added 3 IOCTLS (FBIO_DOACCEL, FBIO_GETCAPABILITIES, and
FBIOSYNC) to the fb API (2.5.19) whose main functions are to describe
the drawing capability of the driver and making them accessible to
userland.  To test that, I added XAA and DGA to XFree86 fbdev and
fbdevhw driver. Here's a part of the XFree86 log:

<<< cut >>>
 (**) FBDEV(0): Enabling Acceleration
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.2.0, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.5
(II) FBDEV(0): Using fillrect for SolidFill.
(II) FBDEV(0): Using copyarea for ScreenToScreenCopy.
(II) FBDEV(0): Using imageblit for Mono8x8PatternFill.
(II) FBDEV(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Solid Horizontal and Vertical Lines
<<< cut >>>

I'm not really going to push for this since I already recognize a few
difficulties.  Firstly, making the drawing functions accessible will
increase the likelihood of crashing the kernel.  Secondly, people might
not remain contented and add more functionality increasing kernel bloat.

Anyways, any thoughts on this?

Tony
---------------------------------------------------------------------

PS: A few benchmarks...

XFBDev - no accel
=================

36000 reps @   0.1407 msec (  7110.0/sec): 100x100 rectangle

18000 reps @   0.3206 msec (  3120.0/sec): 100x100 opaque stippled
rectangle (8x8 stipple)

32000 reps @   0.1713 msec (  5840.0/sec): Copy 100x100 from window to
window

XFBDev - accel
==============

144000 reps @   0.0422 msec ( 23700.0/sec): 100x100 rectangle

18000 reps @   0.3010 msec (  3320.0/sec): 100x100 opaque stippled
rectangle (8x8 stipple)

80000 reps @   0.1026 msec (  9750.0/sec): Copy 100x100 from window to
window

native i810_drv
===============

144000 reps @   0.0428 msec ( 23300.0/sec): 100x100 rectangle

144000 reps @   0.0429 msec ( 23300.0/sec): 100x100 opaque stippled
rectangle (8x8 stipple)

80000 reps @   0.1060 msec (  9430.0/sec): Copy 100x100 from window to
window





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
