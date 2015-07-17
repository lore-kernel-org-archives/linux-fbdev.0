From: Antoine BLIN <antoine.blin@lip6.fr>
Date: Fri, 17 Jul 2015 13:04:33 +0000
Subject: [PATCH 1/2] staging: sm750fb: ddk750_power.c: Remove optionnal parentheses.
Message-Id: <1437138274-23146-1-git-send-email-antoine.blin@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Antoine BLIN <antoine.blin@lip6.fr>

Fix up "return is not a function, parentheses are not required" error found by
the checkpatch.pl script.

Signed-off-by: Antoine BLIN <antoine.blin@lip6.fr>
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
2.4.5

