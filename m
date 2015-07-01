From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:00 +0000
Subject: [PATCH v2 05/12] gpu: host1x: register dependency parser for firmware nodes
Message-Id: <1435743667-11987-6-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org

So others can find out dependencies of host1x clients, as specified in
bindings/gpu/nvidia,tegra20-host1x.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/gpu/host1x/dev.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 53d3d1d..5bb10b8 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -212,6 +212,29 @@ static struct platform_driver tegra_host1x_driver = {
 	.remove = host1x_remove,
 };
 
+static void add_dependency(struct fwnode_handle *fwnode,
+			   const char *property,
+			   struct list_head *deps)
+{
+	struct device_node *np;
+
+	np = of_parse_phandle(to_of_node(fwnode), property, 0);
+	if (!np)
+		return;
+
+	fwnode_add_dependency(&np->fwnode, deps);
+}
+
+static void host1x_get_dependencies(struct fwnode_handle *fwnode,
+				    struct list_head *deps)
+{
+	add_dependency(fwnode, "nvidia,dpaux", deps);
+	add_dependency(fwnode, "nvidia,panel", deps);
+	add_dependency(fwnode, "nvidia,ddc-i2c-bus", deps);
+	add_dependency(fwnode, "nvidia,hpd-gpio", deps);
+	add_dependency(fwnode, "ddc-i2c-bus", deps);
+}
+
 static int __init tegra_host1x_init(void)
 {
 	int err;
@@ -228,6 +251,8 @@ static int __init tegra_host1x_init(void)
 	if (err < 0)
 		goto unregister_host1x;
 
+	fwnode_add_dependency_parser(host1x_get_dependencies);
+
 	return 0;
 
 unregister_host1x:
@@ -240,6 +265,7 @@ module_init(tegra_host1x_init);
 
 static void __exit tegra_host1x_exit(void)
 {
+	fwnode_remove_dependency_parser(host1x_get_dependencies);
 	platform_driver_unregister(&tegra_mipi_driver);
 	platform_driver_unregister(&tegra_host1x_driver);
 	bus_unregister(&host1x_bus_type);
-- 
2.4.1

