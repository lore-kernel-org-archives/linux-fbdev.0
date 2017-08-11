From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 11 Aug 2017 14:22:51 +0000
Subject: [GIT PULL] fbdev fixes for v4.13-rc5
Message-Id: <2529421.QTQmKbkfoH@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170811142253epcas2p2ff89d81cc7d5f8bb534eb9f71bf4e2c9@epcas2p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev fixes for v4.13-rc5.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 16f73eb02d7e1765ccab3d2018e0bd98eb93d973:

  Linux 4.13-rc3 (2017-07-30 12:40:36 -0700)

are available in the git repository at:

  git://github.com/bzolnier/linux.git tags/fbdev-v4.13-rc5

for you to fetch changes up to dd0c41f8a7e0babdadc61d5201ac8505a79dec05:

  efifb: allow user to disable write combined mapping. (2017-07-31 18:45:41=
 +0200)

----------------------------------------------------------------
fbdev fixes for v4.13-rc5:

- allow user to disable write combined mapping in efifb driver (Dave Airlie)
- fix use after free bugs on driver removal in imxfb driver (Dan Carpenter)
- fix unused variable warning in omapfb driver (Arnd Bergmann)

----------------------------------------------------------------
Arnd Bergmann (1):
      fbdev: omapfb: remove unused variable

Dan Carpenter (1):
      video: fbdev: imxfb: use after free in imxfb_remove()

Dave Airlie (1):
      efifb: allow user to disable write combined mapping.

 Documentation/fb/efifb.txt                  |  6 ++++++
 drivers/video/fbdev/efifb.c                 |  8 +++++++-
 drivers/video/fbdev/imxfb.c                 | 10 +++-------
 drivers/video/fbdev/omap2/omapfb/dss/core.c |  1 -
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/fb/efifb.txt b/Documentation/fb/efifb.txt
index a59916c..1a85c1b 100644
--- a/Documentation/fb/efifb.txt
+++ b/Documentation/fb/efifb.txt
@@ -27,5 +27,11 @@ You have to add the following kernel parameters in your =
elilo.conf:
 	Macbook Pro 17", iMac 20" :
 		video=EFifb:i20
=20
+Accepted options:
+
+nowc	Don't map the framebuffer write combined. This can be used
+	to workaround side-effects and slowdowns on other CPU cores
+	when large amounts of console data are written.
+
 --
 Edgar Hucek <gimli@dark-green.com>
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ff01bed..1e784ad 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -17,6 +17,7 @@
 #include <asm/efi.h>
=20
 static bool request_mem_succeeded =3D false;
+static bool nowc =3D false;
=20
 static struct fb_var_screeninfo efifb_defined =3D {
 	.activate		=3D FB_ACTIVATE_NOW,
@@ -99,6 +100,8 @@ static int efifb_setup(char *options)
 				screen_info.lfb_height =3D simple_strtoul(this_opt+7, NULL, 0);
 			else if (!strncmp(this_opt, "width:", 6))
 				screen_info.lfb_width =3D simple_strtoul(this_opt+6, NULL, 0);
+			else if (!strcmp(this_opt, "nowc"))
+				nowc =3D true;
 		}
 	}
=20
@@ -255,7 +258,10 @@ static int efifb_probe(struct platform_device *dev)
 	info->apertures->ranges[0].base =3D efifb_fix.smem_start;
 	info->apertures->ranges[0].size =3D size_remap;
=20
-	info->screen_base =3D ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_len=
);
+	if (nowc)
+		info->screen_base =3D ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
+	else
+		info->screen_base =3D ioremap_wc(efifb_fix.smem_start, efifb_fix.smem_le=
n);
 	if (!info->screen_base) {
 		pr_err("efifb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			efifb_fix.smem_len, efifb_fix.smem_start);
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index c166e07..ba82f97 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1073,20 +1073,16 @@ static int imxfb_remove(struct platform_device *pde=
v)
 	imxfb_disable_controller(fbi);
=20
 	unregister_framebuffer(info);
-
+	fb_dealloc_cmap(&info->cmap);
 	pdata =3D dev_get_platdata(&pdev->dev);
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
-
-	fb_dealloc_cmap(&info->cmap);
-	kfree(info->pseudo_palette);
-	framebuffer_release(info);
-
 	dma_free_wc(&pdev->dev, fbi->map_size, info->screen_base,
 		    fbi->map_dma);
-
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
+	kfree(info->pseudo_palette);
+	framebuffer_release(info);
=20
 	return 0;
 }
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fb=
dev/omap2/omapfb/dss/core.c
index eecf695..09e5bb0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -193,7 +193,6 @@ static int omap_dss_pm_notif(struct notifier_block *b, =
unsigned long v, void *d)
=20
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata =3D pdev->dev.platform_data;
 	int r;
=20
 	core.pdev =3D pdev;

