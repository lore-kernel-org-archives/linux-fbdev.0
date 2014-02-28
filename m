From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 28 Feb 2014 12:20:13 +0000
Subject: [PATCH 6/9] Doc/DT: Add DT binding documentation for MIPI DSI CM Panel
Message-Id: <1393590016-9361-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for MIPI DSI Command Mode Panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/panel-dsi-cm.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt

diff --git a/Documentation/devicetree/bindings/video/panel-dsi-cm.txt b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
new file mode 100644
index 000000000000..73f422556d4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
@@ -0,0 +1,26 @@
+Generic MIPI DSI Command Mode Panel
+=================+
+Required properties:
+- compatible: "panel-dsi-cm"
+
+Optional properties:
+- label: a symbolic name for the panel
+- gpios: panel reset gpio and TE gpio
+
+Required nodes:
+- Video port for DSI input
+
+Example
+-------
+
+lcd0: display {
+	compatible = "tpo,taal", "panel-dsi-cm";
+	label = "lcd0";
+
+	gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102, reset */
+
+	lcd0_in: endpoint {
+		remote-endpoint = <&dsi1_out_ep>;
+	};
+};
-- 
1.8.3.2

