From: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Date: Thu, 26 Feb 2015 10:45:40 +0000
Subject: [PATCH 2/3] Static should not be initialize so removing static initilization from efifb.c
Message-Id: <20150226104537.GB20577@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150218083330.GC9820@linuxteamdev.amer.dell.com>
In-Reply-To: <20150218083330.GC9820@linuxteamdev.amer.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

 Static variables should not be initialized. So removing initialization of
static variable.

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

