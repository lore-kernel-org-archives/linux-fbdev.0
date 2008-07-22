From: roel kluin <roel.kluin@gmail.com>
Subject: [PATCH 6/9] radeon: test below 0 on unsigned v.[xy]offset
Date: Mon, 21 Jul 2008 20:29:31 -0400
Message-ID: <488529EB.9090501@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756805AbYGVAar@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

v.[xy]offset is unsigned so the test doesn't work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 400e926..586d04e 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -819,11 +819,6 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
 	if (v.xres_virtual < v.xres)
 		v.xres = v.xres_virtual;
 
-	if (v.xoffset < 0)
-                v.xoffset = 0;
-        if (v.yoffset < 0)
-                v.yoffset = 0;
-         
         if (v.xoffset > v.xres_virtual - v.xres)
                 v.xoffset = v.xres_virtual - v.xres - 1;
                         
