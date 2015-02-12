From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 12 Feb 2015 15:59:36 +0000
Subject: [PATCH] video: fbdev: fix possible null dereference
Message-Id: <1423756056-15108-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

we were dereferencing edid first and the NULL check was after
accessing that. now we are using edid only if we know that
it is not NULL.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/core/fbmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 9533859..868facd 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -624,9 +624,6 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize,
 	int num = 0, i, first = 1;
 	int ver, rev;
 
-	ver = edid[EDID_STRUCT_VERSION];
-	rev = edid[EDID_STRUCT_REVISION];
-
 	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
 	if (mode = NULL)
 		return NULL;
@@ -637,6 +634,9 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize,
 		return NULL;
 	}
 
+	ver = edid[EDID_STRUCT_VERSION];
+	rev = edid[EDID_STRUCT_REVISION];
+
 	*dbsize = 0;
 
 	DPRINTK("   Detailed Timings\n");
-- 
1.8.1.2

