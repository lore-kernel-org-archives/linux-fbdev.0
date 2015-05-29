From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 29 May 2015 00:30:33 +0000
Subject: [PATCH v4 2/17] video: fbdev: gbefb: add missing mtrr_del() calls
Message-Id: <1432859434-17821-2-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1432859434-17821-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Masanari Iida <standby24x7@gmail.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andy Lutomirski <luto@amacapital.net>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver never removed the MTRRs. Fix that.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Masanari Iida <standby24x7@gmail.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/gbefb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 6d9ef39..4e54faa06 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -38,6 +38,7 @@ static struct sgi_gbe *gbe;
 struct gbefb_par {
 	struct fb_var_screeninfo var;
 	struct gbe_timing_info timing;
+	int wc_cookie;
 	int valid;
 };
 
@@ -1198,8 +1199,10 @@ static int gbefb_probe(struct platform_device *p_dev)
 		gbe_mem_phys = (unsigned long) gbe_dma_addr;
 	}
 
+	par = info->par;
 #ifdef CONFIG_X86
-	mtrr_add(gbe_mem_phys, gbe_mem_size, MTRR_TYPE_WRCOMB, 1);
+	par->wc_cookie = mtrr_add(gbe_mem_phys, gbe_mem_size,
+				   MTRR_TYPE_WRCOMB, 1);
 #endif
 
 	/* map framebuffer memory into tiles table */
@@ -1215,7 +1218,6 @@ static int gbefb_probe(struct platform_device *p_dev)
 	/* reset GBE */
 	gbe_reset();
 
-	par = info->par;
 	/* turn on default video mode */
 	if (fb_find_mode(&par->var, info, mode_option, NULL, 0,
 			 default_mode, 8) = 0)
@@ -1240,6 +1242,10 @@ static int gbefb_probe(struct platform_device *p_dev)
 	return 0;
 
 out_gbe_unmap:
+#ifdef CONFIG_MTRR
+	if (par->wc_cookie >= 0)
+		mtrr_del(par->wc_cookie, 0, 0);
+#endif
 	if (gbe_dma_addr)
 		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 out_tiles_free:
@@ -1256,9 +1262,14 @@ out_release_framebuffer:
 static int gbefb_remove(struct platform_device* p_dev)
 {
 	struct fb_info *info = platform_get_drvdata(p_dev);
+	struct gbefb_par *par = info->par;
 
 	unregister_framebuffer(info);
 	gbe_turn_off();
+#ifdef CONFIG_MTRR
+	if (par->wc_cookie >= 0)
+		mtrr_del(par->wc_cookie, 0, 0);
+#endif
 	if (gbe_dma_addr)
 		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-- 
2.3.2.209.gd67f9d5.dirty

