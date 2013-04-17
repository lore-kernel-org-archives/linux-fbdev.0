From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 17 Apr 2013 15:17:16 +0000
Subject: [RFC 04/10] video: display: Add generic TFT display type
Message-Id: <1366211842-21497-5-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1366211842-21497-1-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>

TFT panels may be interfaced via a simple parallel interface
carrying RGB data, pixel clock and synchronisation signals.
From the video generator point of view the width of the data
channels (number of bits per R/G/B components) may be an
important factor in setting up the display model.

Above information is based on the presentations by Dave Anders
available here: http://elinux.org/Elc-lcd

This patch adds the parallel TFT display type and basic parameters
structure. Maybe it should be split into a separate header, eg.
include/video/tft.h? Or maybe it's just the INTERFACE_DPI I'm
talking about?

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 include/video/display.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/video/display.h b/include/video/display.h
index 7fe8b2f..875e230 100644
--- a/include/video/display.h
+++ b/include/video/display.h
@@ -69,10 +69,19 @@ enum display_entity_stream_state {
 
 enum display_entity_interface_type {
 	DISPLAY_ENTITY_INTERFACE_DPI,
+	DISPLAY_ENTITY_INTERFACE_TFT_PARALLEL,
+};
+
+struct tft_parallel_interface_params {
+	int r_bits, g_bits, b_bits;
+	int r_b_swapped;
 };
 
 struct display_entity_interface_params {
 	enum display_entity_interface_type type;
+	union {
+		struct tft_parallel_interface_params tft_parallel;
+	} p;
 };
 
 struct display_entity_control_ops {
-- 
1.7.10.4


