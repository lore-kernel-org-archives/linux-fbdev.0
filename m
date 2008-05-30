From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 0/5] am200epd, pxafb,
	metronomefb changes
Date: Fri, 30 May 2008 08:28:45 -0400
Message-ID: <1212150530-14941-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K24cJ-00039x-FZ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 06:25:59 -0700
Received: from wf-out-1314.google.com ([209.85.200.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K24cI-0002k6-59
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 May 2008 06:25:59 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3329168wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 30 May 2008 06:25:57 -0700 (PDT)
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

This RFC consists of five patches intended to improve the condition of the
am200epd devkit support. The am200epd devkit contains a gumstix (pxa255) and
a carrier board (am200epd or Lyre), and a metronome display controller.
Previously, there was a drivers/video/am200epd driver that manipulated pxa
LCDC registers and GPSR/GPLR registers directly. That was clearly wrong so I
have removed it and written a new mach-pxa am200epd support driver. This
driver interfaces with pxafb through a set of callbacks to share/unshare
pxafb's framebuffer and achieve the same functionality without manipulating
any pxa registers directly. The patches are split as follows:

1 pxafb: module unloading support
2 pxafb: add shared framebuffer interface
3 gumstix: conversion to MFP support and add bluetooth support
4 am200epd: remove am200epd platform device driver
5 am200epd: add mach-pxa support for am200epd

I would be grateful for any feedback and advice.

Thanks,
jaya


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
