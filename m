From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Sun, 17 May 2020 22:05:23 +0000
Subject: [PATCH v2 1/2] fbdev: annotate rivafb/nvidiafb as obsolete
Message-Id: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, emil.l.velikov@gmail.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Drivers have not seen any love for years.

Be that fixes or improvements, or cosmetics like introducing symbolic
names, style and code-flow polish.

Seemingly the maintainer has also disappeared years ago :-\

Considering nouveau supports all that hardware (modulo nv03) just mark
these as obsolete/broken, referring to nouveau in the help text.

v2 (Bartlomiej):
 - split config changes into separate patch
 - spell out nouveau DRM driver
 - don't use BROKEN
 - add runtime warning

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> (v1)
---
 MAINTAINERS                         | 3 +--
 drivers/video/fbdev/Kconfig         | 4 ++++
 drivers/video/fbdev/nvidia/nvidia.c | 3 +++
 drivers/video/fbdev/riva/fbdev.c    | 3 +++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 938316092634..c9498dd15e4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12055,9 +12055,8 @@ F:	include/linux/nubus.h
 F:	include/uapi/linux/nubus.h
 
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
-M:	Antonino Daplas <adaplas@gmail.com>
 L:	linux-fbdev@vger.kernel.org
-S:	Maintained
+S:	Obsolete
 F:	drivers/video/fbdev/nvidia/
 F:	drivers/video/fbdev/riva/
 
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index fa88e8b9a83d..ccddd06ab430 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -881,6 +881,8 @@ config FB_NVIDIA
 	select BITREVERSE
 	select VGASTATE
 	help
+	  Obsolete, use the nouveau DRM driver instead.
+
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
 	  the rivafb.
@@ -928,6 +930,8 @@ config FB_RIVA
 	select BITREVERSE
 	select VGASTATE
 	help
+	  Obsolete, use the nouveau DRM driver instead.
+
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
 	  Say Y if you have such a graphics board.
diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index c24de9107958..a958612ef75b 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1512,6 +1512,9 @@ static struct pci_driver nvidiafb_driver = {
 
 static int nvidiafb_init(void)
 {
+	pr_warn("Legacy nvidiafb framebuffer driver will be removed in 2022\n"
+		"Please switch to nouveau DRM driver\n");
+
 #ifndef MODULE
 	char *option = NULL;
 
diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 764ec3285e62..c2788e22f5c1 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -2160,6 +2160,9 @@ static struct pci_driver rivafb_driver = {
 
 static int rivafb_init(void)
 {
+	pr_warn("Legacy rivafb framebuffer driver will be removed in 2022\n"
+		"Please switch to nouveau DRM driver\n");
+
 #ifndef MODULE
 	char *option = NULL;
 
-- 
2.25.1
