From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: use modedb and add
 mode_option parameter (2nd rev)
Date: Tue, 2 Sep 2008 18:19:14 +0200
Message-ID: <20080902181914.53707df2.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaZ0Y-0004si-QZ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 09:45:34 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KaZ0V-0002yQ-GQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 09:45:34 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>
cirrusfb: use modedb and add mode_option parameter

Use modedb for initial mode instead of table
of few predefined modes.
Add mode_option module parameter as a step toward
unification of frame buffers' parameters.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

The 640x480@60 mode was dropped as well.

 drivers/video/cirrusfb.c |  126 ++++++++--------------------------------------
 1 files changed, 21 insertions(+), 105 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 0eb429a..4c16b68 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -372,98 +372,8 @@ struct cirrusfb_info {
 	void (*unmap)(struct fb_info *info);
 };
 
-static unsigned cirrusfb_def_mode = 1;
 static int noaccel;
-
-/*
- *    Predefined Video Modes
- */
-
-static const struct {
-	const char *name;
-	struct fb_var_screeninfo var;
-} cirrusfb_predefined[] = {
-	{
-		/* autodetect mode */
-		.name	= "Autodetect",
-	}, {
-		/* 640x480, 31.25 kHz, 60 Hz, 25 MHz PixClock */
-		.name	= "640x480",
-		.var	= {
-			.xres		= 640,
-			.yres		= 480,
-			.xres_virtual	= 640,
-			.yres_virtual	= 480,
-			.bits_per_pixel	= 8,
-			.red		= { .length = 8 },
-			.green		= { .length = 8 },
-			.blue		= { .length = 8 },
-			.width		= -1,
-			.height		= -1,
-			.pixclock	= 40000,
-			.left_margin	= 48,
-			.right_margin	= 16,
-			.upper_margin	= 32,
-			.lower_margin	= 8,
-			.hsync_len	= 96,
-			.vsync_len	= 4,
-			.sync	= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-			.vmode		= FB_VMODE_NONINTERLACED
-		 }
-	}, {
-		/* 800x600, 48 kHz, 76 Hz, 50 MHz PixClock */
-		.name	= "800x600",
-		.var	= {
-			.xres		= 800,
-			.yres		= 600,
-			.xres_virtual	= 800,
-			.yres_virtual	= 600,
-			.bits_per_pixel	= 8,
-			.red		= { .length = 8 },
-			.green		= { .length = 8 },
-			.blue		= { .length = 8 },
-			.width		= -1,
-			.height		= -1,
-			.pixclock	= 20000,
-			.left_margin	= 128,
-			.right_margin	= 16,
-			.upper_margin	= 24,
-			.lower_margin	= 2,
-			.hsync_len	= 96,
-			.vsync_len	= 6,
-			.vmode		= FB_VMODE_NONINTERLACED
-		 }
-	}, {
-		/*
-		 * Modeline from XF86Config:
-		 * Mode "1024x768" 80  1024 1136 1340 1432  768 770 774 805
-		 */
-		/* 1024x768, 55.8 kHz, 70 Hz, 80 MHz PixClock */
-		.name	= "1024x768",
-		.var	= {
-			.xres		= 1024,
-			.yres		= 768,
-			.xres_virtual	= 1024,
-			.yres_virtual	= 768,
-			.bits_per_pixel	= 8,
-			.red		= { .length = 8 },
-			.green		= { .length = 8 },
-			.blue		= { .length = 8 },
-			.width		= -1,
-			.height		= -1,
-			.pixclock	= 12500,
-			.left_margin	= 144,
-			.right_margin	= 32,
-			.upper_margin	= 30,
-			.lower_margin	= 2,
-			.hsync_len	= 192,
-			.vsync_len	= 6,
-			.vmode		= FB_VMODE_NONINTERLACED
-		}
-	}
-};
-
-#define NUM_TOTAL_MODES    ARRAY_SIZE(cirrusfb_predefined)
+static char *mode_option __devinitdata = "640x480@60";
 
 /****************************************************************************/
 /**** BEGIN PROTOTYPES ******************************************************/
@@ -2267,23 +2177,27 @@ static int cirrusfb_register(struct fb_info *info)
 	/* sanity checks */
 	assert(btype != BT_NONE);
 
+	/* set all the vital stuff */
+	cirrusfb_set_fbinfo(info);
+
 	DPRINTK("cirrusfb: (RAM start set to: 0x%p)\n", info->screen_base);
 
-	/* Make pretend we've set the var so our structures are in a "good" */
-	/* state, even though we haven't written the mode to the hw yet...  */
-	info->var = cirrusfb_predefined[cirrusfb_def_mode].var;
+	err = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL, 8);
+	if (!err) {
+		DPRINTK("wrong initial video mode\n");
+		err = -EINVAL;
+		goto err_dealloc_cmap;
+	}
+
 	info->var.activate = FB_ACTIVATE_NOW;
 
 	err = cirrusfb_decode_var(&info->var, &cinfo->currentmode, info);
 	if (err < 0) {
 		/* should never happen */
 		DPRINTK("choking on default var... umm, no good.\n");
-		goto err_unmap_cirrusfb;
+		goto err_dealloc_cmap;
 	}
 
-	/* set all the vital stuff */
-	cirrusfb_set_fbinfo(info);
-
 	err = register_framebuffer(info);
 	if (err < 0) {
 		printk(KERN_ERR "cirrusfb: could not register "
@@ -2296,7 +2210,6 @@ static int cirrusfb_register(struct fb_info *info)
 
 err_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
-err_unmap_cirrusfb:
 	cinfo->unmap(info);
 	framebuffer_release(info);
 	return err;
@@ -2608,17 +2521,17 @@ static int __init cirrusfb_setup(char *options) {
 		return 0;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt) continue;
+		if (!*this_opt)
+			continue;
 
 		DPRINTK("cirrusfb_setup: option '%s'\n", this_opt);
 
-		for (i = 0; i < NUM_TOTAL_MODES; i++) {
-			sprintf(s, "mode:%s", cirrusfb_predefined[i].name);
-			if (strcmp(this_opt, s) == 0)
-				cirrusfb_def_mode = i;
-		}
 		if (!strcmp(this_opt, "noaccel"))
 			noaccel = 1;
+		else if (!strncmp(this_opt, "mode:", 5))
+			mode_option = this_opt + 5;
+		else
+			mode_option = this_opt;
 	}
 	return 0;
 }
@@ -2644,6 +2557,9 @@ static void __exit cirrusfb_exit(void)
 
 module_init(cirrusfb_init);
 
+module_param(mode_option, charp, 0);
+MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
+
 #ifdef MODULE
 module_exit(cirrusfb_exit);
 #endif
-- 
1.5.2.2


---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
