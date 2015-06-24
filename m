From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Wed, 24 Jun 2015 16:51:21 +0000
Subject: [PATCHv2] staging: sm750fb: remove redundant __func__ in debug statement
Message-Id: <20150624165120.GA4935@krrish>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>

This patch removes the redundant __func__ from dynamic debug prints as
the pr_xxx set of functions can be dynamically controlled to include
function name.Also fix a typo in debug statement.

Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
---
	v2:Address Dan Carpenter's review comments to fold them as a
singl patch rather than sending these two changes as separate patches.
---
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 6eee4cd..8ea3a61 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -100,7 +100,7 @@ int hw_fillrect(struct lynx_accel *accel,
 	{
 		/* int time wait and always busy,seems hardware
 		 * got something error */
-		pr_debug("%s:De engine always bussy\n", __func__);
+		pr_debug("De engine always busy\n");
 		return -1;
 	}
 
-- 
1.9.1
