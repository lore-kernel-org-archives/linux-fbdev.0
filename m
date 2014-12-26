From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 26 Dec 2014 17:26:57 +0000
Subject: [patch] fbdev: off by one test (harmless)
Message-Id: <20141226172657.GA14762@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

ARRAY_SIZE(cea_modes) is 64 so the "idx > 63" test earlier means this
test is really a no-op.  But it's still off by one and upsets the static
checkers so we may as well correct it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 5b0e313..3030269 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1061,7 +1061,7 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 		int idx = svd[i - specs->modedb_len - num];
 		if (!idx || idx > 63) {
 			pr_warning("Reserved SVD code %d\n", idx);
-		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
+		} else if (idx >= ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
 			pr_warning("Unimplemented SVD code %d\n", idx);
 		} else {
 			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));
