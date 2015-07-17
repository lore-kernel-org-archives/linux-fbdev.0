From: Aaron Ouellette <aouellette2016@gmail.com>
Date: Fri, 17 Jul 2015 01:21:16 +0000
Subject: [PATCH] staging: sm750fb: removed extra parentheses
Message-Id: <1437096076-13969-1-git-send-email-aouellette2016@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fixed checkpatch.pl error:
ERROR: return is not a function, parentheses are not needed

Signed-off-by: Aaron Ouellette <aouellette2016@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index c8c51be..3c04447 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -20,7 +20,7 @@ unsigned int getPowerMode(void)
 {
 	if (getChipType() = SM750LE)
 		return 0;
-	return (FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE));
+	return FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE);
 }
 
 
-- 
2.4.6

