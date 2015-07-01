From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:02 +0000
Subject: [PATCH v2 07/12] backlight: register dependency parser for firmware nodes
Message-Id: <1435743667-11987-8-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

So others can find out what depends on backlight devices, as specified
in bindings/video/backlight/backlight.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/video/backlight/backlight.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index bddc8b1..ab8f5e7 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -566,8 +566,22 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 EXPORT_SYMBOL(of_find_backlight_by_node);
 #endif
 
+static void backlight_get_dependencies(struct fwnode_handle *fwnode,
+					  struct list_head *deps)
+{
+	struct device_node *np;
+
+	np = of_parse_phandle(to_of_node(fwnode), "backlight", 0);
+	if (!np)
+		return;
+
+	fwnode_add_dependency(&np->fwnode, deps);
+}
+
 static void __exit backlight_class_exit(void)
 {
+	fwnode_remove_dependency_parser(backlight_get_dependencies);
+
 	class_destroy(backlight_class);
 }
 
@@ -586,6 +600,8 @@ static int __init backlight_class_init(void)
 	mutex_init(&backlight_dev_list_mutex);
 	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
 
+	fwnode_add_dependency_parser(backlight_get_dependencies);
+
 	return 0;
 }
 
-- 
2.4.1

