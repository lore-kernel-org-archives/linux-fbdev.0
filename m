From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH 1/3] fb accel capabilities (radeonfb copyarea() fix)
Date: Thu, 13 May 2004 01:47:46 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405130146300.2282@rosencrantz.theboonies.us>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1085010184.0d1137@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO3NT-0002CO-HX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:43:07 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BO3NT-0008Px-4i
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:43:07 -0700
In-Reply-To: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/12 14:19:47+02:00 eger@rosencrantz.theboonies.us 
#   radeonfb bug fix: screen corruption when copyarea() gets overlapping rectangles
# 
# drivers/video/aty/radeon_accel.c
#   2004/05/12 14:15:32+02:00 eger@rosencrantz.theboonies.us +17 -4
#   radeonfb bug fix: screen corruption when copyarea() gets overlapping rectangles
# 
diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	Wed May 12 15:51:32 2004
+++ b/drivers/video/aty/radeon_accel.c	Wed May 12 15:51:32 2004
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
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
