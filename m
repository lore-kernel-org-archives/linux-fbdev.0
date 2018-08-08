From: Abishek V Ashok <abishekvashok@gmail.com>
Date: Wed, 08 Aug 2018 09:47:52 +0000
Subject: [PATCH] ddk750_mode.c: Wraps line to 80 charecters
Message-Id: <20180808093552.2248-1-abishekvashok@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Abishek V Ashok <abishekvashok@gmail.com>

Splits definition of function programModeRegisters into two lines such
that each line is less than 80 characters.

Signed-off-by: Abishek V Ashok <abishekvashok@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 7e22d093b..57cf9e6a5 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -13,8 +13,8 @@
  * HW only supports 7 predefined pixel clocks, and clock select is
  * in bit 29:27 of Display Control register.
  */
-static unsigned long displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
-						  unsigned long dispControl)
+static unsigned long displayControlAdjust_SM750LE(
+		struct mode_parameter *pModeParam, unsigned long dispControl)
 {
 	unsigned long x, y;
 
-- 
2.18.0

