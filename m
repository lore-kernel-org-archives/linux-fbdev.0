From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:16 +0000
Subject: [PATCH v1 26/47] video: fbdev: gbefb: add missing mtrr_del() calls
Message-Id: <1426893517-2511-27-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver never removed the MTRRs. Fix that.

Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/gbefb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 6d9ef39..f48ea7e 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -38,6 +38,7 @@ static struct sgi_gbe *gbe;
 struct gbefb_par {
 	struct fb_var_screeninfo var;
 	struct gbe_timing_info timing;
+	int wc_cookie;
 	int valid;
 };
 
@@ -1199,7 +1200,8 @@ static int gbefb_probe(struct platform_device *p_dev)
 	}
 
 #ifdef CONFIG_X86
-	mtrr_add(gbe_mem_phys, gbe_mem_size, MTRR_TYPE_WRCOMB, 1);
+	info->wc_cookie = mtrr_add(gbe_mem_phys, gbe_mem_size,
+				   MTRR_TYPE_WRCOMB, 1);
 #endif
 
 	/* map framebuffer memory into tiles table */
@@ -1240,6 +1242,10 @@ static int gbefb_probe(struct platform_device *p_dev)
 	return 0;
 
 out_gbe_unmap:
+#ifdef CONFIG_MTRR
+	if (info->wc_cookie >= 0)
+		mtrr_del(info->wc_cookie, 0, 0);
+#endif
 	if (gbe_dma_addr)
 		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 out_tiles_free:
@@ -1259,6 +1265,10 @@ static int gbefb_remove(struct platform_device* p_dev)
 
 	unregister_framebuffer(info);
 	gbe_turn_off();
+#ifdef CONFIG_MTRR
+	if (info->wc_cookie >= 0)
+		mtrr_del(info->wc_cookie, 0, 0);
+#endif
 	if (gbe_dma_addr)
 		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-- 
2.3.2.209.gd67f9d5.dirty

