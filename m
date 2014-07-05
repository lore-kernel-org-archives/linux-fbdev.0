From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 05 Jul 2014 13:22:31 +0000
Subject: [PATCH] video: fbdev: omap: omapfb_main.c:  Cleaning up wrong type in format string
Message-Id: <1404566552-23096-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>

Wrong type in sscanf format string, requires 'int *' but the
argument type is 'unsigned int *'

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/omap/omapfb_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index d8d028d..7df0764 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1371,7 +1371,7 @@ static ssize_t omapfb_store_bklight_level(struct device *dev,
 	if (fbdev->panel->set_bklight_level) {
 		unsigned int level;
 
-		if (sscanf(buf, "%10d", &level) = 1) {
+		if (sscanf(buf, "%10u", &level) = 1) {
 			r = fbdev->panel->set_bklight_level(fbdev->panel,
 							    level);
 		} else
-- 
1.7.10.4

