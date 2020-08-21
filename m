From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 21 Aug 2020 10:49:10 +0000
Subject: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y && PPC_PMAC=n
Message-Id: <20200821104910.3363818-1-mpe@ellerman.id.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <ba50c26a-d69b-d88d-b34d-3194971b1018@samsung.com>
In-Reply-To: <ba50c26a-d69b-d88d-b34d-3194971b1018@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linuxppc-dev@ozlabs.org
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, sam@ravnborg.org

The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:

  linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
  linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
    276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
        |  ^~~~~~~~~~~~~~~~~~~~

Fix it by including btext.h whenever CONFIG_BOOTX_TEXT is enabled.

Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/video/fbdev/controlfb.c | 2 ++
 1 file changed, 2 insertions(+)

Does anyone mind if I apply this via the powerpc tree for v5.9?

It would be nice to get the build clean.

cheers

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 9c4f1be856ec..547abeb39f87 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -49,6 +49,8 @@
 #include <linux/cuda.h>
 #ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
+#endif
+#ifdef CONFIG_BOOTX_TEXT
 #include <asm/btext.h>
 #endif
 
-- 
2.25.1
