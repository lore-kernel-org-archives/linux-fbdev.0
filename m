From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 31 Jan 2015 13:47:33 +0000
Subject: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
Message-Id: <1422712065-9403-4-git-send-email-haokexin@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Paul Mackerras <paulus@samba.org>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index aedf2fbf9bf6..0156954bf340 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -965,7 +965,7 @@ static void __iomem *aty128_find_mem_vbios(struct aty128fb_par *par)
 /* fill in known card constants if pll_block is not available */
 static void aty128_timings(struct aty128fb_par *par)
 {
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 	/* instead of a table lookup, assume OF has properly
 	 * setup the PLL registers and use their values
 	 * to set the XCLK values and reference divider values */
@@ -979,7 +979,7 @@ static void aty128_timings(struct aty128fb_par *par)
 	if (!par->constants.ref_clk)
 		par->constants.ref_clk = 2950;
 
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 	x_mpll_ref_fb_div = aty_ld_pll(X_MPLL_REF_FB_DIV);
 	xclk_cntl = aty_ld_pll(XCLK_CNTL) & 0x7;
 	Nx = (x_mpll_ref_fb_div & 0x00ff00) >> 8;
-- 
1.9.3

