From: Ajay Kumar <ajaykumar.rs@samsung.com>
Date: Tue, 09 Oct 2012 14:05:24 +0000
Subject: [PATCH V4 2/2] video: exynos_dp: device tree documentation
Message-Id: <1349824101-32574-3-git-send-email-ajaykumar.rs@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349824101-32574-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1349824101-32574-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, jg1.han@samsung.com, devicetree-discuss@lists.ozlabs.org
Cc: FlorianSchandinat@gmx.de, sylvester.nawrocki@gmail.com, tomasz.figa@gmail.com, thomas.ab@samsung.com

Add documentation for the DT bindings in exynos display port driver.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
---
 .../devicetree/bindings/video/exynos_dp.txt        |   83 ++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/exynos_dp.txt

diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
new file mode 100644
index 0000000..a021963
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
@@ -0,0 +1,83 @@
+Exynos display port driver should configure the display port interface
+based on the type of panel connected to it.
+
+We use two nodes:
+	-dptx_phy node
+	-display-port-controller node
+
+For the dp-phy initialization, we use a dptx_phy node.
+Required properties for dptx_phy:
+	-compatible:
+		Should be "samsung,dp-phy".
+	-samsung,dptx_phy_reg:
+		Base address of DP PHY register.
+	-samsung,enable_mask:
+		The bit-mask used to enable/disable DP PHY.
+
+For the Panel initialization, we read data from display-port-controller node.
+Required properties for display-port-controller:
+	-compatible:
+		Should be "samsung,exynos5-dp".
+	-reg:
+		physical base address of the controller and length
+		of memory mapped region.
+	-interrupts:
+		Interrupt combiner values.
+	-interrupt-parent:
+		phandle to Interrupt combiner node.
+	-samsung,dp_phy:
+		phandle to dptx_phy node.
+	-samsung,color_space:
+		input video data format.
+			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
+	-samsung,dynamic_range:
+		dynamic range for input video data.
+			VESA = 0, CEA = 1
+	-samsung,ycbcr_coeff:
+		YCbCr co-efficients for input video.
+			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
+	-samsung,color_depth:
+		Number of bits per colour component.
+			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
+	-samsung,link_rate:
+		link rate supported by the panel.
+			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
+	-samsung,lane_count:
+		number of lanes supported by the panel.
+			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
+	-samsung,interlaced:
+		Interlace scan mode.
+			Progressive if defined, Interlaced if not defined
+	-samsung,v_sync_polarity:
+		VSYNC polarity configuration.
+			High if defined, Low if not defined
+	-samsung,h_sync_polarity:
+		HSYNC polarity configuration.
+			High if defined, Low if not defined
+
+Example:
+
+SOC specific portion:
+	dptx_phy: dptx_phy@0x10040720 {
+		compatible = "samsung,dp-phy";
+		samsung,dptx_phy_reg = <0x10040720>;
+		samsung,enable_mask = <1>;
+	};
+
+	display-port-controller {
+		compatible = "samsung,exynos5-dp";
+		reg = <0x145B0000 0x10000>;
+		interrupts = <10 3>;
+		interrupt-parent = <&combiner>;
+		samsung,dp_phy = <&dptx_phy>;
+        };
+
+Board Specific portion:
+	display-port-controller {
+		samsung,color_space = <0>;
+		samsung,dynamic_range = <0>;
+		samsung,ycbcr_coeff = <0>;
+		samsung,color_depth = <1>;
+		samsung,link_rate = <0x0a>;
+		samsung,lane_count = <2>;
+	};
-- 
1.7.0.4

