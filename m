From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:49:57 +0000
Subject: [PATCH 09/19] s3c-fb: Correct FRAMESEL1 bitfield defines for
Message-Id: <1278665407-18002-10-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

FRAMESEL1 bitfield starts on 13th bit, not on 14th.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/include/plat/regs-fb.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index f4259e5..ac10013 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -292,11 +292,11 @@
 #define VIDINTCON0_FRAMESEL0_ACTIVE		(0x2 << 15)
 #define VIDINTCON0_FRAMESEL0_FRONTPORCH		(0x3 << 15)
 
-#define VIDINTCON0_FRAMESEL1			(1 << 14)
-#define VIDINTCON0_FRAMESEL1_NONE		(0x0 << 14)
-#define VIDINTCON0_FRAMESEL1_BACKPORCH		(0x1 << 14)
-#define VIDINTCON0_FRAMESEL1_VSYNC		(0x2 << 14)
-#define VIDINTCON0_FRAMESEL1_FRONTPORCH		(0x3 << 14)
+#define VIDINTCON0_FRAMESEL1			(1 << 13)
+#define VIDINTCON0_FRAMESEL1_NONE		(0x0 << 13)
+#define VIDINTCON0_FRAMESEL1_BACKPORCH		(0x1 << 13)
+#define VIDINTCON0_FRAMESEL1_VSYNC		(0x2 << 13)
+#define VIDINTCON0_FRAMESEL1_FRONTPORCH		(0x3 << 13)
 
 #define VIDINTCON0_INT_FRAME			(1 << 12)
 #define VIDINTCON0_FIFIOSEL_MASK		(0x7f << 5)
-- 
1.7.1.569.g6f426

