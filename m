From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:40:59 +0000
Subject: [PATCH v2 04/12] gpio: register dependency parser for firmware nodes
Message-Id: <1435743667-11987-5-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>

So the GPIO subsystem can be queried about the dependencies of nodes
that consume GPIOs, as specified in bindings/gpio/gpio.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/gpio/gpiolib.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bf4bd1d..6a3e83f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2388,4 +2388,58 @@ static int __init gpiolib_debugfs_init(void)
 }
 subsys_initcall(gpiolib_debugfs_init);
 
+static void gpio_get_dependencies(struct fwnode_handle *fwnode,
+				  struct list_head *deps)
+{
+	struct device_node *np;
+	struct property *pp;
+	struct of_phandle_args pspec;
+	int count, i, ret;
+
+	np = to_of_node(fwnode);
+	if (!np)
+		return;
+
+	for_each_property_of_node(np, pp) {
+		if (strcmp(pp->name, "gpio") &&
+		    strcmp(pp->name, "gpios") &&
+		    !strends(pp->name, "-gpios") &&
+		    !strends(pp->name, "-gpio"))
+			continue;
+
+		count = of_count_phandle_with_args(np, pp->name,
+						   "#gpio-cells");
+		for (i = 0; i < count; i++) {
+			ret = of_parse_phandle_with_args(np, pp->name,
+							 "#gpio-cells", i,
+							 &pspec);
+			if (ret || !pspec.np)
+				continue;
+
+			fwnode_add_dependency(&pspec.np->fwnode, deps);
+
+			of_node_put(pspec.np);
+		}
+	}
+
+	for (i = 0;; i++) {
+		ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3,
+						       i, &pspec);
+		if (ret)
+			break;
+
+		fwnode_add_dependency(&pspec.np->fwnode, deps);
+
+		of_node_put(pspec.np);
+	}
+}
+
+static int __init gpiolib_init(void)
+{
+	fwnode_add_dependency_parser(gpio_get_dependencies);
+
+	return 0;
+}
+device_initcall(gpiolib_init);
+
 #endif	/* DEBUG_FS */
-- 
2.4.1

