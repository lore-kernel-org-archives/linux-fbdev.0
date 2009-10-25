From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fb: remove fb_save_state() and
 fb_restore_state operations (bug #11248)
Date: Sun, 25 Oct 2009 17:00:22 +0100
Message-ID: <20091025170022.70d61190.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1N25FK-0005C1-ED
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Oct 2009 15:43:06 +0000
Received: from smtp240.poczta.interia.pl ([217.74.64.240])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N25FD-0004Ca-JL for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Oct 2009 15:43:06 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Januszewski <spock@gentoo.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove fb_save_state() and fb_restore_state operations from frame buffer layer.
They are used only in two drivers:
1. savagefb  - and cause bug #11248
2. uvesafb

Usage of these operations is misunderstood in both drivers so kill these operations,
fix the bug #11248 and avoid confusion in the future.

Tested on Savage 3D/MV card and the patch fixes the bug #11248.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
The frame buffer layer uses these funtions during switch between graphics and text 
mode of the console, but these drivers saves state before switching of the frame buffer
(in the fb_open) and after releasing it (in the fb_release). This defeats the purpose of
these operations.

diff --git a/drivers/video/atafb.c b/drivers/video/atafb.c
index 8cd279b..b7687c5 100644
--- a/drivers/video/atafb.c
+++ b/drivers/video/atafb.c
@@ -329,12 +329,6 @@ extern unsigned char fontdata_8x16[];
  *
  *	* perform fb specific mmap *
  *	int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
- *
- *	* save current hardware state *
- *	void (*fb_save_state)(struct fb_info *info);
- *
- *	* restore saved state *
- *	void (*fb_restore_state)(struct fb_info *info);
  * } ;
  */
 
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 5a686ce..3681c6a 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -2311,14 +2311,11 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 		ops->graphics = 1;
 
 		if (!blank) {
-			if (info->fbops->fb_save_state)
-				info->fbops->fb_save_state(info);
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
 			fb_set_var(info, &var);
 			ops->graphics = 0;
 			ops->var = info->var;
-		} else if (info->fbops->fb_restore_state)
-			info->fbops->fb_restore_state(info);
+		}
 	}
 
  	if (!fbcon_is_inactive(vc, info)) {
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 37b135d..0857b3b 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1606,22 +1606,6 @@ static int savagefb_blank(int blank, struct fb_info *info)
 	return (blank == FB_BLANK_NORMAL) ? 1 : 0;
 }
 
-static void savagefb_save_state(struct fb_info *info)
-{
-	struct savagefb_par *par = info->par;
-
-	savage_get_default_par(par, &par->save);
-}
-
-static void savagefb_restore_state(struct fb_info *info)
-{
-	struct savagefb_par *par = info->par;
-
-	savagefb_blank(FB_BLANK_POWERDOWN, info);
-	savage_set_default_par(par, &par->save);
-	savagefb_blank(FB_BLANK_UNBLANK, info);
-}
-
 static int savagefb_open(struct fb_info *info, int user)
 {
 	struct savagefb_par *par = info->par;
@@ -1667,8 +1651,6 @@ static struct fb_ops savagefb_ops = {
 	.fb_setcolreg   = savagefb_setcolreg,
 	.fb_pan_display = savagefb_pan_display,
 	.fb_blank       = savagefb_blank,
-	.fb_save_state  = savagefb_save_state,
-	.fb_restore_state = savagefb_restore_state,
 #if defined(CONFIG_FB_SAVAGE_ACCEL)
 	.fb_fillrect    = savagefb_fillrect,
 	.fb_copyarea    = savagefb_copyarea,
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index e35232a..54fbb29 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -1411,23 +1411,6 @@ static int uvesafb_check_var(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-static void uvesafb_save_state(struct fb_info *info)
-{
-	struct uvesafb_par *par = info->par;
-
-	if (par->vbe_state_saved)
-		kfree(par->vbe_state_saved);
-
-	par->vbe_state_saved = uvesafb_vbe_state_save(par);
-}
-
-static void uvesafb_restore_state(struct fb_info *info)
-{
-	struct uvesafb_par *par = info->par;
-
-	uvesafb_vbe_state_restore(par, par->vbe_state_saved);
-}
-
 static struct fb_ops uvesafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= uvesafb_open,
@@ -1441,8 +1424,6 @@ static struct fb_ops uvesafb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 	.fb_check_var	= uvesafb_check_var,
 	.fb_set_par	= uvesafb_set_par,
-	.fb_save_state	= uvesafb_save_state,
-	.fb_restore_state = uvesafb_restore_state,
 };
 
 static void __devinit uvesafb_init_info(struct fb_info *info,
@@ -1459,15 +1440,6 @@ static void __devinit uvesafb_init_info(struct fb_info *info,
 	info->fix.ypanstep = par->ypan ? 1 : 0;
 	info->fix.ywrapstep = (par->ypan > 1) ? 1 : 0;
 
-	/*
-	 * If we were unable to get the state buffer size, disable
-	 * functions for saving and restoring the hardware state.
-	 */
-	if (par->vbe_state_size == 0) {
-		info->fbops->fb_save_state = NULL;
-		info->fbops->fb_restore_state = NULL;
-	}
-
 	/* Disable blanking if the user requested so. */
 	if (!blank)
 		info->fbops->fb_blank = NULL;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a34bdf5..de9c722 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -669,12 +669,6 @@ struct fb_ops {
 	/* perform fb specific mmap */
 	int (*fb_mmap)(struct fb_info *info, struct vm_area_struct *vma);
 
-	/* save current hardware state */
-	void (*fb_save_state)(struct fb_info *info);
-
-	/* restore saved state */
-	void (*fb_restore_state)(struct fb_info *info);
-
 	/* get capability given var */
 	void (*fb_get_caps)(struct fb_info *info, struct fb_blit_caps *caps,
 			    struct fb_var_screeninfo *var);


----------------------------------------------------------------------
Nie wiesz ktory bank wybrac?
Sprawdz ranking >>> http://link.interia.pl/f23b5


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
