From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Tue, 28 Jul 2015 13:19:46 +0000
Subject: [PATCH v2 15/22] backlight: Probe backlight devices on demand
Message-Id: <1438089593-7696-16-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Lee Jones <lee.jones@linaro.org>

When looking up a backlight device through its firmware node, probe it
if it hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/video/backlight/backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index bddc8b17a4d8..f7151d916435 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -559,6 +559,8 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 {
 	struct device *dev;
 
+	fwnode_ensure_device(&node->fwnode);
+
 	dev = class_find_device(backlight_class, NULL, node, of_parent_match);
 
 	return dev ? to_backlight_device(dev) : NULL;
-- 
2.4.3

