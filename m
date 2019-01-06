From: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Date: Sun, 06 Jan 2019 07:54:08 +0000
Subject: [PATCH] Fix stack memory disclosure
Message-Id: <20190106075408.58405-1-vlad@tsyrklevich.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Using [1] for static analysis I found that the OMAPFB_QUERY_PLANE,
OMAPFB_GET_COLOR_KEY, OMAPFB_GET_DISPLAY_INFO, and OMAPFB_GET_VRAM_INFO
cases could all leak uninitialized stack memory--either due to
uninitialized padding or 'reserved' fields.

Fix them by clearing the shared union used to store copied out data.

[1] https://github.com/vlad902/kernel-uninitialized-memory-checker

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Cc: security@kernel.org

---
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
index 53f93616c..8e23160ec 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -609,6 +609,8 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 	int r = 0;
 
+	memset(&p, 0, sizeof(p));
+
 	switch (cmd) {
 	case OMAPFB_SYNC_GFX:
 		DBG("ioctl SYNC_GFX\n");
-- 
2.17.0
