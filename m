From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Wed, 25 Feb 2015 21:01:19 +0000
Subject: [PATCH] video: ARM CLCD: Added dt support to set tim2 register
Message-Id: <1424898082-1522-1-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Arun Ramamurthy <arun.ramamurthy@broadcom.com>

Added code based on linaro tree:
http://git.linaro.org/kernel/linux-linaro-stable.git
with commit id:6846e7822c4cab5a84672baace3b768c2d0db142
at drivers/video/amba-clcd.c. This lets the driver set
certain tim2 register bits after reading them from
device tree.

Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
---
 .../devicetree/bindings/video/arm,pl11x.txt        | 17 ++++++++-
 drivers/video/fbdev/amba-clcd.c                    | 41 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
index 3e3039a..14d6f87 100644
--- a/Documentation/devicetree/bindings/video/arm,pl11x.txt
+++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
@@ -35,6 +35,21 @@ Optional properties:
 	cell's memory interface can handle; if not present, the memory
 	interface is fast enough to handle all possible video modes
 
+- tim2: Used to set certain bits in LCDTiming2 register.
+	It can be TIM2_CLKSEL or TIM2_IOE or both
+
+	TIM2_CLKSEL: This bit drives the CLCDCLKSEL signal. It is the select
+	signal for the external LCD clock multiplexor.
+
+	TIM2_IOE: Invert output enable:
+	0 = CLAC output pin is active HIGH in TFT mode
+	1 = CLAC output pin is active LOW in TFT mode.
+	This bit selects the active polarity of the output enable signal in
+	TFT mode. In this mode, the CLAC pin is an enable that indicates to
+	the LCD panel when valid display data is available. In active
+	display mode, data is driven onto the LCD data lines at the
+	programmed edge of CLCP when CLAC is in its active state.
+
 Required sub-nodes:
 
 - port: describes LCD panel signals, following the common binding
@@ -76,7 +91,7 @@ Example:
 		clocks = <&oscclk1>, <&oscclk2>;
 		clock-names = "clcdclk", "apb_pclk";
 		max-memory-bandwidth = <94371840>; /* Bps, 1024x768@60 16bpp */
-
+		tim2 = "TIM2_CLKSEL";
 		port {
 			clcd_pads: endpoint {
 				remote-endpoint = <&clcd_panel>;
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 32c0b6b..4e4e50f 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -41,6 +41,44 @@
 /* This is limited to 16 characters when displayed by X startup */
 static const char *clcd_name = "CLCD FB";
 
+struct string_lookup {
+	const char	*string;
+	const u32	val;
+};
+
+static const struct string_lookup tim2_lookups[] = {
+	{ "TIM2_CLKSEL",	TIM2_CLKSEL},
+	{ "TIM2_IOE",		TIM2_IOE},
+	{ NULL, 0},
+};
+
+static u32 parse_setting(const struct string_lookup *lookup, const char *name)
+{
+	int i = 0;
+
+	while (lookup[i].string != NULL) {
+		if (strcmp(lookup[i].string, name) = 0)
+			return lookup[i].val;
+		++i;
+	}
+	return 0;
+}
+
+static u32 get_string_lookup(struct device_node *node, const char *name,
+		      const struct string_lookup *lookup)
+{
+	const char *string;
+	int count, i;
+	u32 ret = 0;
+
+	count = of_property_count_strings(node, name);
+	if (count >= 0)
+		for (i = 0; i < count; i++)
+			if (of_property_read_string_index(node, name, i,
+					&string) = 0)
+				ret |= parse_setting(lookup, string);
+	return ret;
+}
 /*
  * Unfortunately, the enable/disable functions may be called either from
  * process or IRQ context, and we _need_ to delay.  This is _not_ good.
@@ -626,6 +664,9 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 r0, u32 g0, u32 b0)
 	/* Bypass pixel clock divider, data output on the falling edge */
 	fb->panel->tim2 = TIM2_BCD | TIM2_IPC;
 
+	fb->panel->tim2 |= get_string_lookup(fb->dev->dev.of_node,
+					"tim2", tim2_lookups);
+
 	/* TFT display, vert. comp. interrupt at the start of the back porch */
 	fb->panel->cntl |= CNTL_LCDTFT | CNTL_LCDVCOMP(1);
 
-- 
2.3.0

