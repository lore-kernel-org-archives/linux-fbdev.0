From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:06 +0000
Subject: [PATCH v2 11/12] ASoC: tegra: register dependency parser for firmware nodes
Message-Id: <1435743667-11987-12-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>

So others can find out what dependencies a nvidia,tegra-audio-max98090
device has, as specified in
bindings/sound/nvidia,tegra-audio-max98090.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 sound/soc/tegra/tegra_max98090.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
index 902da36..0f7cbf3 100644
--- a/sound/soc/tegra/tegra_max98090.c
+++ b/sound/soc/tegra/tegra_max98090.c
@@ -316,7 +316,47 @@ static struct platform_driver tegra_max98090_driver = {
 	.probe = tegra_max98090_probe,
 	.remove = tegra_max98090_remove,
 };
-module_platform_driver(tegra_max98090_driver);
+
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
+static void tegra_max98090_get_dependencies(struct fwnode_handle *fwnode,
+					    struct list_head *deps)
+{
+	add_dependency(fwnode, "nvidia,i2s-controller", deps);
+	add_dependency(fwnode, "nvidia,audio-codec", deps);
+}
+
+static int __init tegra_max98090_init(void)
+{
+	int err;
+
+	err = platform_driver_register(&tegra_max98090_driver);
+	if (err < 0)
+		return err;
+
+	fwnode_add_dependency_parser(tegra_max98090_get_dependencies);
+
+	return 0;
+}
+module_init(tegra_max98090_init);
+
+static void __exit tegra_max98090_exit(void)
+{
+	fwnode_remove_dependency_parser(tegra_max98090_get_dependencies);
+	platform_driver_unregister(&tegra_max98090_driver);
+}
+module_exit(tegra_max98090_exit);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra max98090 machine ASoC driver");
-- 
2.4.1

