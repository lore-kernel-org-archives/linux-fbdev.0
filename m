From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Oct 2010 15:24:25 +0000
Subject: [PATCH] fbdev: remove redundant operation
Message-Id: <Pine.LNX.4.64.1010191723170.17360@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Assignment of a function parameter has no effect on the caller.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/fbmon.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index a0b5a93..7a77170 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1344,7 +1344,6 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 }
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
-	specs = NULL;
 }
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
-- 
1.7.1

