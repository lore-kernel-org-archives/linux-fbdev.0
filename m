From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 16 Oct 2012 02:17:32 +0000
Subject: [PATCH V8 2/2] video: exynos_dp: device tree documentation
Message-Id: <005c01cdab44$666eb6b0$334c2410$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, 'Ajay Kumar' <ajaykumar.rs@samsung.com>, 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, 'Tomasz Figa' <t.figa@samsung.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

From: Ajay Kumar <ajaykumar.rs@samsung.com>

Add documentation for the DT bindings in exynos display port driver.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
No changes since v7:

 .../devicetree/bindings/video/exynos_dp.txt        |   80 ++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/exynos_dp.txt

diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
new file mode 100644
index 0000000..7cc7d9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
@@ -0,0 +1,80 @@
+The Exynos display port interface should be configured based on
+the type of panel connected to it.
+
+We use two nodes:
+	-display-port-controller node
+	-dptx-phy node(defined inside display-port-controller node)
+
+For the DP-PHY initialization, we use the dptx-phy node.
+Required properties for dptx-phy:
+	-reg:
+		Base address of DP PHY register.
+	-samsung,enable-mask:
+		The bit-mask used to enable/disable DP PHY.
+
+For the Panel initialization, we read data from display-port-controller node.
+Required properties for display-port-controller:
+	-compatible:
+		should be "samsung,exynos5-dp".
+	-reg:
+		physical base address of the controller and length
+		of memory mapped region.
+	-interrupts:
+		interrupt combiner values.
+	-interrupt-parent:
+		phandle to Interrupt combiner node.
+	-samsung,color-space:
+		input video data format.
+			COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
+	-samsung,dynamic-range:
+		dynamic range for input video data.
+			VESA = 0, CEA = 1
+	-samsung,ycbcr-coeff:
+		YCbCr co-efficients for input video.
+			COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
+	-samsung,color-depth:
+		number of bits per colour component.
+			COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
+	-samsung,link-rate:
+		link rate supported by the panel.
+			LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
+	-samsung,lane-count:
+		number of lanes supported by the panel.
+			LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
+
+Optional properties for display-port-controller:
+	-interlaced:
+		interlace scan mode.
+			Progressive if defined, Interlaced if not defined
+	-vsync-active-high:
+		VSYNC polarity configuration.
+			High if defined, Low if not defined
+	-hsync-active-high:
+		HSYNC polarity configuration.
+			High if defined, Low if not defined
+
+Example:
+
+SOC specific portion:
+	display-port-controller {
+		compatible = "samsung,exynos5-dp";
+		reg = <0x145b0000 0x10000>;
+		interrupts = <10 3>;
+		interrupt-parent = <&combiner>;
+
+		dptx-phy {
+			reg = <0x10040720>;
+			samsung,enable-mask = <1>;
+		};
+
+        };
+
+Board Specific portion:
+	display-port-controller {
+		samsung,color-space = <0>;
+		samsung,dynamic-range = <0>;
+		samsung,ycbcr-coeff = <0>;
+		samsung,color-depth = <1>;
+		samsung,link-rate = <0x0a>;
+		samsung,lane-count = <4>;
+	};
-- 
1.7.1


