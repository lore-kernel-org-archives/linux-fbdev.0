From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Thu, 03 May 2012 00:34:16 +0000
Subject: [PATCH] video: mb862xx-i2c: local functions should not be exposed globally
Message-Id: <201205021734.16988.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, FlorianSchandinat@gmx.de, agust@denx.de

Functions not referenced outside of a source file should be marked
static to prevent them from being exposed globally.

Quiets the sparse warnings:

warning: symbol 'mb862xx_i2c_stop' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Anatolij Gustschin <agust@denx.de>

---

diff --git a/drivers/video/mb862xx/mb862xx-i2c.c b/drivers/video/mb862xx/mb862xx-i2c.c
index 273769b..c87e17a 100644
--- a/drivers/video/mb862xx/mb862xx-i2c.c
+++ b/drivers/video/mb862xx/mb862xx-i2c.c
@@ -68,7 +68,7 @@ static int mb862xx_i2c_read_byte(struct i2c_adapter *adap, u8 *byte, int last)
 	return 1;
 }
 
-void mb862xx_i2c_stop(struct i2c_adapter *adap)
+static void mb862xx_i2c_stop(struct i2c_adapter *adap)
 {
 	struct mb862xxfb_par *par = adap->algo_data;
 
