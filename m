From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Oct 2011 11:42:22 +0000
Subject: [PATCH 1/4] zorro: Rename Picasso IV Z2 "MEM" to "RAM" for consistency
Message-Id: <1319110945-25684-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org, "Christian T. Steigies" <cts@debian.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Ingo=20J=C3=BCrgensmann?= <ij@2011.bluespice.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/zorro_ids.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/zorro_ids.h b/include/linux/zorro_ids.h
index 7e74908..74bc53b 100644
--- a/include/linux/zorro_ids.h
+++ b/include/linux/zorro_ids.h
@@ -360,8 +360,8 @@
 #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM	ZORRO_ID(VILLAGE_TRONIC, 0x0B, 0)
 #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG	ZORRO_ID(VILLAGE_TRONIC, 0x0C, 0)
 #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_SEGMENTED_MODE	ZORRO_ID(VILLAGE_TRONIC, 0x0D, 0)
-#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_MEM1		ZORRO_ID(VILLAGE_TRONIC, 0x15, 0)
-#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_MEM2		ZORRO_ID(VILLAGE_TRONIC, 0x16, 0)
+#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_RAM1		ZORRO_ID(VILLAGE_TRONIC, 0x15, 0)
+#define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_RAM2		ZORRO_ID(VILLAGE_TRONIC, 0x16, 0)
 #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z2_REG		ZORRO_ID(VILLAGE_TRONIC, 0x17, 0)
 #define  ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3		ZORRO_ID(VILLAGE_TRONIC, 0x18, 0)
 #define  ZORRO_PROD_VILLAGE_TRONIC_ARIADNE			ZORRO_ID(VILLAGE_TRONIC, 0xC9, 0)
-- 
1.7.0.4

