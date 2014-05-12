From: Jyri Sarha <jsarha@ti.com>
Date: Mon, 12 May 2014 09:12:26 +0000
Subject: [PATCH 15/19] ARM: omap5.dtsi: Add audio related parameters to hdmi node
Message-Id: <3e3b77eae539bfb78db12edc1e942d3ceea01a40.1399884780.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1399884780.git.jsarha@ti.com>
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds HDMI audio sDMA properties.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b2a28e6..bac7d8e 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -931,6 +931,8 @@
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

