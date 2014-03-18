From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 18 Mar 2014 08:15:41 +0000
Subject: [PATCHv2 2/8] Doc/DT: Add DT binding documentation for Analog TV Connector
Message-Id: <1395130547-18633-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395130547-18633-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1395130547-18633-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>

Add DT binding documentation for Analog TV Connector.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 .../bindings/video/analog-tv-connector.txt         | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/analog-tv-connector.txt

diff --git a/Documentation/devicetree/bindings/video/analog-tv-connector.txt b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
new file mode 100644
index 000000000000..0218fcdc1299
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
@@ -0,0 +1,25 @@
+Analog TV Connector
+=========+
+Required properties:
+- compatible: "composite-connector" or "svideo-connector"
+
+Optional properties:
+- label: a symbolic name for the connector
+
+Required nodes:
+- Video port for TV input
+
+Example
+-------
+
+tv: connector {
+	compatible = "composite-connector";
+	label = "tv";
+
+	port {
+		tv_connector_in: endpoint {
+			remote-endpoint = <&venc_out>;
+		};
+	};
+};
-- 
1.8.3.2

