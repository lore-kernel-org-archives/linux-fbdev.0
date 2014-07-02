From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Wed, 02 Jul 2014 21:44:53 +0000
Subject: [PATCH] video: fbdev: core: fbmon.c:  Fix for possible null pointer dereference
Message-Id: <1404337493-6416-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, David Ung <davidu@nvidia.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fix a possible null pointer dereference, there is otherwise a risk of a possible null pointer dereference

This was found using a static code analysis program called cppcheck

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/video/fbdev/core/fbmon.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 5b0e313..9ec81ee 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -608,6 +608,11 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
 	int num = 0, i, first = 1;
 	int ver, rev;
 
+	if (edid = NULL || !edid_checksum(edid) ||
+		!edid_check_header(edid)) {
+		return NULL;
+	}
+
 	ver = edid[EDID_STRUCT_VERSION];
 	rev = edid[EDID_STRUCT_REVISION];
 
@@ -615,12 +620,6 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
 	if (mode = NULL)
 		return NULL;
 
-	if (edid = NULL || !edid_checksum(edid) ||
-	    !edid_check_header(edid)) {
-		kfree(mode);
-		return NULL;
-	}
-
 	*dbsize = 0;
 
 	DPRINTK("   Detailed Timings\n");
-- 
1.7.10.4

