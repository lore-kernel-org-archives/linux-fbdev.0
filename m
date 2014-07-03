From: Daniel Jeong <gshark.jeong@gmail.com>
Date: Thu, 03 Jul 2014 06:01:17 +0000
Subject: [RFC v4 2/2] backlight: device tree: add new tps611xx backlight binding
Message-Id: <1404367277-12003-3-git-send-email-gshark.jeong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404367277-12003-1-git-send-email-gshark.jeong@gmail.com>
In-Reply-To: <1404367277-12003-1-git-send-email-gshark.jeong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Jeong <daniel.jeong@ti.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Daniel Jeong <gshark.jeong@gmail.com>

This commit is about tps611xx device tree documentation.

Signed-off-by: Daniel Jeong <gshark.jeong@gmail.com>
---
 .../video/backlight/tps611xx-backlight.txt         |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
new file mode 100644
index 0000000..7af8182
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
@@ -0,0 +1,24 @@
+TPS611xx family of backlight driver based on EasyScale.
+
+EasyScale is a simple but flexible one pin interface to configure the current.
+
+Required properties:
+- compatible: should contain at least one of
+  "ti,tps61158_bl"
+  "ti,tps61161_bl"
+  "ti,tps61163_bl"
+  "ti,tps61165_bl"
+- rfa-enable: enable request for acknowledge.
+  If RFA is enabled, the data byte includes the RFA bit and device will wait
+  and check acknowledge from device.
+- es-gpio : GPIO for easy-scale communication.(see GPIO binding[0])
+
+[0]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+	backlight {
+		compatible = "ti,tps61163";
+		rfa-enable;
+		es-gpio = <&gpio 45 0>;
+	};
-- 
1.7.9.5

