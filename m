From: Daniel Jeong <gshark.jeong@gmail.com>
Date: Mon, 16 Jun 2014 02:17:23 +0000
Subject: [RFC 2/2] backlight: device tree: add new tps611xx backlight driver
Message-Id: <1402885043-3626-3-git-send-email-gshark.jeong@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1402885043-3626-1-git-send-email-gshark.jeong@gmail.com>
In-Reply-To: <1402885043-3626-1-git-send-email-gshark.jeong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Jeong <daniel.jeong@ti.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Daniel Jeong <gshark.jeong@gmail.com>

This commit is about tps611xx device tree documentation.

Signed-off-by: Daniel Jeong <gshark.jeong@gmail.com>
---
 .../video/backlight/tps611xx-backlight.txt         |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
new file mode 100644
index 0000000..8a0935d
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
@@ -0,0 +1,16 @@
+TPS611xx family of backlight driver based on EasyScale.
+
+It supports tps61158, tps61161, tps61163 and tps61165.
+
+Required properties:
+- compatible: "ti,tps61158_bl", "ti,tps61161_bl", "ti,tps61163_bl", "ti,tps61165_bl"
+- rfa_en: enable request for acknowledge.
+- en_gpio_num: gpio number for en pin.
+
+Example:
+
+	backlight {
+		compatible = "ti,tps61163_bl";
+		rfa_en = <1>;
+		en_gpio_num = <45>;
+	};
-- 
1.7.9.5

