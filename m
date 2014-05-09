From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 May 2014 12:32:07 +0000
Subject: [PATCH 5/5] Doc/DT: hdmi-connector: add HPD GPIO documentation
Message-Id: <1399638727-23254-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1399638727-23254-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org

Add binding documentation for HDMI connector's HPD GPIO.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/video/hdmi-connector.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/video/hdmi-connector.txt b/Documentation/devicetree/bindings/video/hdmi-connector.txt
index ccccc19e2573..acd5668b1ce1 100644
--- a/Documentation/devicetree/bindings/video/hdmi-connector.txt
+++ b/Documentation/devicetree/bindings/video/hdmi-connector.txt
@@ -7,6 +7,7 @@ Required properties:
 
 Optional properties:
 - label: a symbolic name for the connector
+- hpd-gpios: HPD GPIO number
 
 Required nodes:
 - Video port for HDMI input
-- 
1.9.1

