From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 02 Feb 2016 20:47:39 +0000
Subject: [PATCH] video: ARM CLCD: runtime check for Versatile
Message-Id: <1454446059-30526-1-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The current compile-time check for inversed IENB/CNTL does not
work in multiplatform boots: as soon as versatile is included
in the build, the IENB/CNTL is switched and breaks graphics.
Convert this to a runtime switch.

Cc: stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Fixes: a29da136de34 ("ARM: versatile: convert to multi-platform")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/amba-clcd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 9362424c2340..f9ef06d0cd48 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -440,13 +440,14 @@ static int clcdfb_register(struct clcd_fb *fb)
 		fb->off_ienb = CLCD_PL111_IENB;
 		fb->off_cntl = CLCD_PL111_CNTL;
 	} else {
-#ifdef CONFIG_ARCH_VERSATILE
-		fb->off_ienb = CLCD_PL111_IENB;
-		fb->off_cntl = CLCD_PL111_CNTL;
-#else
-		fb->off_ienb = CLCD_PL110_IENB;
-		fb->off_cntl = CLCD_PL110_CNTL;
-#endif
+		if (of_machine_is_compatible("arm,versatile-ab") ||
+		    of_machine_is_compatible("arm,versatile-pb")) {
+			fb->off_ienb = CLCD_PL111_IENB;
+			fb->off_cntl = CLCD_PL111_CNTL;
+		} else {
+			fb->off_ienb = CLCD_PL110_IENB;
+			fb->off_cntl = CLCD_PL110_CNTL;
+		}
 	}
 
 	fb->clk = clk_get(&fb->dev->dev, NULL);
-- 
2.4.3

