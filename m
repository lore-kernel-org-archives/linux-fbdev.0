From: David Eger <eger@havoc.gtf.org>
Subject: [PATCH] atyfb accel capabilities
Date: Wed, 2 Jun 2004 22:40:52 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040603024052.GC20951@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BViAD-0002Pu-RL
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:41:05 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BViAD-0007TX-93
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Jun 2004 19:41:05 -0700
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Dear Geert,

The following patch updates atyfb for the new fb accel capabilities
patch I'm sending upstream.  Please test the core patch + this patch,
and let me know it works for you.  You ought to be able to use fbset
to turn the acceleration on and off, though i think the current state
of things is a hack...  sysfs is the way to really do this...

-dte

atyfb (Mach 64): update to advertise acceleration capabilities via fbinfo.flags
    yay fast console!
   
Signed-off-by: David Eger <eger@havoc.gtf.org>

# 
# drivers/video/aty/mach64_gx.c
#   2004/06/02 22:31:14+02:00 eger@rosencrantz.theboonies.us +5 -8
#   atyfb (Mach 64): update to advertise acceleration capabilities via fbinfo.flags
#       yay fast console!
#   
#   Signed-off-by: David Eger <eger@havoc.gtf.org>
#   cc: Geert Uytterhoeven <geert@linux-m68k.org>
# 
# drivers/video/aty/mach64_accel.c
#   2004/06/02 22:31:14+02:00 eger@rosencrantz.theboonies.us +2 -2
#   atyfb (Mach 64): update to advertise acceleration capabilities via fbinfo.flags
#       yay fast console!
#   
#   Signed-off-by: David Eger <eger@havoc.gtf.org>
#   cc: Geert Uytterhoeven <geert@linux-m68k.org>
# 
# drivers/video/aty/atyfb_base.c
#   2004/06/02 22:31:14+02:00 eger@rosencrantz.theboonies.us +20 -14
#   atyfb (Mach 64): update to advertise acceleration capabilities via fbinfo.flags
#       yay fast console!
#   
#   Signed-off-by: David Eger <eger@havoc.gtf.org>
#   cc: Geert Uytterhoeven <geert@linux-m68k.org>
# 
# drivers/video/aty/atyfb.h
#   2004/06/02 22:31:14+02:00 eger@rosencrantz.theboonies.us +1 -2
#   atyfb (Mach 64): update to advertise acceleration capabilities via fbinfo.flags
#       yay fast console!
#   
#   Signed-off-by: David Eger <eger@havoc.gtf.org>
#   cc: Geert Uytterhoeven <geert@linux-m68k.org>
# 
diff -Nru a/drivers/video/aty/atyfb.h b/drivers/video/aty/atyfb.h
--- a/drivers/video/aty/atyfb.h	Wed Jun  2 22:38:17 2004
+++ b/drivers/video/aty/atyfb.h	Wed Jun  2 22:38:17 2004
@@ -79,7 +79,6 @@
 	u8 ram_type;
 	u8 mem_refresh_rate;
 	u8 blitter_may_be_busy;
-	u32 accel_flags;
 #ifdef __sparc__
 	struct pci_mmap_map *mmap_map;
 	u8 mmaped;
@@ -195,7 +194,7 @@
 
 struct aty_dac_ops {
 	int (*set_dac) (const struct fb_info * info,
-			const union aty_pll * pll, u32 bpp, u32 accel);
+			const union aty_pll * pll, u32 bpp);
 };
 
 extern const struct aty_dac_ops aty_dac_ibm514;	/* IBM RGB514 */
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	Wed Jun  2 22:38:17 2004
+++ b/drivers/video/aty/atyfb_base.c	Wed Jun  2 22:38:17 2004
@@ -779,7 +779,12 @@
 					var->bits_per_pixel, &par->pll)))
 		return err;
 
-	par->accel_flags = var->accel_flags;	/* hack */
+#ifdef STUPID_ACCELF_TEXT_SHIT
+	if (var->accel_flags == FB_ACCELF_TEXT)
+		info->flags &= ~FBINFO_HWACCEL_DISABLED;
+	else
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+#endif
 
 	if (par->blitter_may_be_busy)
 		wait_for_idle(par);
@@ -789,8 +794,7 @@
 	/* better call aty_StrobeClock ?? */
 	aty_st_8(CLOCK_CNTL + par->clk_wr_offset, CLOCK_STROBE, par);
 
-	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel,
-			      par->accel_flags);
+	par->dac_ops->set_dac(info, &par->pll, var->bits_per_pixel);
 	par->pll_ops->set_pll(info, &par->pll);
 
 	if (!M64_HAS(INTEGRATED)) {
@@ -850,7 +854,7 @@
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 	/* Initialize the graphics engine */
-	if (par->accel_flags & FB_ACCELF_TEXT)
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED))
 		aty_init_engine(par, info);
 
 #ifdef CONFIG_BOOTX_TEXT
