From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 0/5] am200epd, pxafb,
	metronomefb changes v6
Date: Sun, 20 Jul 2008 02:10:28 -0400
Message-ID: <1216534233-26674-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKT0O-0001fR-Cs for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 00:06:52 -0700
Received: from wf-out-1314.google.com ([209.85.200.168])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKT0O-0008Gs-3C
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 00:06:52 -0700
Received: by wf-out-1314.google.com with SMTP id 27so979630wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 20 Jul 2008 00:06:51 -0700 (PDT)
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

This is version 6 of this RFC and contains the following updates:
- remove use of clk api for 32k clock and replace with check and set
  in gumstix init code
- avoid exporting am200_device_fb and remove am200epd platform code
- allow am200epd to only be built as a built-in. This allows me to use
  set_pxa_fb_info and removes related issues in other parts of the code.
- change the way we do setup_fb in am200epd so am200epd does not need to
  wait for metronomefb to receive its waveform file from user space.

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
