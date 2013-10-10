From: Michal Simek <michal.simek@xilinx.com>
Date: Thu, 10 Oct 2013 06:30:22 +0000
Subject: [PATCH v3 3/3] video: xilinxfb: Simplify error path
Message-Id: <cd0b38241eccb712133c5a890a794508d78ae7e6.1381386616.git.michal.simek@xilinx.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_mimegpg-monstr-desktop-26992-1381386633-0001"
List-Id: <linux-fbdev.vger.kernel.org>
References: <631df9a44b366af4129d00f1d4e1d3baad7d4903.1381386616.git.michal.simek@xilinx.com>
In-Reply-To: <631df9a44b366af4129d00f1d4e1d3baad7d4903.1381386616.git.michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: joe@perches.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-26992-1381386633-0001

devm_iounmap is called automatically that's why remove it from the code
dev_set_drvdata(dev, NULL) is called by generic code
after device_release or on probe failure.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>
---
Changes in v3: None
Changes in v2:
- Rebased on git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next

 drivers/video/xilinxfb.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index c420328..9eedf96 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -260,10 +260,9 @@ static int xilinxfb_assign(struct platform_device *pdev,

 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		drvdata->regs = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(drvdata->regs)) {
-			rc = PTR_ERR(drvdata->regs);
-			goto err_region;
-		}
+		if (IS_ERR(drvdata->regs))
+			return PTR_ERR(drvdata->regs);
+
 		drvdata->regs_phys = res->start;
 	}

@@ -279,11 +278,7 @@ static int xilinxfb_assign(struct platform_device *pdev,

 	if (!drvdata->fb_virt) {
 		dev_err(dev, "Could not allocate frame buffer memory\n");
-		rc = -ENOMEM;
-		if (drvdata->flags & BUS_ACCESS_FLAG)
-			goto err_fbmem;
-		else
-			goto err_region;
+		return -ENOMEM;
 	}

 	/* Clear (turn to black) the framebuffer */
@@ -363,11 +358,6 @@ err_cmap:
 	/* Turn off the display */
 	xilinx_fb_out32(drvdata, REG_CTRL, 0);

-err_fbmem:
-	if (drvdata->flags & BUS_ACCESS_FLAG)
-		devm_iounmap(dev, drvdata->regs);
-
-err_region:
 	return rc;
 }

@@ -392,11 +382,9 @@ static int xilinxfb_release(struct device *dev)
 	/* Turn off the display */
 	xilinx_fb_out32(drvdata, REG_CTRL, 0);

-	/* Release the resources, as allocated based on interface */
-	if (drvdata->flags & BUS_ACCESS_FLAG)
-		devm_iounmap(dev, drvdata->regs);
 #ifdef CONFIG_PPC_DCR
-	else
+	/* Release the resources, as allocated based on interface */
+	if (!(drvdata->flags & BUS_ACCESS_FLAG))
 		dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
 #endif

--
1.8.2.3


--=_mimegpg-monstr-desktop-26992-1381386633-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlJWSYkACgkQykllyylKDCHAXACfTuNzVxr/hyrfw0RSy8gYwEJF
EeAAn14HxJ8e3arscsD492nqKJJYMXTb
=TJbP
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-26992-1381386633-0001--
