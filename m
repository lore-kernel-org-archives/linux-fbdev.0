From: Himangi Saraogi <himangi774@gmail.com>
Date: Sat, 21 Jun 2014 15:58:11 +0000
Subject: [PATCH] drivers/video/fbdev : dereference without an error test
Message-Id: <20140621155758.GA4741@himangi-Dell>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr

After a variable is assigned the result of backlight_device_register, an
error test should be performed before a dereference.

A simplified version of the semantic match that finds this problem is
as follows:

// <smpl>
@def0@
expression x;
position p0;
@@

x@p0 = backlight_device_register(...)

@protected@
expression def0.x,E;
position def0.p0;
position p;
statement S;
@@
x@p0
... when != x = E
if (!IS_ERR(x) && ...) {<... x@p ...>} else S

@unprotected@
expression def0.x,E;
identifier fld;
position def0.p0;
position p != protected.p;
@@
x@p0
... when != x = E
* x@p->fld
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
index c7ba4d8..acd9ff1 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
@@ -817,6 +817,10 @@ static int acx565akm_probe(struct spi_device *spi)
 
 	bldev = backlight_device_register("acx565akm", &ddata->spi->dev,
 			ddata, &acx565akm_bl_ops, &props);
+	if (IS_ERR(bldev)) {
+		r = PTR_ERR(bldev);
+		goto err_reg;
+	}
 	ddata->bl_dev = bldev;
 	if (ddata->has_cabc) {
 		r = sysfs_create_group(&bldev->dev.kobj, &bldev_attr_group);
@@ -862,6 +866,7 @@ err_reg:
 	sysfs_remove_group(&bldev->dev.kobj, &bldev_attr_group);
 err_sysfs:
 	backlight_device_unregister(bldev);
+err_reg:
 err_detect:
 err_gpio:
 	omap_dss_put_device(ddata->in);
-- 
1.9.1

