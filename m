From: Colin King <colin.king@canonical.com>
Date: Tue, 19 Sep 2017 21:32:01 +0000
Subject: [PATCH] video: fbdev: radeon: make const array post_divs static, reduces object code size
Message-Id: <20170919213201.31845-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the read-only const array post_divs on the stack,
nstead make it static. Makes the object code smaller by 90 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  40231	   8584	    896	  49711	   c22f	radeon_base.o

After:
   text	   data	    bss	    dec	    hex	filename
  39914	   8744	    960	  49618	   c1d2	radeon_base.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 1e2ec360f8c1..8ad1643e7d1c 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -1534,7 +1534,7 @@ void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
 static void radeon_calc_pll_regs(struct radeonfb_info *rinfo, struct radeon_regs *regs,
 				 unsigned long freq)
 {
-	const struct {
+	static const struct {
 		int divider;
 		int bitvalue;
 	} *post_div,
-- 
2.14.1

