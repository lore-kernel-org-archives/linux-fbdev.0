From: Daniel Jeong <gshark.jeong@gmail.com>
Date: Tue, 15 Jul 2014 10:09:18 +0000
Subject: [RFC v5 2/2] backlight: device tree: add new tps611xx backlight binding
Message-Id: <1405418958-7596-3-git-send-email-gshark.jeong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1405418958-7596-1-git-send-email-gshark.jeong@gmail.com>
In-Reply-To: <1405418958-7596-1-git-send-email-gshark.jeong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Jeong <daniel.jeong@ti.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Daniel Jeong <gshark.jeong@gmail.com>

This commit is about tps611xx device tree documentation.

Signed-off-by: Daniel Jeong <gshark.jeong@gmail.com>
---
 .../video/backlight/tps611xx-backlight.txt         |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
new file mode 100644
index 0000000..905c61b
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
@@ -0,0 +1,26 @@
+TPS611xx family of backlight driver based on EasyScale.
+
+EasyScale is a simple but flexible one pin interface to configure the current.
+
+Required properties:
+- compatible: should contain at least one of
+  "ti,tps61158"
+  "ti,tps61161"
+  "ti,tps61163"
+  "ti,tps61165"
+- es-gpio : GPIO for easy-scale communication.(see GPIO binding[0])
+
+Optional properties:
+- rfa-enable: enable request for acknowledge.
+  If RFA is enabled, the data byte includes the RFA bit and device will wait
+  and check acknowledge from device.
+
+[0]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+	backlight {
+		compatible = "ti,tps61163";
+		es-gpio = <&gpio 45 0>;
+		rfa-enable;
+	};
-- 
1.7.9.5

