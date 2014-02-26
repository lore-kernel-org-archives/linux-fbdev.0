From: Denis Carikli <denis@eukrea.com>
Date: Wed, 26 Feb 2014 09:59:55 +0000
Subject: [PATCHv6][ 1/5] video: mx3fb: Use devm_kzalloc
Message-Id: <1393408800-8946-1-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Replace kzalloc by devm_kzalloc and remove the kfree() calls.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v5->v6:
 - New patch needed by "video: mx3fb: Add device tree suport."
---
 drivers/video/mx3fb.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 142e860..ee95de8 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1496,7 +1496,7 @@ static int mx3fb_probe(struct platform_device *pdev)
 	if (!sdc_reg)
 		return -EINVAL;
=20
-	mx3fb =3D kzalloc(sizeof(*mx3fb), GFP_KERNEL);
+	mx3fb =3D devm_kzalloc(&pdev->dev, sizeof(*mx3fb), GFP_KERNEL);
 	if (!mx3fb)
 		return -ENOMEM;
=20
@@ -1542,7 +1542,6 @@ ersdc0:
 	dmaengine_put();
 	iounmap(mx3fb->reg_base);
 eremap:
-	kfree(mx3fb);
 	dev_err(dev, "mx3fb: failed to register fb\n");
 	return ret;
 }
@@ -1561,7 +1560,6 @@ static int mx3fb_remove(struct platform_device *dev)
 	dmaengine_put();
=20
 	iounmap(mx3fb->reg_base);
-	kfree(mx3fb);
 	return 0;
 }
=20
--=20
1.7.9.5

