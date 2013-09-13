From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 13 Sep 2013 06:59:46 +0000
Subject: [PATCH V5 2/5] ARM: mmp: remove the legacy rbswap setting for ttc_dkb platform
Message-Id: <1379055589-26132-3-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: "Jett.Zhou" <jtzhou@marvell.com>

According to new rbswap scheme of mmp_display, it support appropriate
rbswap setting based on specific pix_fmt, then we can remove the legacy
rbswap setting for ttc_dkb platform.

Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Reviewed-by: Daniel Drake <dsd@laptop.org>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 7022329..cfadd97 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -191,7 +191,6 @@ static struct pxa3xx_nand_platform_data dkb_nand_info = {
 #define SCLK_SOURCE_SELECT(x)  (x << 30) /* 0x0 ~ 0x3 */
 /* link config */
 #define CFG_DUMBMODE(mode)     (mode << 28) /* 0x0 ~ 0x6*/
-#define CFG_GRA_SWAPRB(x)      (x << 0) /* 1: rbswap enabled */
 static struct mmp_mach_path_config dkb_disp_config[] = {
 	[0] = {
 		.name = "mmp-parallel",
@@ -199,8 +198,7 @@ static struct mmp_mach_path_config dkb_disp_config[] = {
 		.output_type = PATH_OUT_PARALLEL,
 		.path_config = CFG_IOPADMODE(0x1)
 			| SCLK_SOURCE_SELECT(0x1),
-		.link_config = CFG_DUMBMODE(0x2)
-			| CFG_GRA_SWAPRB(0x1),
+		.link_config = CFG_DUMBMODE(0x2),
 	},
 };
 
-- 
1.7.9.5

