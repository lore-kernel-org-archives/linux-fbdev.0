From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Mon, 22 Jun 2015 04:48:01 +0000
Subject: [PATCH 2/2] staging: sm750fb: fix typo in debug statement
Message-Id: <20150622044154.GA30325@IND12F0122>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>

This patch fixes a typo in the debug statement

Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index bf62003..8ea3a61 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -100,7 +100,7 @@ int hw_fillrect(struct lynx_accel *accel,
 	{
 		/* int time wait and always busy,seems hardware
 		 * got something error */
-		pr_debug("De engine always bussy\n");
+		pr_debug("De engine always busy\n");
 		return -1;
 	}
 
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
