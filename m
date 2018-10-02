From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 02 Oct 2018 10:18:11 +0000
Subject: [GIT PULL] fbdev fixes for v4.19-rc7
Message-Id: <20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816~Zw089uDZp3206032060eucas1p2t@eucas1p2.samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181002101812eucas1p28c4a9b388a99a32b9a292fb0cdcce816@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Hi Greg,

Please pull fbdev fixes for v4.19-rc7 (please see the signed tag
description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.19-rc7

for you to fetch changes up to 7c968791f7753bf0e52a21729498509ea3dd751b:

  video/fbdev/stifb: Fix spelling mistake in fall-through annotation (2018-09-26 18:50:54 +0200)

----------------------------------------------------------------
fbdev fixes for v4.19-rc7:

- fix OMAPFB_MEMORY_READ ioctl to not leak kernel memory in omapfb driver
  (Tomi Valkeinen)

- add missing prepare/unprepare clock operations in pxa168fb driver
  (Lubomir Rintel)

- add nobgrt option in efifb driver to disable ACPI BGRT logo restore
  (Hans de Goede)

- fix spelling mistake in fall-through annotation in stifb driver
  (Gustavo A. R. Silva)

- fix URL for uvesafb repository in the documentation (Adam Jackson)

----------------------------------------------------------------
Adam Jackson (1):
      uvesafb: Fix URLs in the documentation

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v4.19-rc5' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next

Gustavo A. R. Silva (1):
      video/fbdev/stifb: Fix spelling mistake in fall-through annotation

Hans de Goede (1):
      efifb: BGRT: Add nobgrt option

Lubomir Rintel (1):
      pxa168fb: prepare the clock

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

 Documentation/fb/uvesafb.txt                    | 5 +++--
 MAINTAINERS                                     | 2 +-
 drivers/video/fbdev/efifb.c                     | 6 ++++++
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 5 ++++-
 drivers/video/fbdev/pxa168fb.c                  | 6 +++---
 drivers/video/fbdev/stifb.c                     | 2 +-
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/fb/uvesafb.txt b/Documentation/fb/uvesafb.txt
index f6362d8..aa92419 100644
--- a/Documentation/fb/uvesafb.txt
+++ b/Documentation/fb/uvesafb.txt
@@ -15,7 +15,8 @@ than x86.  Check the v86d documentation for a list of currently supported
 arches.
 
 v86d source code can be downloaded from the following website:
-  http://dev.gentoo.org/~spock/projects/uvesafb
+
+  https://github.com/mjanusz/v86d
 
 Please refer to the v86d documentation for detailed configuration and
 installation instructions.
@@ -177,7 +178,7 @@ from the Video BIOS if you set pixclock to 0 in fb_var_screeninfo.
 
 --
  Michal Januszewski <spock@gentoo.org>
- Last updated: 2009-03-30
+ Last updated: 2017-10-10
 
  Documentation of the uvesafb options is loosely based on vesafb.txt.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 02a3961..97e565f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15389,7 +15389,7 @@ S:	Maintained
 UVESAFB DRIVER
 M:	Michal Januszewski <spock@gentoo.org>
 L:	linux-fbdev@vger.kernel.org
-W:	http://dev.gentoo.org/~spock/projects/uvesafb/
+W:	https://github.com/mjanusz/v86d
 S:	Maintained
 F:	Documentation/fb/uvesafb.txt
 F:	drivers/video/fbdev/uvesafb.*
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 3946649..ba906876 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -42,6 +42,7 @@ struct bmp_dib_header {
 	u32 colors_important;
 } __packed;
 
+static bool use_bgrt = true;
 static bool request_mem_succeeded = false;
 static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
 
@@ -160,6 +161,9 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 	void *bgrt_image = NULL;
 	u8 *dst = info->screen_base;
 
+	if (!use_bgrt)
+		return;
+
 	if (!bgrt_tab.image_address) {
 		pr_info("efifb: No BGRT, not showing boot graphics\n");
 		return;
@@ -290,6 +294,8 @@ static int efifb_setup(char *options)
 				screen_info.lfb_width = simple_strtoul(this_opt+6, NULL, 0);
 			else if (!strcmp(this_opt, "nowc"))
 				mem_flags &= ~EFI_MEMORY_WC;
+			else if (!strcmp(this_opt, "nobgrt"))
+				use_bgrt = false;
 		}
 	}
 
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
index ef69273..a3edb20 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -496,6 +496,9 @@ static int omapfb_memory_read(struct fb_info *fbi,
 	if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
 		return -EFAULT;
 
+	if (mr->w > 4096 || mr->h > 4096)
+		return -EINVAL;
+
 	if (mr->w * mr->h * 3 > mr->buffer_size)
 		return -EINVAL;
 
@@ -509,7 +512,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
 			mr->x, mr->y, mr->w, mr->h);
 
 	if (r > 0) {
-		if (copy_to_user(mr->buffer, buf, mr->buffer_size))
+		if (copy_to_user(mr->buffer, buf, r))
 			r = -EFAULT;
 	}
 
diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index def3a50..d059d04 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -712,7 +712,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * enable controller clock
 	 */
-	clk_enable(fbi->clk);
+	clk_prepare_enable(fbi->clk);
 
 	pxa168fb_set_par(info);
 
@@ -767,7 +767,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 failed_free_cmap:
 	fb_dealloc_cmap(&info->cmap);
 failed_free_clk:
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 failed_free_fbmem:
 	dma_free_coherent(fbi->dev, info->fix.smem_len,
 			info->screen_base, fbi->fb_start_dma);
@@ -807,7 +807,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
 	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
 		    info->screen_base, info->fix.smem_start);
 
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 
 	framebuffer_release(info);
 
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 045e8af..9e88e3f 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1157,7 +1157,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 			dev_name);
 		   goto out_err0;
 		}
-		/* fall though */
+		/* fall through */
 	case S9000_ID_ARTIST:
 	case S9000_ID_HCRX:
 	case S9000_ID_TIMBER:
