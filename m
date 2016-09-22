From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 22 Sep 2016 10:35:24 +0000
Subject: [PATCH v2 1/3] dt-bindings: display: display-timing: Add property to configure sync drive edge
Message-Id: <20160922103526.24925-2-peter.ujfalusi@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160922103526.24925-1-peter.ujfalusi@ti.com>
In-Reply-To: <20160922103526.24925-1-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.vetter-/w4YWyX8dFk@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

There are display panels which demands that the sync signal is driven on
different edge than the pixel data.
With the syncclk-active property we can specify the clk edge to be used to
drive the sync signal. When the property is missing it indicates that the
sync is driven on the same edge as the pixel data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
---
 .../devicetree/bindings/display/panel/display-timing.txt          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/display-timing.txt b/Documentation/devicetree/bindings/display/panel/display-timing.txt
index e1d4a0b59612..81a75893d1b8 100644
--- a/Documentation/devicetree/bindings/display/panel/display-timing.txt
+++ b/Documentation/devicetree/bindings/display/panel/display-timing.txt
@@ -32,6 +32,14 @@ optional properties:
 			- active low  = drive pixel data on falling edge/
 					sample data on rising edge
 			- ignored     = ignored
+ - syncclk-active: with
+			- active high = drive sync on rising edge/
+					sample sync on falling edge of pixel
+					clock
+			- active low  = drive sync on falling edge/
+					sample sync on rising edge of pixel
+					clock
+			- omitted     = same configuration as pixelclk-active
  - interlaced (bool): boolean to enable interlaced mode
  - doublescan (bool): boolean to enable doublescan mode
  - doubleclk (bool): boolean to enable doubleclock mode
-- 
2.10.0

