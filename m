From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 0/7] am200epd, pxafb,
	metronomefb changes v3
Date: Sat,  7 Jun 2008 00:49:19 -0400
Message-ID: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4rG4-0006Ii-AF for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 22:46:32 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4rG3-0006CT-1w
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 22:46:32 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1257559wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 06 Jun 2008 22:46:30 -0700 (PDT)
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

This is version 3 of this RFC and contains the following updates:
- split patch 5 into parts. trivial changes to printk are now in
  patch 6. real changes in patch 7.
- rather than remove am200epd, patch 4 now only moves it. patch 5
  then makes the relevant changes.
- fix various failout cases and order of cleanup

Thanks to Krzysztof for feedback.

This RFC consists of patches intended to improve the condition of the
am200epd devkit support. The am200epd devkit contains a gumstix (pxa255) and
a carrier board (am200epd or Lyre), and a metronome display controller.
Previously, there was a drivers/video/am200epd driver that manipulated pxa
LCDC registers and GPSR/GPLR registers directly. That was clearly wrong and
broken so I have removed it and written a new mach-pxa am200epd support
driver.This driver interfaces with pxafb through a set of callbacks to
share/unshare pxafb's framebuffer and achieve the same functionality without
manipulating any pxa registers directly. The patches are split as follows:

1   pxafb: module unloading support
2   pxafb: add shared framebuffer interface
3   gumstix: conversion to MFP support and add bluetooth support
4   am200epd: move am200epd to mach-pxa
5   am200epd: convert to shared fb and use gpio api
6   metronomefb: convert printk to dev_dbg/err messages
7   metronomefb: changes to use separate framebuffer

I would be grateful for any feedback and advice.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
