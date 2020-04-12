From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 12 Apr 2020 20:21:43 +0000
Subject: [PATCH] video: vt8500lcdfb: fix fallthrough warning
Message-Id: <20200412202143.GA26948@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Alexey Charkov <alchark@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Fix following warning:
vt8500lcdfb.c: In function 'vt8500lcd_blank':
vt8500lcdfb.c:229:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
      if (info->fix.visual = FB_VISUAL_PSEUDOCOLOR ||
         ^
vt8500lcdfb.c:233:2: note: here
     case FB_BLANK_UNBLANK:
     ^~~~

Adding a simple "fallthrough;" fixed the warning.
The fix was build tested.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: e41f1a989408 ("fbdev: Implement simple blanking in pseudocolor modes for vt8500lcdfb")
Cc: Alexey Charkov <alchark@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: <stable@vger.kernel.org> # v2.6.38+
---
 drivers/video/fbdev/vt8500lcdfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index f744479dc7df..c61476247ba8 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -230,6 +230,7 @@ static int vt8500lcd_blank(int blank, struct fb_info *info)
 		    info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR)
 			for (i = 0; i < 256; i++)
 				vt8500lcd_setcolreg(i, 0, 0, 0, 0, info);
+		fallthrough;
 	case FB_BLANK_UNBLANK:
 		if (info->fix.visual = FB_VISUAL_PSEUDOCOLOR ||
 		    info->fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR)
-- 
2.20.1
