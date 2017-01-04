From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 04 Jan 2017 12:42:38 +0000
Subject: [GIT PULL] fbdev fixes for v4.10-rc2
Message-Id: <6009223.Ou6P7G7uWh@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170104124240epcas5p4e9c51bb5dc001506a5b7923dc1ef7623@epcas5p4.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev fixes for v4.10-rc2.  They bring fbdev subsystem
back into Maintained mode (with me as Maintainer) and add missing
devm_ioremap() error checking to cobalt_lcdfb driver.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://github.com/bzolnier/linux.git tags/fbdev-v4.10-rc2

for you to fetch changes up to 4dcd19bfabaee8f9f4bcf203afba09b98ccbaf76:

  video: fbdev: cobalt_lcdfb: Handle return NULL error from devm_ioremap (2017-01-04 12:58:45 +0100)

----------------------------------------------------------------
fbdev fixes for v4.10-rc2:

- bring fbdev subsystem back into Maintained mode
- add missing devm_ioremap() error checking to cobalt_lcdfb driver

----------------------------------------------------------------
Arvind Yadav (1):
      video: fbdev: cobalt_lcdfb: Handle return NULL error from devm_ioremap

Bartlomiej Zolnierkiewicz (1):
      MAINTAINERS: add myself as maintainer of fbdev

 MAINTAINERS                        | 4 +++-
 drivers/video/fbdev/cobalt_lcdfb.c | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9..2775b14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5080,9 +5080,11 @@ F:	drivers/net/wan/dlci.c
 F:	drivers/net/wan/sdla.c
 
 FRAMEBUFFER LAYER
+M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-fbdev@vger.kernel.org
+T:	git git://github.com/bzolnier/linux.git
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
-S:	Orphan
+S:	Maintained
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/video/
diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 2d3b691..038ac69 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -308,6 +308,11 @@ static int cobalt_lcdfb_probe(struct platform_device *dev)
 	info->screen_size = resource_size(res);
 	info->screen_base = devm_ioremap(&dev->dev, res->start,
 					 info->screen_size);
+	if (!info->screen_base) {
+		framebuffer_release(info);
+		return -ENOMEM;
+	}
+
 	info->fbops = &cobalt_lcd_fbops;
 	info->fix = cobalt_lcdfb_fix;
 	info->fix.smem_start = res->start;

