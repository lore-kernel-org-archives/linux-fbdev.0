From: Jakub Bogusz <qboosh@pld-linux.org>
Subject: [PATCH] fix for fbcon margin colour in 2.6.0-test*
Date: Sat, 6 Dec 2003 02:34:25 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031206013425.GB3914@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xXmbgvnjoT4axfJE"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASRGb-00075f-V6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Dec 2003 17:29:53 -0800
Received: from dm51.neoplus.adsl.tpnet.pl ([80.54.235.51] helo=satan.blackhosts)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1ASRGa-0002vY-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Dec 2003 17:29:53 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I posted this patch to fbdev-devel some time ago, but haven't got any
opinions there.
It sets fbcon margin colour to sane, black value, instead of changing
from time to time depending on background of last erase character
(more details inside).
It was tested by me on tdfxfb and one other person on matroxfb.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-fbcon-margins.patch"

This fixes "margin colour" (colour used to clear margins - e.g. a half of line
at the bottom of 100x37 console on 800x600 framebuffer).

I don't know what was the intention behind using attr_bgcol_ec() here, but it
caused using of background colour of last erase character to clear margins -
which definitely isn't what we want...
This patch changes margin colour to black (or colour 0 in palette modes).

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.0-test2/drivers/video/console/fbcon.c.orig	2003-07-14 05:36:32.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/console/fbcon.c	2003-07-31 00:53:26.000000000 +0200
@@ -502,7 +502,7 @@
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = attr_bgcol_ec(bgshift, vc);
+	region.color = 0;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {

--xXmbgvnjoT4axfJE--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
