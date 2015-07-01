From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:01 +0000
Subject: [PATCH v2 06/12] backlight: Document consumers of backlight nodes
Message-Id: <1435743667-11987-7-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>

Add a small note that makes explicit that properties named 'backlight'
contain phandles to backlight nodes.

This is needed so that we can automatically extract dependencies on
backlight devices by assuming that a property with that name contains a
phandle to such a device.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Document that consumers of backlight devices can use the 'backlight'
  property to hold a phandle to the backlight device.

 .../bindings/video/backlight/backlight.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/backlight/backlight.txt

diff --git a/Documentation/devicetree/bindings/video/backlight/backlight.txt b/Documentation/devicetree/bindings/video/backlight/backlight.txt
new file mode 100644
index 0000000..309949d
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/backlight/backlight.txt
@@ -0,0 +1,22 @@
+Specifying backlight information for devices
+======================
+
+Backlight user nodes
+--------------------
+
+Nodes such as display panels that refer to backlight devices can do so by simply having a property named 'backlight' that contains a phandle to a backlight node.
+
+Example:
+
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+	};
+
+	[...]
+
+	panel: panel {
+		compatible = "cptt,claa101wb01";
+
+		backlight = <&backlight>;
+	};
-- 
2.4.1

