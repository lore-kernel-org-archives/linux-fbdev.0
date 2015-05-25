From: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Date: Mon, 25 May 2015 22:36:09 +0000
Subject: [PATCH v4 2/3] Phy: DT binding documentation for Broadcom Cygnus USB PHY driver
Message-Id: <1432593370-14457-3-git-send-email-arun.ramamurthy@broadcom.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1432593370-14457-1-git-send-email-arun.ramamurthy@broadcom.com>
In-Reply-To: <1432593370-14457-1-git-send-email-arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arun Ramamurthy <arun.ramamurthy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Broadcom's Cygnus chip has a USB 2.0 host controller connected to
three separate phys. One of the phs (port 2) is also connectd to
a usb 2.0 device controller

Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../bindings/phy/brcm,cygnus-usb-phy.txt           | 69 ++++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |  2 +
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
new file mode 100644
index 0000000..ec62044
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
@@ -0,0 +1,69 @@
+BROADCOM CYGNUS USB PHY
+
+Required Properties:
+	- compatible:  brcm,cygnus-usb-phy
+	- reg : usbphy_regs - Base address of phy registers
+			usb2h_idm_regs - Base address of host idm registers
+			usb2d_idm_regs - Base address of device idm registers
+	- phy-cells - must be 1 for each port declared. The node
+		      that uses the phy must provide either PHY_CONFIG_DEVICE for device
+		      or PHY_CONFIG_HOST for host
+
+NOTE: port 0 and port 1 are host only and port 2 can be configured for host or
+device.
+
+Example of phy :
+	usbphy0: usbphy@0x0301c000 {
+		compatible = "brcm,cygnus-usb-phy";
+		reg = <0x0301c000 0x2000>,
+		      <0x18115000 0x1000>,
+		      <0x18111000 0x1000>;
+		status = "okay";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		usbphy0_0: usbphy0@0 {
+			#phy-cells = <1>;
+			reg = <0>;
+			status = "okay";
+			phy-supply = <&vbus_p0>;
+		};
+
+		usbphy0_1: usbphy0@1 {
+			#phy-cells = <1>;
+			reg = <1>;
+			status = "okay";
+		};
+
+		usbphy0_2: usbphy0@2 {
+			#phy-cells = <1>;
+			reg = <2>;
+			status = "okay";
+			phy-supply = <&vbus_p2>;
+		};
+	};
+
+Example of node using the phy:
+
+	/* This nodes declares all three ports as host */
+
+	ehci0: usb@0x18048000 {
+		compatible = "generic-ehci";
+		reg = <0x18048000 0x100>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&usbphy0_0 PHY_CONFIG_HOST &usbphy0_1 PHY_CONFIG_HOST &usbphy0_2 PHY_CONFIG_HOST>;
+		status = "okay";
+	};
+
+	/*
+	 * This node declares port 2 phy
+	 * and configures it for device
+	 */
+
+	usbd_udc_dwc1: usbd_udc_dwc@0x1804c000 {
+		compatible = "iproc-udc";
+		reg = <0x1804c000 0x2000>;
+		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		phys = <&usbphy0_2 PHY_CONFIG_DEVICE>;
+		phy-names = "usb";
+	};
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 6c90193..a5babbc 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -15,5 +15,7 @@
 #define PHY_TYPE_PCIE		2
 #define PHY_TYPE_USB2		3
 #define PHY_TYPE_USB3		4
+#define PHY_USB2_CONFIG_HOST	0
+#define PHY_USB2_CONFIG_DEVICE	1
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.3.4

