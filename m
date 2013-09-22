From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 22 Sep 2013 10:01:48 +0000
Subject: [PATCH 1/2] video: jz4740-fb: Fix LCD_CMD bit definitions
Message-Id: <1379844109-10513-1-git-send-email-lars@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix the bit offsets for the LCD_CMD definitions.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/video/jz4740_fb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/jz4740_fb.c b/drivers/video/jz4740_fb.c
index 2c49112..23aa475 100644
--- a/drivers/video/jz4740_fb.c
+++ b/drivers/video/jz4740_fb.c
@@ -99,9 +99,9 @@
 #define JZ_LCD_CTRL_BPP_15_16		0x4
 #define JZ_LCD_CTRL_BPP_18_24		0x5
 
-#define JZ_LCD_CMD_SOF_IRQ BIT(15)
-#define JZ_LCD_CMD_EOF_IRQ BIT(16)
-#define JZ_LCD_CMD_ENABLE_PAL BIT(12)
+#define JZ_LCD_CMD_SOF_IRQ BIT(31)
+#define JZ_LCD_CMD_EOF_IRQ BIT(30)
+#define JZ_LCD_CMD_ENABLE_PAL BIT(28)
 
 #define JZ_LCD_SYNC_MASK 0x3ff
 
-- 
1.7.10.4

