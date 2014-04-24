From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:16:58 +0000
Subject: [PATCH 02/23] Doc/DT: ti,omap4-dss: hdmi lanes
Message-Id: <1398334639-14172-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add documentation for defining HDMI lane functions and polarities.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/video/ti,omap4-dss.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/ti,omap4-dss.txt b/Documentation/devicetree/bindings/video/ti,omap4-dss.txt
index f85d6fcfa705..b8c29fbd1fbb 100644
--- a/Documentation/devicetree/bindings/video/ti,omap4-dss.txt
+++ b/Documentation/devicetree/bindings/video/ti,omap4-dss.txt
@@ -109,3 +109,7 @@ Required properties:
 
 Optional nodes:
 - Video port for HDMI output
+
+HDMI Endpoint optional properties:
+- lanes: list of 8 pin numbers for the HDMI lanes: CLK+, CLK-, D0+, D0-,
+  D1+, D1-, D2+, D2-. (default: 0,1,2,3,4,5,6,7)
-- 
1.9.1

