From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH] radeonfb(): memmove() fix -- this one works ;-)
Date: Mon, 19 Apr 2004 03:46:30 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404190339060.2288@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1082943669.d79d33@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFNma-0006JJ-RN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Apr 2004 18:41:12 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BFNma-0002ut-CQ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Apr 2004 18:41:12 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


Dear Ben,

Please apply this patch to the radeonfb driver (I think of you as the
maintainer for this driver) and then forward to James and Linus :-)

This fixes the same problem as mentioned before -- overlapping
regions sent to copyarea() get fux0r3d.  This patch corrects my earlier
braindamage of setting up w, h, dx, etc. and then forgetting to use them
later on.  Ah, having two versions of the same code (userspace and kernel
space) -- little details like that just float past the eye...  no problem
with fbcon at all, as i previously speculated.  apologies to james.

-David


--- drivers/video/aty/radeon_accel.c.orig	2004-04-19 01:26:52.000000000 +0200
+++ drivers/video/aty/radeon_accel.c	2004-04-19 01:49:14.000000000 +0200
@@ -53,6 +53,18 @@
 static void radeonfb_prim_copyarea(struct radeonfb_info *rinfo, 
 				   const struct fb_copyarea *area)
 {
+	int xdir, ydir;
+	u32 sx, sy, dx, dy, w, h;
+
+	w = area->width; h = area->height;
+	dx = area->dx; dy = area->dy;
+	sx = area->sx; sy = area->sy;
+	xdir = sx - dx;
+	ydir = sy - dy;
+
+	if ( xdir < 0 ) { sx += w-1; dx += w-1; }
+	if ( ydir < 0 ) { sy += h-1; dy += h-1; }
+
 	radeon_fifo_wait(3);
 	OUTREG(DP_GUI_MASTER_CNTL,
 		rinfo->dp_gui_master_cntl /* i.e. GMC_DST_32BPP */
@@ -60,12 +72,13 @@
 		| ROP3_S 
 		| DP_SRC_RECT );
 	OUTREG(DP_WRITE_MSK, 0xffffffff);
-	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
+	OUTREG(DP_CNTL, (xdir>=0 ? DST_X_LEFT_TO_RIGHT : 0)
+			| (ydir>=0 ? DST_Y_TOP_TO_BOTTOM : 0));
 
 	radeon_fifo_wait(3);
-	OUTREG(SRC_Y_X, (area->sy << 16) | area->sx);
-	OUTREG(DST_Y_X, (area->dy << 16) | area->dx);
-	OUTREG(DST_HEIGHT_WIDTH, (area->height << 16) | area->width);
+	OUTREG(SRC_Y_X, (sy << 16) | sx);
+	OUTREG(DST_Y_X, (dy << 16) | dx);
+	OUTREG(DST_HEIGHT_WIDTH, (h << 16) | w);
 }
 
 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
