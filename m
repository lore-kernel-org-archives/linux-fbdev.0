From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:40:49 +0000
Subject: [PATCH v3 2/3] video: fbdev: vesafb: add missing mtrr_del() for added MTRR
Message-Id: <1429648850-17902-3-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429648850-17902-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429648850-17902-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The MTRR added was never being deleted.

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/vesafb.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index 191156b..a2261d0 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -29,6 +29,10 @@
 
 /* --------------------------------------------------------------------- */
 
+struct vesafb_par {
+	int wc_cookie;
+};
+
 static struct fb_var_screeninfo vesafb_defined = {
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
@@ -175,7 +179,16 @@ static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 static void vesafb_destroy(struct fb_info *info)
 {
+#ifdef CONFIG_MTRR
+	struct vesafb_par *par = info->par;
+#endif
+
 	fb_dealloc_cmap(&info->cmap);
+
+#ifdef CONFIG_MTRR
+	if (par->wc_cookie >= 0)
+		mtrr_del(par->wc_cookie, 0, 0);
+#endif
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
@@ -228,6 +241,7 @@ static int vesafb_setup(char *options)
 static int vesafb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
+	struct vesafb_par *par;
 	int i, err;
 	unsigned int size_vmode;
 	unsigned int size_remap;
@@ -297,8 +311,8 @@ static int vesafb_probe(struct platform_device *dev)
 		return -ENOMEM;
 	}
 	platform_set_drvdata(dev, info);
-	info->pseudo_palette = info->par;
-	info->par = NULL;
+	info->pseudo_palette = NULL;
+	par = info->par;
 
 	/* set vesafb aperture size for generic probing */
 	info->apertures = alloc_apertures(1);
@@ -407,17 +421,17 @@ static int vesafb_probe(struct platform_device *dev)
 	if (mtrr = 3) {
 #ifdef CONFIG_MTRR
 		unsigned int temp_size = size_total;
-		int rc;
 
 		/* Find the largest power-of-two */
 		temp_size = roundup_pow_of_two(temp_size);
 
 		/* Try and find a power of two to add */
 		do {
-			rc = mtrr_add(vesafb_fix.smem_start, temp_size,
-				      MTRR_TYPE_WRCOMB, 1);
+			par->wc_cookie = mtrr_add(vesafb_fix.smem_start,
+						  temp_size,
+						  MTRR_TYPE_WRCOMB, 1);
 			temp_size >>= 1;
-		} while (temp_size >= PAGE_SIZE && rc = -EINVAL);
+		} while (temp_size >= PAGE_SIZE && par->wc_cookie = -EINVAL);
 #endif
 		info->screen_base = ioremap_wc(vesafb_fix.smem_start, vesafb_fix.smem_len);
 	} else {
@@ -462,6 +476,10 @@ static int vesafb_probe(struct platform_device *dev)
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
 err:
+#ifdef CONFIG_MTRR
+	if (par->wc_cookie >= 0)
+		mtrr_del(par->wc_cookie, 0, 0);
+#endif
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	framebuffer_release(info);
-- 
2.3.2.209.gd67f9d5.dirty

