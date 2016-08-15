From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Mon, 15 Aug 2016 10:10:30 +0000
Subject: [RESEND PATCH 1/3] fbdev: vfb: add description to module parameters
Message-Id: <1471255832-44793-2-git-send-email-vladimir.murzin@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add description to "videomemorysize" and "vfb_enable" module parameters to
make them a bit friendly to the end user.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/video/fbdev/vfb.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index b9c2f81..e9ecae2 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -35,6 +35,7 @@
 static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
 module_param(videomemorysize, ulong, 0);
+MODULE_PARM_DESC(videomemorysize, "RAM available to frame buffer (in bytes)");
 
 /**********************************************************************
  *
@@ -119,6 +120,7 @@ static struct fb_fix_screeninfo vfb_fix = {
 
 static bool vfb_enable __initdata = 0;	/* disabled by default */
 module_param(vfb_enable, bool, 0);
+MODULE_PARM_DESC(vfb_enable, "Enable Virtual FB driver");
 
 static int vfb_check_var(struct fb_var_screeninfo *var,
 			 struct fb_info *info);
-- 
1.7.9.5

