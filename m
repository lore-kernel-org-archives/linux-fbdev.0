From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 18 Mar 2014 08:15:44 +0000
Subject: [PATCHv2 5/8] Doc/DT: Add DT binding documentation for MIPI DSI CM Panel
Message-Id: <1395130547-18633-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for MIPI DSI Command Mode Panel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../devicetree/bindings/video/panel-dsi-cm.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/panel-dsi-cm.txt

diff --git a/Documentation/devicetree/bindings/video/panel-dsi-cm.txt b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
new file mode 100644
index 000000000000..dce48eb9db57
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/panel-dsi-cm.txt
@@ -0,0 +1,29 @@
+Generic MIPI DSI Command Mode Panel
+=================+
+Required properties:
+- compatible: "panel-dsi-cm"
+
+Optional properties:
+- label: a symbolic name for the panel
+- reset-gpios: panel reset gpio
+- te-gpios: panel TE gpio
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
+	reset-gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
+
+	port {
+		lcd0_in: endpoint {
+			remote-endpoint = <&dsi1_out_ep>;
+		};
+	};
+};
-- 
1.8.3.2

