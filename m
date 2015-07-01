From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:04 +0000
Subject: [PATCH v2 09/12] regulator: register dependency parser for firmware nodes
Message-Id: <1435743667-11987-10-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org

So others can find out what depends on regulators, as specified
in bindings/regulator/regulator.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/regulator/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c9f7201..535cad0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4112,6 +4112,31 @@ static const struct file_operations regulator_summary_fops = {
 #endif
 };
 
+static void regulator_get_dependencies(struct fwnode_handle *fwnode,
+				       struct list_head *deps)
+{
+	struct device_node *np;
+	struct property *pp;
+	struct device_node *dep;
+
+	np = to_of_node(fwnode);
+	if (!np)
+		return;
+
+	for_each_property_of_node(np, pp) {
+		if (!strends(pp->name, "-supply"))
+			continue;
+
+		dep = of_parse_phandle(np, pp->name, 0);
+		if (!dep)
+			continue;
+
+		fwnode_add_dependency(&dep->fwnode, deps);
+
+		of_node_put(dep);
+	}
+}
+
 static int __init regulator_init(void)
 {
 	int ret;
@@ -4130,6 +4155,8 @@ static int __init regulator_init(void)
 
 	regulator_dummy_init();
 
+	fwnode_add_dependency_parser(regulator_get_dependencies);
+
 	return ret;
 }
 
-- 
2.4.1

