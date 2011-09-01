From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 01 Sep 2011 15:53:41 +0000
Subject: [PATCH] video: mb862xx-i2c: fix for reliable decoder register access
Message-Id: <1314892421-13471-1-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Increase delay when polling for tx status. This fixes
the unreliable video decoder i2c register access.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/mb862xx-i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mb862xx/mb862xx-i2c.c b/drivers/video/mb862xx/mb862xx-i2c.c
index b953099..934081d 100644
--- a/drivers/video/mb862xx/mb862xx-i2c.c
+++ b/drivers/video/mb862xx/mb862xx-i2c.c
@@ -23,7 +23,7 @@ static int mb862xx_i2c_wait_event(struct i2c_adapter *adap)
 	u32 reg;
 
 	do {
-		udelay(1);
+		udelay(10);
 		reg = inreg(i2c, GC_I2C_BCR);
 		if (reg & (I2C_INT | I2C_BER))
 			break;
-- 
1.7.1

