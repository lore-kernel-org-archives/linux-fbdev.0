From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 23 May 2014 19:07:50 +0000
Subject: [PATCH 01/13] ARM: omap4.dtsi: Add audio related parametes to hdmi node
Message-Id: <eaa737bbe296707ea52e650bf41735086f3349bd.1400871999.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1400871999.git.jsarha@ti.com>
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds HDMI audio sDMA properties.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 649b5cd..335ed54 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -919,6 +919,8 @@
 				ti,hwmods = "dss_hdmi";
 				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
 				clock-names = "fck", "sys_clk";
+				dmas = <&sdma 76>;
+				dma-names = "audio_tx";
 			};
 		};
 	};
-- 
1.7.9.5

