From: Antonino Daplas <adaplas@pol.net>
Subject: Making drawing functions available to userland
Date: Thu, 30 May 2002 19:05:42 +0000 (UTC)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1022900671.560.2.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17DVEg-00034T-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 May 2002 12:05:23 -0700
Received: from [205.136.61.69] (cwc69.compass.com.ph [205.136.61.69])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id DAA38172
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 May 2002 03:05:19 +0800 (PHT)
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
