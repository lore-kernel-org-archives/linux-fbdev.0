From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 02 Sep 2014 07:35:46 +0000
Subject: [PATCH] video: fix composite video connector compatible string
Message-Id: <1409643346-8656-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The quite-recently-added analog-tv-connector bindings say that the
compatible string for composite video connector is
"composite-connector". That string is also used in the omap3-n900.dts
file. However, the connector driver uses "composite-video-connector", so
this has never worked.

While changing the driver's compatible string to "composite-connector"
would be safer, as published DT bindings should not be changed, I'd
rather fix the bindings in this case for two reasons:

* composite-connector is a bit too generic name, as it doesn't even hint
  at video.
* it's clear that this has never worked, which means no one has used
  those bindings, which should make it safe to change this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/video/analog-tv-connector.txt | 4 ++--
 arch/arm/boot/dts/omap3-n900.dts                                | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/analog-tv-connector.txt b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
index 0218fcdc1299..0c0970c210ab 100644
--- a/Documentation/devicetree/bindings/video/analog-tv-connector.txt
+++ b/Documentation/devicetree/bindings/video/analog-tv-connector.txt
@@ -2,7 +2,7 @@ Analog TV Connector
 ========= 
 Required properties:
-- compatible: "composite-connector" or "svideo-connector"
+- compatible: "composite-video-connector" or "svideo-connector"
 
 Optional properties:
 - label: a symbolic name for the connector
@@ -14,7 +14,7 @@ Example
 -------
 
 tv: connector {
-	compatible = "composite-connector";
+	compatible = "composite-video-connector";
 	label = "tv";
 
 	port {
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 1fe45d1f75ec..4361777a08d8 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -93,7 +93,7 @@
 	};
 
 	tv: connector {
-		compatible = "composite-connector";
+		compatible = "composite-video-connector";
 		label = "tv";
 
 		port {
-- 
1.9.1

