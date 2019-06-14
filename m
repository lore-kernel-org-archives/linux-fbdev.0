From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 14 Jun 2019 10:43:56 +0000
Subject: [PATCH] video: fbdev: pvr2fb: fix build warning when compiling as module
Message-Id: <2376f0a7-2511-b52d-c0d1-9162382f8693@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614104355eucas1p236ecb70b6d48f37508f3837cee49b19f@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Add missing #ifndef MODULE around pvr2_get_param_val().

Fixes: 0f5a5712ad1e ("video: fbdev: pvr2fb: add COMPILE_TEST support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/pvr2fb.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/video/fbdev/pvr2fb.c
=================================--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -722,6 +722,7 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
+#ifndef MODULE
 static int pvr2_get_param_val(const struct pvr2_params *p, const char *s,
 			      int size)
 {
@@ -733,6 +734,7 @@ static int pvr2_get_param_val(const stru
 	}
 	return -1;
 }
+#endif
 
 static char *pvr2_get_param_name(const struct pvr2_params *p, int val,
 			  int size)
