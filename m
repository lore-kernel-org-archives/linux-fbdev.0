From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] radeonfb accel capabilities
Date: Wed, 2 Jun 2004 22:38:35 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040603023835.GB20951@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVi7u-00024k-Cm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:38:42 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BVi7t-0001wY-Uh
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:38:42 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Dear Ben,

The following patch updates radeonfb for the new fb accel capabilities
patch I'm sending upstream.  I've tested this on my box, and it gives me
a nice fast console.  Please apply and send up stream once Andrew accepts
the core patch.

defect: "$ fbset -accel 0" doesn't work for radeonfb -- disabling accel
will only work from the kernel boot argument :-/

-dte

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/05/30 12:30:12+02:00 eger@rosencrantz.theboonies.us 
#   Update radeonfb to advertise its acceleration capabilities via fbinfo.flags
#     yay fast console!
#
#	 Signed-off-by: David Eger <eger@havoc.gtf.org>
#	 cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
# 
diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	Sun May 30 12:32:10 2004
+++ b/drivers/video/aty/radeon_accel.c	Sun May 30 12:32:10 2004
@@ -30,7 +30,7 @@
   
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	if (radeon_accel_disabled()) {
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
 		cfb_fillrect(info, region);
 		return;
 	}
@@ -96,7 +96,7 @@
   
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	if (radeon_accel_disabled()) {
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
 		cfb_copyarea(info, area);
 		return;
 	}
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	Sun May 30 12:32:10 2004
+++ b/drivers/video/aty/radeon_base.c	Sun May 30 12:32:10 2004
diff -Nru a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
@@ -242,8 +242,6 @@
 static int nomtrr = 0;
 #endif
 
-int radeonfb_noaccel = 0;
-
 /*
  * prototypes
  */
@@ -810,9 +808,8 @@
 	/* XXX I'm adjusting xres_virtual to the pitch, that may help XFree
 	 * with some panels, though I don't quite like this solution
 	 */
-  	if (radeon_accel_disabled()) {
+  	if (rinfo->info->flags & FBINFO_HWACCEL_DISABLED) {
 		v.xres_virtual = v.xres_virtual & ~7ul;
-		v.accel_flags = 0;
 	} else {
 		pitch = ((v.xres_virtual * ((v.bits_per_pixel + 1) / 8) + 0x3f)
  				& ~(0x3f)) >> 6;
@@ -1524,7 +1521,7 @@
 	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
-	if (!radeon_accel_disabled()) {
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
 		/* We first calculate the engine pitch */
 		rinfo->pitch = ((mode->xres_virtual * ((mode->bits_per_pixel + 1) / 8) + 0x3f)
  				& ~(0x3f)) >> 6;
@@ -1672,12 +1669,11 @@
 	if (!rinfo->asleep) {
 		radeon_write_mode (rinfo, &newmode);
 		/* (re)initialize the engine */
-		if (!radeon_accel_disabled())
+		if (!(info->flags & FBINFO_HWACCEL_DISABLED))
 			radeonfb_engine_init (rinfo);
-	
 	}
 	/* Update fix */
-	if (!radeon_accel_disabled())
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED))
         	info->fix.line_length = rinfo->pitch*64;
         else
 		info->fix.line_length = mode->xres_virtual
@@ -1782,9 +1778,13 @@
 	info->currcon = -1;
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
-        info->flags = FBINFO_FLAG_DEFAULT;
-        info->fbops = &radeonfb_ops;
-        info->screen_base = (char *)rinfo->fb_base;
+	info->flags = FBINFO_DEFAULT
+		    | FBINFO_HWACCEL_COPYAREA
+		    | FBINFO_HWACCEL_FILLRECT
+		    | FBINFO_HWACCEL_XPAN
+		    | FBINFO_HWACCEL_YPAN;
+	info->fbops = &radeonfb_ops;
+	info->screen_base = (char *)rinfo->fb_base;
 
 	/* Fill fix common fields */
 	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
@@ -1798,17 +1798,11 @@
         info->fix.type_aux = 0;
         info->fix.mmio_start = rinfo->mmio_base_phys;
         info->fix.mmio_len = RADEON_REGSIZE;
-	if (radeon_accel_disabled())
-	        info->fix.accel = FB_ACCEL_NONE;
-	else
-		info->fix.accel = FB_ACCEL_ATI_RADEON;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
-
-	if (radeon_accel_disabled())
-		info->var.accel_flags &= ~FB_ACCELF_TEXT;
-	else
-		info->var.accel_flags |= FB_ACCELF_TEXT;
+	
+	if (noaccel)
+		info->flags |= FBINFO_HWACCEL_DISABLED;
 
         return 0;
 }
@@ -2424,7 +2418,6 @@
 
 int __init radeonfb_init (void)
 {
-	radeonfb_noaccel = noaccel;
 	return pci_module_init (&radeonfb_driver);
 }
 
@@ -2446,7 +2439,7 @@
 			continue;
 
 		if (!strncmp(this_opt, "noaccel", 7)) {
-			noaccel = radeonfb_noaccel = 1;
+			noaccel = 1;
 		} else if (!strncmp(this_opt, "mirror", 6)) {
 			mirror = 1;
 		} else if (!strncmp(this_opt, "force_dfp", 9)) {
--- a/drivers/video/aty/radeon_pm.c	Sun May 30 12:32:10 2004
+++ b/drivers/video/aty/radeon_pm.c	Sun May 30 12:32:10 2004
@@ -859,7 +859,7 @@
 
 	fb_set_suspend(info, 1);
 
-	if (!radeon_accel_disabled()) {
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
 		/* Make sure engine is reset */
 		radeon_engine_idle();
 		radeonfb_engine_reset(rinfo);
diff -Nru a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
--- a/drivers/video/aty/radeonfb.h	Sun May 30 12:32:10 2004
+++ b/drivers/video/aty/radeonfb.h	Sun May 30 12:32:10 2004
@@ -516,12 +516,6 @@
 	printk(KERN_ERR "radeonfb: Idle Timeout !\n");
 }
 
-static inline int radeon_accel_disabled(void)
-{
-	extern int radeonfb_noaccel;
-	return radeonfb_noaccel;
-}
-
 #define radeon_engine_idle()		_radeon_engine_idle(rinfo)
 #define radeon_fifo_wait(entries)	_radeon_fifo_wait(rinfo,entries)
 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
