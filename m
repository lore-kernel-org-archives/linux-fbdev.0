From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 12:38:40 +0000
Subject: [PATCH] video: fbdev: omap2: dss: dsi.c:  Cleaning up variable that is never used
Message-Id: <1404563921-20941-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Rickard Strandqvist <rickard.strandqvist-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sathya Prakash M R <sathyap-l0cyMroinI0@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Variable ar assigned a value that is never used.
I have also removed all the code that thereby serves no purpose.

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/omap2/dss/dsi.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 4755a34..32d2ba6 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1207,13 +1207,12 @@ static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 
 static void _dsi_print_reset_status(struct platform_device *dsidev)
 {
-	u32 l;
 	int b0, b1, b2;
 
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
-	l = dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
+	dsi_read_reg(dsidev, DSI_DSIPHY_CFG5);
 
 	if (dss_has_feature(FEAT_DSI_REVERSE_TXCLKESC)) {
 		b0 = 28;
@@ -3902,7 +3901,7 @@ static int dsi_proto_config(struct platform_device *dsidev)
 static void dsi_proto_timings(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	unsigned tlpx, tclk_zero, tclk_prepare, tclk_trail;
+	unsigned tlpx, tclk_zero, tclk_prepare;
 	unsigned tclk_pre, tclk_post;
 	unsigned ths_prepare, ths_prepare_ths_zero, ths_zero;
 	unsigned ths_trail, ths_exit;
@@ -3921,7 +3920,7 @@ static void dsi_proto_timings(struct platform_device *dsidev)
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG1);
 	tlpx = FLD_GET(r, 20, 16) * 2;
-	tclk_trail = FLD_GET(r, 15, 8);
+	FLD_GET(r, 15, 8);
 	tclk_zero = FLD_GET(r, 7, 0);
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG2);
@@ -4669,12 +4668,11 @@ static void print_dsi_dispc_vm(const char *str,
 	unsigned long byteclk = t->hsclk / 4;
 	unsigned long pck;
 	u64 dsi_tput;
-	int dsi_hact, dsi_htot;
+	int dsi_hact;
 
 	dsi_tput = (u64)byteclk * t->ndl * 8;
 	pck = (u32)div64_u64(dsi_tput, t->bitspp);
 	dsi_hact = DIV_ROUND_UP(DIV_ROUND_UP(t->hact * t->bitspp, 8) + 6, t->ndl);
-	dsi_htot = t->hss + t->hsa + t->hse + t->hbp + dsi_hact + t->hfp;
 
 	vm.pixelclock = pck;
 	vm.hsw = div64_u64((u64)(t->hsa + t->hse) * pck, byteclk);
-- 
1.7.10.4

