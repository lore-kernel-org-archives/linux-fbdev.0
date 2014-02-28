From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 12:20:14 +0000
Subject: [PATCH 7/9] Doc/DT: Add DT binding documentation for Sony acx565akm panel
Message-Id: <1393590016-9361-8-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for Sony acx565akm panel

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Sebastian Reichel <sre@debian.org>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/sony,acx565akm.txt   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt

diff --git a/Documentation/devicetree/bindings/video/sony,acx565akm.txt b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
new file mode 100644
index 000000000000..cd9cfdf7e3fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/sony,acx565akm.txt
@@ -0,0 +1,28 @@
+Sony ACX565AKM SDI Panel
+============
+
+Required properties:
+- compatible: "sony,acx565akm"
+
+Optional properties:
+- label: a symbolic name for the panel
+- gpios: panel reset gpio
+
+Required nodes:
+- Video port for SDI input
+
+Example
+-------
+
+acx565akm@2 {
+	compatible = "sony,acx565akm";
+	spi-max-frequency = <6000000>;
+	reg = <2>;
+
+	label = "lcd";
+	gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+
+	lcd_in: endpoint {
+		remote-endpoint = <&sdi_out>;
+	};
+};
-- 
1.8.3.2

