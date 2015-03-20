From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:17:57 +0000
Subject: [PATCH v1 07/47] video: fbdev: atyfb: move framebuffer length fudging to helper
Message-Id: <1426893517-2511-8-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The size of the framebuffer to be used needs to
be fudged to account for the different type of
devices that are out there. This captures what
is required to do well, we'll resuse this later.

This has no functional changes.

Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
 drivers/video/fbdev/aty/atyfb_base.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 8789e48..16936bb 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -427,6 +427,20 @@ static struct {
 #endif /* CONFIG_FB_ATY_CT */
 };
 
+/*
+ * Last page of 8 MB (4 MB on ISA) aperture is MMIO,
+ * unless the auxiliary register aperture is used.
+ */
+static void aty_fudge_framebuffer_len(struct fb_info *info)
+{
+	struct atyfb_par *par = (struct atyfb_par *) info->par;
+
+	if (!par->aux_start &&
+	    (info->fix.smem_len = 0x800000 ||
+	     (par->bus_type = ISA && info->fix.smem_len = 0x400000)))
+		info->fix.smem_len -= GUI_RESERVE;
+}
+
 static int correct_chipset(struct atyfb_par *par)
 {
 	u8 rev;
@@ -2603,14 +2617,7 @@ static int aty_init(struct fb_info *info)
 	if (par->pll_ops->resume_pll)
 		par->pll_ops->resume_pll(info, &par->pll);
 
-	/*
-	 * Last page of 8 MB (4 MB on ISA) aperture is MMIO,
-	 * unless the auxiliary register aperture is used.
-	 */
-	if (!par->aux_start &&
-	    (info->fix.smem_len = 0x800000 ||
-	     (par->bus_type = ISA && info->fix.smem_len = 0x400000)))
-		info->fix.smem_len -= GUI_RESERVE;
+	aty_fudge_framebuffer_len(info);
 
 	/*
 	 * Disable register access through the linear aperture
-- 
2.3.2.209.gd67f9d5.dirty

