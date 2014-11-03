From: Marek Belisko <marek@goldelico.com>
Date: Mon, 03 Nov 2014 21:59:26 +0000
Subject: [PATCH 2/4] Documentation: DT: Add documentation for ti,opa362 bindings
Message-Id: <1415051968-4878-3-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1415051968-4878-1-git-send-email-marek@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 .../devicetree/bindings/video/ti,opa362.txt        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/ti,opa362.txt

diff --git a/Documentation/devicetree/bindings/video/ti,opa362.txt b/Documentation/devicetree/bindings/video/ti,opa362.txt
new file mode 100644
index 0000000..d7ed11a
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/ti,opa362.txt
@@ -0,0 +1,38 @@
+OPA362 analog video amplifier
+
+Required properties:
+- compatible: "ti,opa362"
+- gpio: enable/disable output gpio
+
+Required node:
+- Video port 0 for opa362 input
+- Video port 1 for opa362 output
+
+Example:
+
+tv_amp: opa362 {
+	 compatible = "ti,opa362";
+	 gpios = <&gpio1 23 0>;  /* GPIO to enable video out amplifier */
+	 
+	label = "opa362";
+	 ports {
+		 #address-cells = <1>;
+		 #size-cells = <0>;
+		 port@0 {
+			 reg = <0>;
+			 opa_in: endpoint@0 {
+				 remote-endpoint = <&venc_out>;
+			 };
+		 };
+
+		 port@1 {
+			 reg = <1>;
+			 opa_out: endpoint@0 {
+				 remote-endpoint = <&tv_connector_in>;
+			 };
+		 };
+	 };
+ };
+
+
+
-- 
1.9.1

