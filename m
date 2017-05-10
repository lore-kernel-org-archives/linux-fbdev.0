From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:53 +0000
Subject: [PATCH 3/9] staging: sm750fb: reordering of macro definitions
Message-Id: <1494453359-3722-4-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch reorder definition of macros so all macros are in same order.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_display.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index 6f639d7..cef7f46 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -81,8 +81,8 @@
 #define DPMS_OFFSET	9
 #define DPMS_MASK	(3 << DPMS_OFFSET)
 #define DPMS_USAGE	(DPMS_MASK << 16)
-#define DPMS_OFF	((3 << DPMS_OFFSET) | DPMS_USAGE)
 #define DPMS_ON		((0 << DPMS_OFFSET) | DPMS_USAGE)
+#define DPMS_OFF	((3 << DPMS_OFFSET) | DPMS_USAGE)
 
 /*
  * LCD1 means panel path TFT1  & panel path DVI (so enable DAC)
-- 
1.8.3.1

