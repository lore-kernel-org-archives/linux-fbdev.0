From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 0/5] am200epd, pxafb,
	metronomefb changes v5
Date: Sun, 13 Jul 2008 09:26:22 -0400
Message-ID: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KI2TV-00059B-6H for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 07:22:53 -0700
Received: from wf-out-1314.google.com ([209.85.200.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KI2TT-00076b-Nk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 07:22:53 -0700
Received: by wf-out-1314.google.com with SMTP id 27so4474071wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 13 Jul 2008 07:22:51 -0700 (PDT)
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

This is version 5 of this RFC and contains the following updates:
- fix unnecessary error assignment
- get rid of unnecessary ifdef's in gpio init
- remove incorrect clk32K disable
- add warning if clk32K is not enabled by bootloader
- combine the move of am200epd to mach-pxa with the conversion to new code
- get rid of use of direct setting of LCCR
- get rid of set_irq_type
- get rid of RTSL
- rebase code to using .26rc9 + linux-2.6-arm.git/pxa

Thanks to Krzysztof and Eric for feedback.

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
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
