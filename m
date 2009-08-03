From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 0/5] matroxfb: Code cleanups
Date: Mon, 3 Aug 2009 21:52:21 +0200
Message-ID: <20090803215221.2380276c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <khali@linux-fr.org>) id 1MY3qL-0007d7-KB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Aug 2009 20:09:13 +0000
Received: from poutre.nerim.net ([62.4.16.124])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MY3qH-00007s-4j for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 03 Aug 2009 20:09:13 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Petr,

This is a 5-piece patchset cleaning up the matroxfb driver:

[PATCH 1/5] matroxfb: Make CONFIG_FB_MATROX_MULTIHEAD=y mandatory
[PATCH 2/5] matroxfb: Get rid of unneeded macros ACCESS_FBINFO and MINFO
[PATCH 3/5] matroxfb: Get rid of unneeded macros WPMINFO and friends
[PATCH 4/5] matroxfb: Get rid of unneeded macro MINFO_FROM
[PATCH 5/5] matroxfb: Get rid of CONFIG_FB_MATROX_32MB

 Documentation/fb/matroxfb.txt           |    4 
 drivers/video/Kconfig                   |   20 
 drivers/video/matrox/g450_pll.c         |  209 ++++----
 drivers/video/matrox/g450_pll.h         |    8 
 drivers/video/matrox/i2c-matroxfb.c     |   18 
 drivers/video/matrox/matroxfb_DAC1064.c |  616 +++++++++++++------------
 drivers/video/matrox/matroxfb_DAC1064.h |    4 
 drivers/video/matrox/matroxfb_Ti3026.c  |  260 +++++-----
 drivers/video/matrox/matroxfb_accel.c   |  129 ++---
 drivers/video/matrox/matroxfb_accel.h   |    2 
 drivers/video/matrox/matroxfb_base.c    |  770 +++++++++++++++-----------------
 drivers/video/matrox/matroxfb_base.h    |   80 ---
 drivers/video/matrox/matroxfb_crtc2.c   |  160 +++---
 drivers/video/matrox/matroxfb_g450.c    |  185 ++++---
 drivers/video/matrox/matroxfb_g450.h    |    8 
 drivers/video/matrox/matroxfb_maven.c   |   48 +
 drivers/video/matrox/matroxfb_misc.c    |  296 ++++++------
 drivers/video/matrox/matroxfb_misc.h    |   15 
 18 files changed, 1436 insertions(+), 1396 deletions(-)

The diffstat is impressive, but that's really only mecanical changes
being applied driver-wide. There's no actual code change and there
should be zero runtime difference before and after the patchset. I've
tested it on my Millennium to make sure.

-- 
Jean Delvare

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
