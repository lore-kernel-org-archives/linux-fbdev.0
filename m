From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Wed, 18 Feb 2015 08:33:33 +0000
Subject: [PATCH 2/3] Static should not be initialize so removing static initialization from efifb.c
Message-Id: <20150218083330.GC9820@linuxteamdev.amer.dell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pjones@redhat.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

This patch depend on my earlier patch.

Static should not be initialize so removing initialization.
Signed-off-by: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
---
 drivers/video/fbdev/efifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index facfbb3..cc1a156 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -17,7 +17,7 @@
 #include <video/vga.h>
 #include <asm/sysfb.h>

-static bool request_mem_succeeded = false;
+static bool request_mem_succeeded;

 static struct fb_var_screeninfo efifb_defined = {
        .activate               = FB_ACTIVATE_NOW,
--
1.9.3

