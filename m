From: George Kennedy <george.kennedy@oracle.com>
Date: Tue, 07 Jul 2020 19:26:03 +0000
Subject: [PATCH 1/1] fbmem: add margin check to fb_check_caps()
Message-Id: <1594149963-13801-1-git-send-email-george.kennedy@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
or yres setting in struct fb_var_screeninfo will result in a
KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
the margins are being cleared. The margins are cleared in
chunks and if the xres setting or yres setting is a value of
zero upto the chunk size, the failure will occur.

Add a margin check to validate xres and yres settings.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com
---
 drivers/video/fbdev/core/fbmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 30e73ec..cd50302 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1007,6 +1007,10 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 		return 0;
 	}
 
+	/* bitfill_aligned() assumes that it's at least 8x8 */
+	if (var->xres < 8 || var->yres < 8)
+		return -EINVAL;
+
 	ret = info->fbops->fb_check_var(var, info);
 
 	if (ret)
-- 
1.8.3.1
