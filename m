From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 25 Feb 2015 21:01:22 +0000
Subject: [PATCH] video: ARM CLCD: Correcting timing checks for STN and TFT dispalys
Message-Id: <1424898082-1522-4-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Arun Ramamurthy <arun.ramamurthy@broadcom.com>

The minimum values for timing parameters such as left margin,
right margin etc are different for STN and TFT dispalys.
This commit fixes a check that does not account for
this difference.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
---
 include/linux/amba/clcd.h | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index 6a3bc2d..0fe8a17 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -288,16 +288,28 @@ static inline int clcdfb_check(struct clcd_fb *fb, struct fb_var_screeninfo *var
 	var->xres_virtual = var->xres = (var->xres + 15) & ~15;
 	var->yres_virtual = var->yres = (var->yres + 1) & ~1;
 
-#define CHECK(e,l,h) (var->e < l || var->e > h)
-	if (CHECK(right_margin, (5+1), 256) ||	/* back porch */
-	    CHECK(left_margin, (5+1), 256) ||	/* front porch */
-	    CHECK(hsync_len, (5+1), 256) ||
-	    var->xres > 4096 ||
-	    var->lower_margin > 255 ||		/* back porch */
-	    var->upper_margin > 255 ||		/* front porch */
-	    var->vsync_len > 32 ||
-	    var->yres > 1024)
-		return -EINVAL;
+#define CHECK(e, l, h) (var->e < l || var->e > h)
+	if (!(fb->panel->cntl & CNTL_LCDTFT)) {
+		if (CHECK(right_margin, (5+1), 256) ||	/* back porch */
+		CHECK(left_margin, (5+1), 256) ||	/* front porch */
+		CHECK(hsync_len, (5+1), 256) ||
+		var->xres > 4096 ||
+		var->lower_margin > 255 ||	/* back porch */
+		var->upper_margin > 255 ||	/* front porch */
+		var->vsync_len > 32 ||
+		var->yres > 1024)
+			return -EINVAL;
+	} else {
+		if (CHECK(right_margin, 1, 256) ||	/* back porch */
+		CHECK(left_margin, 1, 256) ||	/* front porch */
+		CHECK(hsync_len, 1, 256) ||
+		var->xres > 4096 ||
+		var->lower_margin > 255 ||	/* back porch */
+		var->upper_margin > 255 ||	/* front porch */
+		var->vsync_len > 32 ||
+		var->yres > 1024)
+			return -EINVAL;
+	}
 #undef CHECK
 
 	/* single panel mode: PCD = max(PCD, 1) */
-- 
2.3.0

