From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 Mar 2013 08:45:20 +0000
Subject: [RFC 13/14] ARM: omap3-tobi.dts: add lcd (TEST)
Message-Id: <1364373921-7599-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364373921-7599-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364373921-7599-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Andy Gross <andy.gross-l0cyMroinI0@public.gmane.org>

This is a test for Overo with Palo43 expansion, _not_ Tobi. Palo43
doesn't have a dts, but seems to work ok with omap3-tobi.dts, so I used
it as a test.

Not to be merged.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3-tobi.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-tobi.dts b/arch/arm/boot/dts/omap3-tobi.dts
index a13d12d..68e3c1b 100644
--- a/arch/arm/boot/dts/omap3-tobi.dts
+++ b/arch/arm/boot/dts/omap3-tobi.dts
@@ -33,3 +33,16 @@
 &mmc3 {
 	status = "disabled";
 };
+
+&dpi {
+	vdds_dsi-supply = <&vpll2>;
+};
+
+/ {
+	lcd43 {
+		compatible = "ti,dpi_panel";
+		video-source = <&dpi>;
+		data-lines = <24>;
+		panel-name = "samsung_lte430wq_f0c";
+	};
+};
-- 
1.7.10.4

