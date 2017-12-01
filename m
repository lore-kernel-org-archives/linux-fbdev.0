From: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Fri, 01 Dec 2017 07:41:22 +0000
Subject: [PATCH v4 1/2] DTS: GTA04: improve panel compatibility string
Message-Id: <280160905017f67c91b96bf38ea9b6094ec277c3.1512114082.git.hns@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1512114082.git.hns@goldelico.com>
In-Reply-To: <cover.1512114082.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Official vendor string is now "tpo" and not "toppoly".

Requires patch "omapdrm: panel: fix compatible vendor string for td028ttec1"
so that the driver understands both.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 4504908c23fe..ec27ed67a22a 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -86,7 +86,7 @@
 
 		/* lcd panel */
 		lcd: td028ttec1@0 {
-			compatible = "toppoly,td028ttec1";
+			compatible = "tpo,td028ttec1";
 			reg = <0>;
 			spi-max-frequency = <100000>;
 			spi-cpol;
-- 
2.12.2