@@ -947,10 +951,6 @@
 				 * correctly.
 				 */
 				var = default_var;
-				if (noaccel)
-					var.accel_flags &= ~FB_ACCELF_TEXT;
-				else
-					var.accel_flags |= FB_ACCELF_TEXT;
 				if (var.yres == var.yres_virtual) {
 					u32 vram =
 					    (info->fix.smem_len -
@@ -1412,7 +1412,7 @@
 			if (par->blitter_may_be_busy)
 				wait_for_idle(par);
 			/* Stop accel engine (stop bus mastering) */
-			if (par->accel_flags & FB_ACCELF_TEXT)
+			if (!(info->flags & FBINFO_HWACCEL_DISABLED))
 				aty_reset_engine(par);
 
 			/* Backup fb content */
@@ -1787,7 +1787,17 @@
 
 	info->fbops = &atyfb_ops;
 	info->pseudo_palette = pseudo_palette;
-	info->flags = FBINFO_FLAG_DEFAULT;
+	info->flags = FBINFO_DEFAULT
+		    | FBINFO_HWACCEL_FILLRECT
+		    | FBINFO_HWACCEL_COPYAREA
+		    | FBINFO_HWACCEL_XPAN
+		    | FBINFO_HWACCEL_YPAN;
+	if (noaccel)
+		info->flags |= FBINFO_HWACCEL_DISABLED;
+
+#ifdef STUPID_ACCELF_TEXT_SHIT
+	var.accel_flags = noaccel ? 0 : FB_ACCELF_TEXT;
+#endif
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if (M64_HAS(G3_PB_1_1) && machine_is_compatible("PowerBook1,1")) {
@@ -1863,10 +1873,6 @@
 #endif				/* !__sparc__ */
 #endif				/* !CONFIG_PPC */
 #endif				/* !MODULE */
-	if (noaccel)
-		var.accel_flags &= ~FB_ACCELF_TEXT;
-	else
-		var.accel_flags |= FB_ACCELF_TEXT;
 
 	if (var.yres == var.yres_virtual) {
 		u32 vram = (info->fix.smem_len - (PAGE_SIZE << 2));
diff -Nru a/drivers/video/aty/mach64_accel.c b/drivers/video/aty/mach64_accel.c
--- a/drivers/video/aty/mach64_accel.c	Wed Jun  2 22:38:17 2004
+++ b/drivers/video/aty/mach64_accel.c	Wed Jun  2 22:38:17 2004
@@ -179,7 +179,7 @@
 
 	if (!area->width || !area->height)
 		return;
-	if (!par->accel_flags) {
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
 		if (par->blitter_may_be_busy)
 			wait_for_idle(par);
 		cfb_copyarea(info, area);
@@ -223,7 +223,7 @@
 
 	if (!rect->width || !rect->height)
 		return;
-	if (!par->accel_flags) {
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
 		if (par->blitter_may_be_busy)
 			wait_for_idle(par);
 		cfb_fillrect(info, rect);
diff -Nru a/drivers/video/aty/mach64_gx.c b/drivers/video/aty/mach64_gx.c
--- a/drivers/video/aty/mach64_gx.c	Wed Jun  2 22:38:17 2004
+++ b/drivers/video/aty/mach64_gx.c	Wed Jun  2 22:38:17 2004
@@ -78,7 +78,7 @@
 }
 
 static int aty_set_dac_514(const struct fb_info *info,
-			   const union aty_pll *pll, u32 bpp, u32 accel)
+			   const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	static struct {
@@ -204,8 +204,7 @@
      */
 
 static int aty_set_dac_ATI68860_B(const struct fb_info *info,
-				  const union aty_pll *pll, u32 bpp,
-				  u32 accel)
+				  const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 gModeReg, devSetupRegA, temp, mask;
@@ -237,7 +236,7 @@
 		break;
 	}
 
-	if (!accel) {
+	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
 		gModeReg = 0x80;
 		devSetupRegA = 0x61;
 	}
@@ -287,8 +286,7 @@
      */
 
 static int aty_set_dac_ATT21C498(const struct fb_info *info,
-				 const union aty_pll *pll, u32 bpp,
-				 u32 accel)
+				 const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 dotClock;
@@ -883,8 +881,7 @@
      */
 
 static int aty_set_dac_unsupported(const struct fb_info *info,
-				   const union aty_pll *pll, u32 bpp,
-				   u32 accel)
+				   const union aty_pll *pll, u32 bpp)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
