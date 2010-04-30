From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 30 Apr 2010 21:39:48 +0000
Subject: [PATCH 2/3] viafb: Fix initialization error paths
Message-Id: <1272663589-4950-3-git-send-email-corbet@lwn.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272663589-4950-1-git-send-email-corbet@lwn.net>
In-Reply-To: <1272663589-4950-1-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Properly localize error cleanup, and make sure that the iomem regions are
unmapped if framebuffer initialization fails.

Reported-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/via-core.c |   36 +++++++++++++++++++++++++-----------
 1 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 58256d0..1c6835e 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -453,26 +453,40 @@ static int viafb_get_fb_size_from_pci(int chip_type)
  */
 static int __devinit via_pci_setup_mmio(struct viafb_dev *vdev)
 {
+	int ret;
 	/*
-	 * Hook up to the device registers.
+	 * Hook up to the device registers.  Note that we soldier
+	 * on if it fails; the framebuffer can operate (without
+	 * acceleration) without this region.
 	 */
 	vdev->engine_start =3D pci_resource_start(vdev->pdev, 1);
 	vdev->engine_len =3D pci_resource_len(vdev->pdev, 1);
-	/* If this fails, others will notice later */
 	vdev->engine_mmio =3D ioremap_nocache(vdev->engine_start,
 			vdev->engine_len);
-
+	if (vdev->engine_mmio =3D NULL)
+		dev_err(&vdev->pdev->dev,
+				"Unable to map engine MMIO; operation will be "
+				"slow and crippled.\n");
 	/*
-	 * Likewise with I/O memory.
+	 * Map in framebuffer memory.  For now, failure here is
+	 * fatal.  Unfortunately, in the absence of significant
+	 * vmalloc space, failure here is also entirely plausible.
+	 * Eventually we want to move away from mapping this
+	 * entire region.
 	 */
 	vdev->fbmem_start =3D pci_resource_start(vdev->pdev, 0);
-	vdev->fbmem_len =3D viafb_get_fb_size_from_pci(vdev->chip_type);
-	if (vdev->fbmem_len < 0)
-		return vdev->fbmem_len;
+	ret =3D vdev->fbmem_len =3D viafb_get_fb_size_from_pci(vdev->chip_type);
+	if (ret < 0)
+		goto out_unmap;
 	vdev->fbmem =3D ioremap_nocache(vdev->fbmem_start, vdev->fbmem_len);
-	if (vdev->fbmem =3D NULL)
-		return -ENOMEM;
+	if (vdev->fbmem =3D NULL) {
+		ret =3D -ENOMEM;
+		goto out_unmap;
+	}
 	return 0;
+out_unmap:
+	iounmap(vdev->engine_mmio);
+	return ret;
 }
=20
 static void __devexit via_pci_teardown_mmio(struct viafb_dev *vdev)
@@ -565,13 +579,13 @@ static int __devinit via_pci_probe(struct pci_dev *pd=
ev,
 	spin_lock_init(&global_dev.reg_lock);
 	ret =3D via_pci_setup_mmio(&global_dev);
 	if (ret)
-		goto out_teardown;
+		return ret;
 	/*
 	 * Set up the framebuffer device
 	 */
 	ret =3D via_fb_pci_probe(&global_dev);
 	if (ret)
-		return ret;
+		goto out_teardown;
 	/*
 	 * Create our subdevices.
 	 */
--=20
1.7.0.1

