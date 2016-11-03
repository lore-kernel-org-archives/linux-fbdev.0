From: Huacai Chen <chenhc@lemote.com>
Date: Thu, 03 Nov 2016 04:48:43 +0000
Subject: [PATCH] sm750fb: Fix bugs introduced by early commits
Message-Id: <1478148523-32416-1-git-send-email-chenhc@lemote.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Early commit 30ca5cb63c56965 ("staging: sm750fb: change definition of
PANEL_PLANE_TL fields") and 27b047bbe1ee9c0 ("staging: sm750fb: change
definition of PANEL_PLANE_BR fields") modify the register bit fields
definitions. But the modifications are wrong, because the bit mask of
"bit field 10:0" is not 0xeff, but 0x7ff. The wrong definition bugs
makes display very strange.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index 9552479..4ed6d8d 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -601,13 +601,13 @@
 
 #define PANEL_PLANE_TL                                0x08001C
 #define PANEL_PLANE_TL_TOP_SHIFT                      16
-#define PANEL_PLANE_TL_TOP_MASK                       (0xeff << 16)
-#define PANEL_PLANE_TL_LEFT_MASK                      0xeff
+#define PANEL_PLANE_TL_TOP_MASK                       (0x7ff << 16)
+#define PANEL_PLANE_TL_LEFT_MASK                      0x7ff
 
 #define PANEL_PLANE_BR                                0x080020
 #define PANEL_PLANE_BR_BOTTOM_SHIFT                   16
-#define PANEL_PLANE_BR_BOTTOM_MASK                    (0xeff << 16)
-#define PANEL_PLANE_BR_RIGHT_MASK                     0xeff
+#define PANEL_PLANE_BR_BOTTOM_MASK                    (0x7ff << 16)
+#define PANEL_PLANE_BR_RIGHT_MASK                     0x7ff
 
 #define PANEL_HORIZONTAL_TOTAL                        0x080024
 #define PANEL_HORIZONTAL_TOTAL_TOTAL_SHIFT            16
-- 
2.7.0



