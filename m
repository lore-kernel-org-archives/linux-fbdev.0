From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Feb 2016 10:01:41 +0000
Subject: [PATCH 4/7 v2] video: ARM CLCD: support pads connected in reverse order
Message-Id: <1456221704-5792-5-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

There are CLCDs connected with the pads in BGR rather than RGB
order. It really doesn't matter since the CLCD has a flag and
a bit to switch the position of the RGB and BGR components.
This is needed to put something logical into the
arm,pl11x,tft-r0g0b0-pads property of the device tree on the
Nomadik which will then be <16 8 0>.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes. Just reposting.
---
 drivers/video/fbdev/amba-clcd.c |  8 ++++++++
 include/linux/amba/clcd.h       | 31 ++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 8903a42c4122..9a631a8e2c04 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -681,6 +681,7 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 	} panels[] = {
 		{ 0x110, 1,  7, 13, CLCD_CAP_5551 },
 		{ 0x110, 0,  8, 16, CLCD_CAP_888 },
+		{ 0x110, 16, 8, 0,  CLCD_CAP_888 },
 		{ 0x111, 4, 14, 20, CLCD_CAP_444 },
 		{ 0x111, 3, 11, 19, CLCD_CAP_444 | CLCD_CAP_5551 },
 		{ 0x111, 3, 10, 19, CLCD_CAP_444 | CLCD_CAP_5551 |
@@ -708,6 +709,13 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 			fb->panel->caps = panels[i].caps;
 	}
 
+	/*
+	 * If we actually physically connected the R lines to B and
+	 * vice versa
+	 */
+	if (r0 != 0 && b0 = 0)
+		fb->panel->bgr_connection = true;
+
 	return fb->panel->caps ? 0 : -EINVAL;
 }
 
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index e64c1ccebb76..c60f32e23a83 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -108,6 +108,12 @@ struct clcd_panel {
 				grayscale:1;
 	unsigned int		connector;
 	struct backlight_device	*backlight;
+	/*
+	 * If the B/R lines are switched between the CLCD
+	 * and the panel we need to know this and not try to
+	 * compensate with the BGR bit in the control register.
+	 */
+	bool			bgr_connection;
 };
 
 struct clcd_regs {
@@ -234,16 +240,27 @@ static inline void clcdfb_decode(struct clcd_fb *fb, struct clcd_regs *regs)
 	if (var->grayscale)
 		val |= CNTL_LCDBW;
 
-	if (fb->panel->caps && fb->board->caps &&
-	    var->bits_per_pixel >= 16) {
+	if (fb->panel->caps && fb->board->caps && var->bits_per_pixel >= 16) {
 		/*
 		 * if board and panel supply capabilities, we can support
-		 * changing BGR/RGB depending on supplied parameters
+		 * changing BGR/RGB depending on supplied parameters. Here
+		 * we switch to what the framebuffer is providing if need
+		 * be, so if the framebuffer is BGR but the display connection
+		 * is RGB (first case) we switch it around. Vice versa mutatis
+		 * mutandis if the framebuffer is RGB but the display connection
+		 * is BGR, we flip it around.
 		 */
-		if (var->red.offset = 0)
-			val &= ~CNTL_BGR;
-		else
-			val |= CNTL_BGR;
+		if (!fb->panel->bgr_connection) {
+			if (var->red.offset = 0)
+				val &= ~CNTL_BGR;
+			else
+				val |= CNTL_BGR;
+		} else {
+			if (var->blue.offset = 0)
+				val &= ~CNTL_BGR;
+			else
+				val |= CNTL_BGR;
+		}
 	}
 
 	switch (var->bits_per_pixel) {
-- 
2.4.3

