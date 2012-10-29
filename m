From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Mon, 29 Oct 2012 07:33:06 +0000
Subject: [PATCH 2/2] video: da8xx-fb: add device tree binding information
Message-Id: <1351495266-1202-2-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351495266-1202-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1351495266-1202-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: FlorianSchandinat@gmx.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, davinci-linux-open-source@linux.davincidsp.com, linux-doc@vger.kernel.org, rob@landley.net, s.trumtrar@pengutronix.de, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 Documentation/devicetree/bindings/fb/da8xx-fb.txt |   86 +++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/da8xx-fb.txt

diff --git a/Documentation/devicetree/bindings/fb/da8xx-fb.txt b/Documentation/devicetree/bindings/fb/da8xx-fb.txt
new file mode 100644
index 0000000..3fc2ef9
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/da8xx-fb.txt
@@ -0,0 +1,86 @@
+* Texas Instruments DaVinci da8xx-fb
+
+This file provides information of da830-fb device node.
+
+Required properties:
+- compatible :		"ti,da830-lcd" : for DA830, DA850 and am335x platforms
+- reg :			Offset and length of the register set for the device.
+- interrupts :		standard interrupt property.
+- interrupt-parent :	The phandle for the interrupt controller that
+			services interrupts for this device.
+- panel_shade : 	panel shade for-ex MONOCHROME, PASSIVE, ACTIVE.
+- bpp : 		bits per pixel resolution.
+- display-timings: 	Panel timing information.
+
+Optional properties:
+- ac-bias :		AC Bias Pin Frequency. This value defines the
+			number of Line Clock (LCD_HSYNC) cycles to count
+			before transitioning signal LCD_AC_ENB_CS. This
+			output may be used to periodically invert the
+			polarity of the power supply in order to prevent a
+			display DC charge build-up on the LCD panel.
+
+- ac-bias-intrpt :	This value is used to specify the number of AC
+			Bias(LCD_AC_ENB_CS) output transition counts
+			before setting the AC bias interrupt bit in
+			register LCD_STAT. This counter is stopped when
+			the interrupt is set and remains stopped until the
+			AC bias interrupt status is cleared. A value of
+			zero will not produce an interrupt.
+
+- tft-alt-mode :	TFT Alternative Signal Mapping
+- stn-565-mode :	12-Bit-Per-Pixel (5-6-5) Mode. This is only
+			available in passive-color (STN) mode when 12 BPP
+			is specified in the palette.
+
+- mono-8bit-mode :	Mono 8-bit Mode
+
+- sync-edge :		This determines whether the HSYNC/VSYNC is driven
+			on the rising or falling edge of the pixel clock
+
+- raster-order :	Decides data order, if 0 frame buffer data is
+			ordered from least-to-most significant bit/nibble/
+			byte/word/d-word else most-to- least significant..
+
+- panel :		panel name along manufacturer name.
+- dma-burst-sz :	Burst Size setting for DMA transfers
+- fifo-threshold :	DMA FIFO threshold. The input FIFO becomes ready
+			so that the Raster controller can start reading
+			its content only when the number of dwords (1
+			dword is 4 bytes) specified by TH_FIFO_READY have
+			been loaded by the DMA from the frame buffer to
+			the input FIFO.
+
+- fdd :			FIFO DMA Request Delay. Encoded value used to
+			specify the number of clocks the input FIFO DMA
+			request should be disabled. The delay clock count
+			starts after 16 words are loaded into the input
+			FIFO.
+
+Example for da850-evm:
+	lcd0: lcd@1e13000 {
+		compatible = "ti,da8xx-lcd";
+		reg = <0x213000 0x1000>;
+		clock-frequency = <150000000>;
+		interrupts = <52>;
+		interrupt-parent = <&intc>;
+		panel_shade = <1>;
+		bpp = <16>;
+		display-timings {
+			default-timing = <&timing0>;
+			timing0: 480x272p53 {
+				clock = <7833600>;
+				hactive = <480>;
+				vactive = <272>;
+				hfront-porch = <2>;
+				hback-porch = <2>;
+				hsync-len = <41>;
+				vback-porch = <3>;
+				vfront-porch = <3>;
+				vsync-len = <10>;
+				hsync-active-high;
+				vsync-active-high;
+			};
+		};
+	};
+
-- 
1.7.0.4

