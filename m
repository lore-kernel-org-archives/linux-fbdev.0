From: Peter Malone <peter.malone@gmail.com>
Date: Tue, 30 Jan 2018 20:30:42 +0000
Subject: [PATCH]        Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().
Message-Id: <20180130203042.4797-1-peter.malone@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Peter Malone <peter.malone@gmail.com>
---
 drivers/video/fbdev/sbuslib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index af6fc97f4ba4..a436d44f1b7f 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
-		int index, count, i;
+		unsigned int index, count, i;
 
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap = &info->cmap;
-		int index, count, i;
+		unsigned int index, count, i;
 		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||
-- 
2.14.3

