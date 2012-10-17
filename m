From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Oct 2012 10:18:20 +0000
Subject: [PATCHv3 3/5] OMAP: SDRC: remove VRFB code
Message-Id: <1350469102-24888-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that VRFB driver handles its registers independently, we can remove
the VRFB related code from OMAP's sdrc.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sdrc.c             |   16 ----------------
 arch/arm/plat-omap/include/plat/sdrc.h |    7 -------
 2 files changed, 23 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index e3d345f..4282e6e 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -160,19 +160,3 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 	sdrc_write_reg(l, SDRC_POWER);
 	omap2_sms_save_context();
 }
-
-void omap2_sms_write_rot_control(u32 val, unsigned ctx)
-{
-	sms_write_reg(val, SMS_ROT_CONTROL(ctx));
-}
-
-void omap2_sms_write_rot_size(u32 val, unsigned ctx)
-{
-	sms_write_reg(val, SMS_ROT_SIZE(ctx));
-}
-
-void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx)
-{
-	sms_write_reg(val, SMS_ROT_PHYSICAL_BA(ctx));
-}
-
diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
index 36d6a76..c68bab2 100644
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -94,9 +94,6 @@
 /* SMS register offsets - read/write with sms_{read,write}_reg() */
 
 #define SMS_SYSCONFIG			0x010
-#define SMS_ROT_CONTROL(context)	(0x180 + 0x10 * context)
-#define SMS_ROT_SIZE(context)		(0x184 + 0x10 * context)
-#define SMS_ROT_PHYSICAL_BA(context)	(0x188 + 0x10 * context)
 /* REVISIT: fill in other SMS registers here */
 
 
@@ -137,10 +134,6 @@ int omap2_sdrc_get_params(unsigned long r,
 void omap2_sms_save_context(void);
 void omap2_sms_restore_context(void);
 
-void omap2_sms_write_rot_control(u32 val, unsigned ctx);
-void omap2_sms_write_rot_size(u32 val, unsigned ctx);
-void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx);
-
 #ifdef CONFIG_ARCH_OMAP2
 
 struct memory_timings {
-- 
1.7.9.5

