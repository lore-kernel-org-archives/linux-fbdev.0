From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb: copyarea() "memmove()"
 problem
Date: Sat, 3 Apr 2004 00:49:06 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404030045230.9840-100000@phoenix.infradead.org>
References: <1080687610.1213.50.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9YPS-0006EM-59
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Apr 2004 15:49:14 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B9YPR-0003NV-C7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 02 Apr 2004 15:49:13 -0800
In-Reply-To: <1080687610.1213.50.camel@gaston>
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
Cc: David Eger <eger-dated-1081179398.a664d4@theboonies.us>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Now that my local kernel actually calls copyarea(), I see that my code was
> > buggy... That is, the hardware needs to be told which way to do its memory
> > copies if areas overlap.  Think of memmove() versus memcpy().  
> > Attached is the fix.
> > 
> > Unfortunately, I think the fbcon layer is also buggy... 
> > (try opening a file with vim, and typing "5ddP"  the copyarea()'s that 
> > get sent to the fb driver seem totally bogus...)
> 
> Excellent. James, any clue about the copyarea issue ?

I have seen this before. The issue comes you when we have over lapping 
areas. The direction you draw in is important. I have a patch that I 
tested. Give this a shot.


diff -urN -X /home/jsimmons/dontdiff fbdev-2.6/drivers/video/aty/radeon_accel.c fbdev-2.5/drivers/video/aty/radeon_accel.c
--- fbdev-2.6/drivers/video/aty/radeon_accel.c	2004-04-02 15:32:04.566209515 -0800
+++ fbdev-2.5/drivers/video/aty/radeon_accel.c	2004-04-02 15:29:06.337306396 -0800
@@ -53,6 +53,9 @@
 static void radeonfb_prim_copyarea(struct radeonfb_info *rinfo, 
 				   const struct fb_copyarea *area)
 {
+	u32 sx = area->sx, sy = area->sy, dx = area->dx, dy = area->dy;
+	u32 flag;
+
 	radeon_fifo_wait(3);
 	OUTREG(DP_GUI_MASTER_CNTL,
 		rinfo->dp_gui_master_cntl /* i.e. GMC_DST_32BPP */
@@ -60,7 +63,24 @@
 		| ROP3_S 
 		| DP_SRC_RECT );
 	OUTREG(DP_WRITE_MSK, 0xffffffff);
-	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
+
+	if (sy < dy) {
+		sy += (area->height - 1);
+		dy += (area->height - 1);
+
+		flag |= DST_Y_BOTTOM_TO_TOP;
+	} else
+		flag |= DST_Y_TOP_TO_BOTTOM;
+
+	if (area->sx < area->dx) {
+		sx += (area->width - 1);
+		dx += (area->width - 1);
+
+		flag |= DST_X_LEFT_TO_RIGHT;
+	} else
+		flag |= DST_X_RIGHT_TO_LEFT;
+
+	OUTREG(DP_CNTL, flag);
 
 	radeon_fifo_wait(3);
 	OUTREG(SRC_Y_X, (area->sy << 16) | area->sx);
diff -urN -X /home/jsimmons/dontdiff fbdev-2.6/drivers/video/aty/radeonfb.h fbdev-2.5/drivers/video/aty/radeonfb.h
--- fbdev-2.6/drivers/video/aty/radeonfb.h	2004-04-02 15:38:57.115407055 -0800
+++ fbdev-2.5/drivers/video/aty/radeonfb.h	2004-04-02 15:35:53.237300302 -0800
@@ -295,8 +295,6 @@
 	struct panel_info	panel_info;
 	int			mon1_type;
 	u8			*mon1_EDID;
-	struct fb_videomode	*mon1_modedb;
-	int			mon1_dbsize;
 	int			mon2_type;
 	u8		        *mon2_EDID;
 
diff -urN -X /home/jsimmons/dontdiff fbdev-2.6/drivers/video/aty/radeon_monitor.c fbdev-2.5/drivers/video/aty/radeon_monitor.c
--- fbdev-2.6/drivers/video/aty/radeon_monitor.c	2004-04-02 15:31:42.854142518 -0800
+++ fbdev-2.5/drivers/video/aty/radeon_monitor.c	2004-04-02 12:09:07.000000000 -0800
@@ -804,12 +804,8 @@
 	/*
 	 * Now build modedb from EDID
 	 */
-	if (rinfo->mon1_EDID) {
-		rinfo->mon1_modedb = fb_create_modedb(rinfo->mon1_EDID,
-						      &rinfo->mon1_dbsize);
+	if (rinfo->mon1_EDID)
 		fb_get_monitor_limits(rinfo->mon1_EDID, &rinfo->info->monspecs);
-	}
-
 	
 	/*
 	 * Finally, if we don't have panel infos we need to figure some (or
@@ -835,8 +831,8 @@
 		}
 		printk(KERN_WARNING "radeonfb: Assuming panel size %dx%d\n",
 		       rinfo->panel_info.xres, rinfo->panel_info.yres);
-		modedb = rinfo->mon1_modedb;
-		dbsize = rinfo->mon1_dbsize;
+		modedb = rinfo->info->monspecs.modedb;
+		dbsize = rinfo->info->monspecs.modedb_len;
 		snprintf(modename, 31, "%dx%d", rinfo->panel_info.xres, rinfo->panel_info.yres);
 		if (fb_find_mode(&rinfo->info->var, rinfo->info, modename,
 				 modedb, dbsize, NULL, 8) == 0) {
@@ -859,7 +855,7 @@
 		else
 			radeon_var_to_videomode(&default_mode, &radeonfb_default_var);
 		if (fb_find_mode(&rinfo->info->var, rinfo->info, mode_option,
-				 rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, 8) == 0)
+				 rinfo->info->monspecs.modedb, rinfo->info->monspecs.modedb_len, &default_mode, 8) == 0)
 			rinfo->info->var = radeonfb_default_var;
 	}
 
@@ -915,9 +911,9 @@
 	memcpy(dest, src, sizeof(struct fb_var_screeninfo));
 
 	/* Check if we have a modedb built from EDID */
-	if (rinfo->mon1_modedb) {
-		db = rinfo->mon1_modedb;
-		dbsize = rinfo->mon1_dbsize;
+	if (rinfo->info->monspecs.modedb) {
+		db = rinfo->info->monspecs.modedb;
+		dbsize = rinfo->info->monspecs.modedb_len;
 		native_db = 1;
 	}
 
@@ -935,7 +931,7 @@
 		 * 640x480-60, but I assume userland knows what it's doing here
 		 * (though I may be proven wrong...)
 		 */
-		if (has_rmx == 0 && rinfo->mon1_modedb)
+		if (has_rmx == 0 && rinfo->info->monspecs.modedb)
 			if (fb_validate_mode((struct fb_var_screeninfo *)src, rinfo->info))
 				return -EINVAL;
 		return 0;




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
