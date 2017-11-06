From: Colin King <colin.king@canonical.com>
Date: Mon, 06 Nov 2017 13:17:11 +0000
Subject: [PATCH] video: fbdev: intelfb: remove redundant variables
Message-Id: <20171106131711.6499-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maik Broemme <mbroemme@libmpq.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables err_max, err_target and f_best are being assigned values but
these are never read, hence they are redundant variables and can be
removed. Cleans up clang warnings:

drivers/video/fbdev/intelfb/intelfbhw.c:946:2: warning: Value stored to
'err_max' is never read
drivers/video/fbdev/intelfb/intelfbhw.c:947:2: warning: Value stored to
'err_target' is never read
drivers/video/fbdev/intelfb/intelfbhw.c:995:6: warning: Value stored to
'f_best' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/intelfb/intelfbhw.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbdev/intelfb/intelfbhw.c
index d31ed4e2c46f..83fec573cceb 100644
--- a/drivers/video/fbdev/intelfb/intelfbhw.c
+++ b/drivers/video/fbdev/intelfb/intelfbhw.c
@@ -937,15 +937,11 @@ static int calc_pll_params(int index, int clock, u32 *retm1, u32 *retm2,
 {
 	u32 m1, m2, n, p1, p2, n1, testm;
 	u32 f_vco, p, p_best = 0, m, f_out = 0;
-	u32 err_max, err_target, err_best = 10000000;
-	u32 n_best = 0, m_best = 0, f_best, f_err;
+	u32 err_best = 10000000;
+	u32 n_best = 0, m_best = 0, f_err;
 	u32 p_min, p_max, p_inc, div_max;
 	struct pll_min_max *pll = &plls[index];
 
-	/* Accept 0.5% difference, but aim for 0.1% */
-	err_max = 5 * clock / 1000;
-	err_target = clock / 1000;
-
 	DBG_MSG("Clock is %d\n", clock);
 
 	div_max = pll->max_vco / clock;
@@ -992,7 +988,6 @@ static int calc_pll_params(int index, int clock, u32 *retm1, u32 *retm2,
 					m_best = testm;
 					n_best = n;
 					p_best = p;
-					f_best = f_out;
 					err_best = f_err;
 				}
 			}
-- 
2.14.1

