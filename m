From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] atyfb: force 29MHz xtal on G3
	PowerBooks (fwd)
Date: Sun, 26 Aug 2007 10:40:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0708261040370.18775@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPDgC-0004CL-Sw for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 01:41:09 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPDgA-00006o-FQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 01:41:08 -0700
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Olaf Hering <olaf@aepfle.de>

---------- Forwarded message ----------
Date: Sat, 25 Aug 2007 11:13:58 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] atyfb: force 29MHz xtal on G3 PowerBooks


The atyfb does not work on my 233MHz PowerBook with Mach64 LP, when the
kernel is booted from firmware. aty_ld_pll_ct() returns 0x22 and xtal
remains at 14.31818. When booted from MacOS, aty_ld_pll_ct() returns 0x3c
and xtal is changed to 29.498928.
Google indicates that all 4 PowerBook models need the higher value.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2411,7 +2411,7 @@ static int __devinit aty_init(struct fb_
 				diff1 = -diff1;
 			if (diff2 < 0)
 				diff2 = -diff2;
-			if (diff2 < diff1) {
+			if (diff2 < diff1 || (M64_HAS(G3_PB_1024x768))) {
 				par->ref_clk_per = 1000000000000ULL / 29498928;
 				xtal = "29.498928";
 			}
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
