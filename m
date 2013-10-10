From: Michal Simek <michal.simek@xilinx.com>
Date: Thu, 10 Oct 2013 06:30:20 +0000
Subject: [PATCH v3 1/3] video: xilinxfb: Use standard variable name convention
Message-Id: <631df9a44b366af4129d00f1d4e1d3baad7d4903.1381386616.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-26965-1381386623-0001"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Cc: joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-26965-1381386623-0001

s/op/pdev/ in xilinxfb_of_probe().
No functional chagnes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v3: None
Changes in v2: None

 drivers/video/xilinxfb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 0e1dd33..d12345f 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -411,7 +411,7 @@ static int xilinxfb_release(struct device *dev)
  * OF bus binding
  */

-static int xilinxfb_of_probe(struct platform_device *op)
+static int xilinxfb_of_probe(struct platform_device *pdev)
 {
 	const u32 *prop;
 	u32 tft_access = 0;
@@ -425,7 +425,7 @@ static int xilinxfb_of_probe(struct platform_device *op)
 	/* Allocate the driver data region */
 	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata) {
-		dev_err(&op->dev, "Couldn't allocate device private record\n");
+		dev_err(&pdev->dev, "Couldn't allocate device private record\n");
 		return -ENOMEM;
 	}

@@ -433,7 +433,7 @@ static int xilinxfb_of_probe(struct platform_device *op)
 	 * To check whether the core is connected directly to DCR or BUS
 	 * interface and initialize the tft_access accordingly.
 	 */
-	of_property_read_u32(op->dev.of_node, "xlnx,dcr-splb-slave-if",
+	of_property_read_u32(pdev->dev.of_node, "xlnx,dcr-splb-slave-if",
 			     &tft_access);

 	/*
@@ -457,29 +457,29 @@ static int xilinxfb_of_probe(struct platform_device *op)
 	}
 #endif

-	prop = of_get_property(op->dev.of_node, "phys-size", &size);
+	prop = of_get_property(pdev->dev.of_node, "phys-size", &size);
 	if ((prop) && (size >= sizeof(u32)*2)) {
 		pdata.screen_width_mm = prop[0];
 		pdata.screen_height_mm = prop[1];
 	}

-	prop = of_get_property(op->dev.of_node, "resolution", &size);
+	prop = of_get_property(pdev->dev.of_node, "resolution", &size);
 	if ((prop) && (size >= sizeof(u32)*2)) {
 		pdata.xres = prop[0];
 		pdata.yres = prop[1];
 	}

-	prop = of_get_property(op->dev.of_node, "virtual-resolution", &size);
+	prop = of_get_property(pdev->dev.of_node, "virtual-resolution", &size);
 	if ((prop) && (size >= sizeof(u32)*2)) {
 		pdata.xvirt = prop[0];
 		pdata.yvirt = prop[1];
 	}

-	if (of_find_property(op->dev.of_node, "rotate-display", NULL))
+	if (of_find_property(pdev->dev.of_node, "rotate-display", NULL))
 		pdata.rotate_screen = 1;

-	dev_set_drvdata(&op->dev, drvdata);
-	return xilinxfb_assign(op, drvdata, &pdata);
+	dev_set_drvdata(&pdev->dev, drvdata);
+	return xilinxfb_assign(pdev, drvdata, &pdata);
 }

 static int xilinxfb_of_remove(struct platform_device *op)
--
1.8.2.3


--=_mimegpg-monstr-desktop-26965-1381386623-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlJWSX8ACgkQykllyylKDCGAQACeP+F2rvGoLlm79dZn4RNTDImB
acYAn3DmSN5PDZaTivlAZQ6rMuwOj1yr
=p0Ab
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-26965-1381386623-0001--
