From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 0/5] am200epd, pxafb,
	metronomefb changes v8
Date: Wed, 30 Jul 2008 08:51:04 -0400
Message-ID: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOC1S-00010d-Dp for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:22 -0700
Received: from yw-out-1718.google.com ([74.125.46.156])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOC1Q-0001fS-Oz
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Jul 2008 06:47:22 -0700
Received: by yw-out-1718.google.com with SMTP id 6so10226ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 Jul 2008 06:47:20 -0700 (PDT)
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

This is version 8 of this RFC and contains the following updates:
- reorder the patches to put the easy ones first.
- use half size resolutions with 16bpp in am200epd to get the desired
  result in pxafb in order to avoid custom changes in pxafb.
- took out DEBUG

Thanks to Eric and Krzysztof for feedback. I didn't leave Krzysztof's
acked-by on the pxafb patch because I changed the code as mentioned
above. I put Eric's acked-by on the first two that were acked before
and are unchanged from previous.

This RFC consists of patches intended to improve the condition of the
am200epd devkit support. The am200epd devkit contains a gumstix (pxa255) and
a carrier board (am200epd or Lyre), and a metronome display controller.
Previously, there was a drivers/video/am200epd driver that manipulated pxa
LCDC registers and GPSR/GPLR registers directly. That was clearly wrong and
broken so I have removed it and written a new mach-pxa am200epd support
driver.This driver interfaces with pxafb through a set of callbacks to
share/unshare pxafb's framebuffer and achieves the same functionality without
manipulating any pxa registers directly. The patches are split as follows:

metronomefb: convert printk to dev_dbg/err messages
gumstix: conversion to MFP support and add bluetooth support
pxafb: add shared framebuffer interface
am200epd: convert to shared fb and use gpio api
metronomefb: changes to use separate framebuffer

I would be grateful for any feedback and advice.

Thanks,
jaya


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
