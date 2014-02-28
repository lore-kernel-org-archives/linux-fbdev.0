From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 12:20:16 +0000
Subject: [PATCH 9/9] Doc/DT: Add DT binding documentation for tpd12s015 encoder
Message-Id: <1393590016-9361-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for tpd12s015 encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/ti,tpd12s015.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,tpd12s015.txt

diff --git a/Documentation/devicetree/bindings/video/ti,tpd12s015.txt b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
new file mode 100644
index 000000000000..26e6d32e3f20
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,tpd12s015.txt
@@ -0,0 +1,44 @@
+TPD12S015 HDMI level shifter and ESD protection chip
+==========================
+
+Required properties:
+- compatible: "ti,tpd12s015"
+
+Optional properties:
+- gpios: CT CP HPD, LS OE and HPD gpios
+
+Required nodes:
+- Video port 0 for HDMI input
+- Video port 1 for HDMI output
+
+Example
+-------
+
+tpd12s015: encoder@1 {
+	compatible = "ti,tpd12s015";
+
+	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
+		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
+		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			tpd12s015_in: endpoint@0 {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			tpd12s015_out: endpoint@0 {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
-- 
1.8.3.2

