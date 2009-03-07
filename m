From: Sergey Kvachonok <ravenexp@gmail.com>
Subject: intelfb - full mode switching support on
	laptops - done.
Date: Sat, 7 Mar 2009 22:05:47 +0200
Message-ID: <25a99abe0903071205j5d9c1cbcp971a7af5c8b40313@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ravenexp@gmail.com>) id 1Lg2ma-0002Ft-1B
	for Linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Mar 2009 20:06:04 +0000
Received: from po-out-1718.google.com ([72.14.252.156])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lg2mV-00068p-CC for Linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Mar 2009 20:06:04 +0000
Received: by po-out-1718.google.com with SMTP id y22so2237882pof.2
	for <Linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 07 Mar 2009 12:05:47 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel@lists.sourceforge.net

Not an incremental change over current intelfb 0.9.5(6), so no [PATCH].
Written to make framebuffer work on eee pc (i945GME) with non-standard
1024x600 resolution panel,
as an alternative to ugly 915resolution + uvesafb hack.

My attempts to incorporate something into existing code base, which is
a mess, failed, so version 2 was born.
It uses intelfb as a framework, while most of the code rewritten following
published Intel 965 G35 PRM
(http://intellinuxgraphics.org/documentation.html), xf86-video-intel,
intelfb, in that order.

Version 2 aims for full dualhead support on single device, most modern
chips (mobile) allow it.
Current approach allows having dualhead configuration practically for
free, as most hardware handling code is now dynamic,
which was required to correctly program the pipeline on mobile devices.
Not implemented in this release though.
Hardware acceleration and hardware cursor support are currently broken
and disabled.
Hardware cursor support is practically done, will be back soon. Going
to give up on HW accel altogether,
and hack in overlay mixer support instead, which is about 1e8 times
more useful IMO.
Agpgart supported memory allocation works, but is optional now, with
safe fallback.

Tested in mobile i945GME with integrated panel only, both native and
scaled modes. Conventional analog output should work, but not tested,
as it doesn't enable secondary ports yet and I don't have non-mobile
intel graphics chip. Test applications - fbcon, fbxine, X.
Can't test it on anything else (hardware), so help is needed.

Recommended use as a standalone module only, the code is obviously not
ready for the kernel.

The tarball contains Makefile for a standalone module build, but
depends heavily on kernel Kconfig (inherited from intelfb) and
cfb_* helper modules.
So correct installation order is to compile intelfb shipped with the
kernel as a module, install it, and then separately build and install
standalone intelfb2 over it.
Makefile is a quick hack, as is the build process, any corrections appreciated.

Mobile integrated panel specifics:
Initial mode specification is not required for integrated panel,
driver detects it at startup. mode="" only messes things up.
Mode changes are supported, both bpp and non-native resolution via
panelfitter (upscaling only).

Current driver always builds in debug version, additional "debug"
module command line parameter enables verbose register dumps (many
pages).
Nothing can be diagnosed without it, so always run with "debug" and
send all relevant dmesg output when reporting problems.
Numerous module parameters can help to isolate hangups, like noinit,
noregister, fixed, noagpgart, etc.

Source tarball:
http://intelfb2.googlecode.com/files/intelfb2-1.9.0.tar.gz

Awaiting test reports, corrections, code reviews, swearing, etc.

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
