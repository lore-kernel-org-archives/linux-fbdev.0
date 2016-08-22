From: Olimpiu Dejeu <olimpiu@arcticsand.com>
Date: Mon, 22 Aug 2016 19:11:24 +0000
Subject: [PATCH] backlight: arcxcnn: devicetree bindings for ArticSand devices
Message-Id: <1471893084-4551-1-git-send-email-olimpiu@arcticsand.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>

This is the device tree bindings documentation file

Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>

---
 .../bindings/video/backlight/arcxcnn.txt           | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/arcxcnn.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt b/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt
new file mode 100644
index 0000000..9cd7315
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/arcxcnn.txt
@@ -0,0 +1,29 @@
+arcxcnn bindings
+
+Required properties:
+  - compatible: "arc,arcxcnn", "arc,arc2c0608"
+  - reg: I2C slave address (u8)
+
+Optional properties:
+  - bl-name: Backlight device name (string)
+  - init-brt: Initial value of backlight brightness (u32) low 16 bits used
+  - pwm-period: PWM period value. Set only PWM input mode used (u32)
+  - prg-addr: Register address of ROM area to be updated (u32) low 8 bits used
+  - prg-val: Register value to be updated (u32) low 8 bits used
+
+Example:
+
+	/* ARC2C0608 */
+	backlight@30 {
+		compatible = "arc,arc2c0608";
+		reg = <0x30>;
+
+		init-brt = <123>;
+
+		/* LED0+1 string enabled */
+		prg_06h {
+			prg-addr = <0x06>;
+			prg-val = <0x83>;
+		};
+
+	};
-- 
1.9.1

