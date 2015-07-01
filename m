From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date: Wed, 01 Jul 2015 09:41:05 +0000
Subject: [PATCH v2 10/12] pwm: register dependency parser for firmware nodes
Message-Id: <1435743667-11987-11-git-send-email-tomeu.vizoso@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org

So others can find out what depends on pwm controllers, as specified
in bindings/pwm/pwm.txt.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/pwm/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3a7769f..81b4fc0 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -917,11 +917,39 @@ static const struct file_operations pwm_debugfs_ops = {
 	.release = seq_release,
 };
 
+static void pwm_get_dependencies(struct fwnode_handle *fwnode,
+				 struct list_head *deps)
+{
+	struct device_node *np;
+	struct of_phandle_args pspec;
+	int count, i, ret;
+
+	np = to_of_node(fwnode);
+	if (!np)
+		return;
+
+	count = of_count_phandle_with_args(np, "pwms",
+					   "#pwm-cells");
+	for (i = 0; i < count; i++) {
+		ret = of_parse_phandle_with_args(np, "pwms",
+						 "#pwm-cells", i,
+						 &pspec);
+		if (ret || !pspec.np)
+			continue;
+
+		fwnode_add_dependency(&pspec.np->fwnode, deps);
+
+		of_node_put(pspec.np);
+	}
+}
+
 static int __init pwm_debugfs_init(void)
 {
 	debugfs_create_file("pwm", S_IFREG | S_IRUGO, NULL, NULL,
 			    &pwm_debugfs_ops);
 
+	fwnode_add_dependency_parser(pwm_get_dependencies);
+
 	return 0;
 }
 
-- 
2.4.1

