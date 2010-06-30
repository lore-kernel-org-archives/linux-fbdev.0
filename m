From: Afzal Mohammed <lazfamam@gmail.com>
Date: Wed, 30 Jun 2010 14:27:27 +0000
Subject: [PATCH] OMAP:DSS2:OMAPFB: Fix probe error path
Message-Id: <1277907327-3443-1-git-send-email-lazfamam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@nokia.com
Cc: ville.syrjala@nokia.com, tj@kernel.org, lazfamam@gmail.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

If enabling fb0 fails in omapfb_create_framebuffers(), remove
sysfs file before returning to probe. This is required to complete
the cleanup in the above mentioned error case.

Signed-off-by: Afzal Mohammed <lazfamam@gmail.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 4b4506d..2319b81 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1945,6 +1945,7 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 			r = omapfb_overlay_enable(ovl, 1);
 
 			if (r) {
+				omapfb_remove_sysfs(fbdev);
 				dev_err(fbdev->dev,
 						"failed to enable overlay\n");
 				return r;
-- 
1.7.0.4

