From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Mon, 22 Jun 2015 04:47:38 +0000
Subject: [PATCH 1/2] staging: sm750fb: remove redundant __func__ in debug statement
Message-Id: <20150622044128.GA30284@IND12F0122>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>

This patch removes the redundant __func__ from dynamic debug prints as
the pr_xxx set of functions can be dynamically controlled to include
function name as well

Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 6eee4cd..bf62003 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -100,7 +100,7 @@ int hw_fillrect(struct lynx_accel *accel,
 	{
 		/* int time wait and always busy,seems hardware
 		 * got something error */
-		pr_debug("%s:De engine always bussy\n", __func__);
+		pr_debug("De engine always bussy\n");
 		return -1;
 	}
 
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
