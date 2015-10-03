From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 03 Oct 2015 11:28:31 +0000
Subject: [PATCH] drivers/video/fbdev/i740fb: remove unused variable
Message-Id: <1443870991-10836-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The value of d_best is always 0 and never changes.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/i740fb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 452e116..cf5ccd0 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -346,11 +346,10 @@ static void i740_calc_vclk(u32 freq, struct i740fb_par *par)
 	const u32 err_target = freq / (1000 * I740_RFREQ / I740_FFIX);
 	u32 err_best = 512 * I740_FFIX;
 	u32 f_err, f_vco;
-	int m_best = 0, n_best = 0, p_best = 0, d_best = 0;
+	int m_best = 0, n_best = 0, p_best = 0;
 	int m, n;
 
 	p_best = min(15, ilog2(I740_MAX_VCO_FREQ / (freq / I740_RFREQ_FIX)));
-	d_best = 0;
 	f_vco = (freq * (1 << p_best)) / I740_RFREQ_FIX;
 	freq = freq / I740_RFREQ_FIX;
 
@@ -363,7 +362,7 @@ static void i740_calc_vclk(u32 freq, struct i740fb_par *par)
 			m = 3;
 
 		{
-			u32 f_out = (((m * I740_REF_FREQ * (4 << 2 * d_best))
+			u32 f_out = (((m * I740_REF_FREQ * 4)
 				 / n) + ((1 << p_best) / 2)) / (1 << p_best);
 
 			f_err = (freq - f_out);
@@ -386,8 +385,7 @@ static void i740_calc_vclk(u32 freq, struct i740fb_par *par)
 	par->video_clk2_n = (n_best - 2) & 0xFF;
 	par->video_clk2_mn_msbs = ((((n_best - 2) >> 4) & VCO_N_MSBS)
 				 | (((m_best - 2) >> 8) & VCO_M_MSBS));
-	par->video_clk2_div_sel -		((p_best << 4) | (d_best ? 4 : 0) | REF_DIV_1);
+	par->video_clk2_div_sel = ((p_best << 4) | REF_DIV_1);
 }
 
 static int i740fb_decode_var(const struct fb_var_screeninfo *var,
-- 
1.9.1

