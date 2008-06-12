From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 0/10] am200epd, pxafb,
	metronomefb changes v4
Date: Thu, 12 Jun 2008 12:59:11 -0400
Message-ID: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6r1z-0003dc-OS for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:56:15 -0700
Received: from yw-out-1718.google.com ([74.125.46.152])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6r1z-00088L-Gh
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:56:15 -0700
Received: by yw-out-1718.google.com with SMTP id 6so2382424ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 10:56:15 -0700 (PDT)
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

This is version 4 of this RFC and contains the following updates:
- split pxafb patch 1 into separate parts as suggested.
- add patch for ifdef in pxafb
- improve failout handling in metronomefb

Thanks to Krzysztof, Eric and Lothar for feedback.

This RFC consists of patches intended to improve the condition of the
am200epd devkit support. The am200epd devkit contains a gumstix (pxa255) and
a carrier board (am200epd or Lyre), and a metronome display controller.
Previously, there was a drivers/video/am200epd driver that manipulated pxa
LCDC registers and GPSR/GPLR registers directly. That was clearly wrong and
broken so I have removed it and written a new mach-pxa am200epd support
driver.This driver interfaces with pxafb through a set of callbacks to
share/unshare pxafb's framebuffer and achieves the same functionality without
manipulating any pxa registers directly. The patches are split as follows:

pxafb: fix ifdef for command line option handling
pxafb: cleanup and fix order of failure handling
pxafb: fix __devinit/exit annotations
pxafb: add exit and remove handlers
pxafb: add shared framebuffer interface
gumstix: conversion to MFP support and add bluetooth support
am200epd: move am200epd to mach-pxa
am200epd: convert to shared fb and use gpio api
metronomefb: convert printk to dev_dbg/err messages
metronomefb: changes to use separate framebuffer

I would be grateful for any feedback and advice.

Thanks,
jaya


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
