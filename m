From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 0/5] am200epd, pxafb,
	metronomefb changes v7
Date: Sat, 26 Jul 2008 00:32:49 -0400
Message-ID: <1217046774-13080-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KMcL9-000424-Ix for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jul 2008 22:29:11 -0700
Received: from ti-out-0910.google.com ([209.85.142.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KMcL7-00084O-KN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jul 2008 22:29:11 -0700
Received: by ti-out-0910.google.com with SMTP id y6so2036672tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 25 Jul 2008 22:29:07 -0700 (PDT)
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
To: ymiao3@marvell.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk


Hi Eric, arm and fbdev friends,

This is version 7 of this RFC and contains the following updates:
- replace custom transfer sizes with customized bpp custom_lccr_bpp.
  Improved comments for what the changes do.
- add gpio_request for BTRST pin in gumstix_bluetooth_init

Thanks to Eric and Russell for feedback.
I will take out DEBUG before final.

This RFC consists of patches intended to improve the condition of the
am200epd devkit support. The am200epd devkit contains a gumstix (pxa255) and
a carrier board (am200epd or Lyre), and a metronome display controller.
Previously, there was a drivers/video/am200epd driver that manipulated pxa
LCDC registers and GPSR/GPLR registers directly. That was clearly wrong and
broken so I have removed it and written a new mach-pxa am200epd support
driver.This driver interfaces with pxafb through a set of callbacks to
share/unshare pxafb's framebuffer and achieves the same functionality without
manipulating any pxa registers directly. The patches are split as follows:

pxafb: add shared framebuffer interface
gumstix: conversion to MFP support and add bluetooth support
am200epd: convert to shared fb and use gpio api
metronomefb: convert printk to dev_dbg/err messages
metronomefb: changes to use separate framebuffer

I would be grateful for any feedback and advice.

Thanks,
jaya


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
