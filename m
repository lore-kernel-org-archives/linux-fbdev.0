From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 05 Sep 2018 15:40:09 +0000
Subject: [PATCH] staging/fbtft: Update TODO and mailing lists
Message-Id: <20180905154009.20295-1-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Shuah Khan <shuahkhan@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>

Motivated by the ksummit-discuss discussion.

Cc: Shuah Khan <shuahkhan@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 MAINTAINERS                | 2 ++
 drivers/staging/fbtft/TODO | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 029baa270a11..3d50315dbe90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5624,6 +5624,8 @@ F:	lib/fault-inject.c
 
 FBTFT Framebuffer drivers
 M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+L:	dri-devel@lists.freedesktop.org
+L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fbtft/
 
diff --git a/drivers/staging/fbtft/TODO b/drivers/staging/fbtft/TODO
index 7e64c7e438f0..a9f4802bb6be 100644
--- a/drivers/staging/fbtft/TODO
+++ b/drivers/staging/fbtft/TODO
@@ -2,3 +2,7 @@
   GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
   lines from device tree, ACPI or board files, board files should
   use <linux/gpio/machine.h>
+
+* convert all these over to drm_simple_display_pipe and submit for inclusion
+  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any new
+  drivers anymore.
-- 
2.19.0.rc1
