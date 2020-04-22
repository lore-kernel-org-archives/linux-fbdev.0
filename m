From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 22 Apr 2020 07:18:45 +0000
Subject: [PATCH] video: uvesafb: use true,false for bool variables
Message-Id: <20200422071845.403-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spock@gentoo.org, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

Fix the following coccicheck warning:

drivers/video/fbdev/uvesafb.c:48:12-17: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1827:3-13: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1829:3-13: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1835:3-9: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1837:3-9: WARNING: Assignment of 0/1 to
bool variable
drivers/video/fbdev/uvesafb.c:1839:3-8: WARNING: Assignment of 0/1 to
bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/uvesafb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 1b385cf76110..bee29aadc646 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -45,7 +45,7 @@ static const struct fb_fix_screeninfo uvesafb_fix = {
 };
 
 static int mtrr		= 3;	/* enable mtrr by default */
-static bool blank	= 1;	/* enable blanking by default */
+static bool blank	= true;	/* enable blanking by default */
 static int ypan		= 1;	/* 0: scroll, 1: ypan, 2: ywrap */
 static bool pmi_setpal	= true; /* use PMI for palette changes */
 static bool nocrtc;		/* ignore CRTC settings */
@@ -1824,19 +1824,19 @@ static int uvesafb_setup(char *options)
 		else if (!strcmp(this_opt, "ywrap"))
 			ypan = 2;
 		else if (!strcmp(this_opt, "vgapal"))
-			pmi_setpal = 0;
+			pmi_setpal = false;
 		else if (!strcmp(this_opt, "pmipal"))
-			pmi_setpal = 1;
+			pmi_setpal = true;
 		else if (!strncmp(this_opt, "mtrr:", 5))
 			mtrr = simple_strtoul(this_opt+5, NULL, 0);
 		else if (!strcmp(this_opt, "nomtrr"))
 			mtrr = 0;
 		else if (!strcmp(this_opt, "nocrtc"))
-			nocrtc = 1;
+			nocrtc = true;
 		else if (!strcmp(this_opt, "noedid"))
-			noedid = 1;
+			noedid = true;
 		else if (!strcmp(this_opt, "noblank"))
-			blank = 0;
+			blank = true;
 		else if (!strncmp(this_opt, "vtotal:", 7))
 			vram_total = simple_strtoul(this_opt + 7, NULL, 0);
 		else if (!strncmp(this_opt, "vremap:", 7))
-- 
2.21.1
