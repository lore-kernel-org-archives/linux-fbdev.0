From: Jakub Bogusz <qboosh@pld-linux.org>
Subject: [PATCH 2.6][RESEND] fbcon margins colour fix
Date: Thu, 18 Mar 2004 00:31:35 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040317233135.GB3510@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3kPB-0000Vm-0W
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 15:24:57 -0800
Received: from aea152.neoplus.adsl.tpnet.pl ([83.31.137.152] helo=satan.blackhosts)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B3kP8-0005D6-0R
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 15:24:54 -0800
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
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I sent it a few times to linux-kernel and at least one to
linux-fbdev-devel, but haven't seen any comments - and this annoying
changing margins colour seems to be still there in 2.6.4 (at least on
tdfxfb).


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-fbcon-margins.patch"

This fixes "margin colour" (colour used to clear top and bottom margins -
e.g. remaining half of line at the bottom of 100x37 console on 800x600
framebuffer).

I don't know what was the intention behind using attr_bgcol_ec() here,
but it caused using of background colour of last erase character to clear
margins (thus it was changing from time to time when switching consoles
or so).
I think that margin colour should be equal overscan colour, which seems
to be always black.
This patch changes margin colour to black (or colour 0 in palette modes)
in accel_clear_margins() and removes unused then bgshift variable.

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.4/drivers/video/console/fbcon.c.orig	2004-03-11 03:55:36.000000000 +0100
+++ linux-2.6.4/drivers/video/console/fbcon.c	2004-03-17 20:47:38.749388312 +0100
@@ -489,7 +489,6 @@
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
 				int bottom_only)
 {
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
 	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
@@ -498,7 +497,7 @@
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = attr_bgcol_ec(bgshift, vc);
+	region.color = 0; /* margins color = overscan color */
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {

--jI8keyz6grp/JLjh--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
