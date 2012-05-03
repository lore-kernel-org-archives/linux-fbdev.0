From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 May 2012 13:57:48 +0000
Subject: [PATCH 12/25] OMAPDSS: create DPI & SDI devices
Message-Id: <1336053481-25433-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently have separate device/driver for each DSS HW module. The DPI
and SDI outputs are more or less parts of the DSS or DISPC hardware
modules, but in SW it makes sense to represent them as device/driver
pairs similarly to all the other outputs. This also makes sense for
device tree, as each node under dss will be a platform device, and
handling DPI & SDI somehow differently than the rest would just make the
code more complex.

This patch modifies arch/arm/mach-omap2/display.c to create platform
devices for DPI and SDI, and later patches will implement driver for
them.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 46d2a98..2c05a60 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -243,6 +243,46 @@ err:
 	return ERR_PTR(r);
 }
 
+static struct platform_device *create_simple_dss_pdev(const char *pdev_name,
+		int pdev_id, void *pdata, int pdata_len,
+		struct platform_device *parent)
+{
+	struct platform_device *pdev;
+	int r;
+
+	pdev = platform_device_alloc(pdev_name, pdev_id);
+	if (!pdev) {
+		pr_err("Could not create pdev for %s\n", pdev_name);
+		r = -ENOMEM;
+		goto err;
+	}
+
+	if (parent != NULL)
+		pdev->dev.parent = &parent->dev;
+
+	if (pdev->id != -1)
+		dev_set_name(&pdev->dev, "%s.%d", pdev->name, pdev->id);
+	else
+		dev_set_name(&pdev->dev, "%s", pdev->name);
+
+	r = platform_device_add_data(pdev, pdata, pdata_len);
+	if (r) {
+		pr_err("Could not set pdata for %s\n", pdev_name);
+		goto err;
+	}
+
+	r = omap_device_register(pdev);
+	if (r) {
+		pr_err("Could not register omap_device for %s\n", pdev_name);
+		goto err;
+	}
+
+	return pdev;
+
+err:
+	return ERR_PTR(r);
+}
+
 int __init omap_display_init(struct omap_dss_board_info *board_data)
 {
 	int r = 0;
@@ -299,6 +339,23 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 			dss_pdev = pdev;
 	}
 
+	/* Create devices for DPI and SDI */
+
+	pdev = create_simple_dss_pdev("omapdss_dpi", -1, NULL, 0, dss_pdev);
+	if (IS_ERR(pdev)) {
+		pr_err("Could not build platform_device for omapdss_dpi\n");
+		return PTR_ERR(pdev);
+	}
+
+	if (cpu_is_omap34xx()) {
+		pdev = create_simple_dss_pdev("omapdss_sdi", -1, NULL, 0,
+				dss_pdev);
+		if (IS_ERR(pdev)) {
+			pr_err("Could not build platform_device for omapdss_sdi\n");
+			return PTR_ERR(pdev);
+		}
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

