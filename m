From: Tim Gardner <tim.gardner@canonical.com>
Date: Sun, 10 Mar 2013 17:53:31 +0000
Subject: [PATCH linux-next] intelfb: intelfbhw_mode_to_hw: Silence m1/m2 'may be used uninitialized' warnings
Message-Id: <1362938011-85394-1-git-send-email-tim.gardner@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Tim Gardner <tim.gardner@canonical.com>, Maik Broemme <mbroemme@plusserver.de>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

drivers/video/intelfb/intelfbhw.c: In function 'intelfbhw_mode_to_hw':
drivers/video/intelfb/intelfbhw.c:1144:35: warning: 'm2' may be used uninitialized in this function [-Wuninitialized]
drivers/video/intelfb/intelfbhw.c:1145:13: warning: 'm1' may be used uninitialized in this function [-Wuninitialized]

gcc version 4.6.3

Cc: Maik Broemme <mbroemme@plusserver.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/video/intelfb/intelfbhw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
index fbad61d..cb05307 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -935,7 +935,7 @@ static int splitp(int index, unsigned int p, unsigned int *retp1,
 static int calc_pll_params(int index, int clock, u32 *retm1, u32 *retm2,
 			   u32 *retn, u32 *retp1, u32 *retp2, u32 *retclock)
 {
-	u32 m1, m2, n, p1, p2, n1, testm;
+	u32 m1 = 0, m2 = 0, n, p1, p2, n1, testm;
 	u32 f_vco, p, p_best = 0, m, f_out = 0;
 	u32 err_max, err_target, err_best = 10000000;
 	u32 n_best = 0, m_best = 0, f_best, f_err;
-- 
1.7.9.5

