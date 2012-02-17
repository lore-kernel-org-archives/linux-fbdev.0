From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 17 Feb 2012 06:45:01 +0000
Subject: [patch] viafb: NULL dereference on allocation failure in query_edid()
Message-Id: <20120217064501.GD3666@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We should handle the allocation here, if only to keep the static
checkers happy.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/via/via_aux_edid.c b/drivers/video/via/via_aux_edid.c
index 03f7a41..754d450 100644
--- a/drivers/video/via/via_aux_edid.c
+++ b/drivers/video/via/via_aux_edid.c
@@ -36,10 +36,13 @@ static void query_edid(struct via_aux_drv *drv)
 	unsigned char edid[EDID_LENGTH];
 	bool valid = false;
 
-	if (spec)
+	if (spec) {
 		fb_destroy_modedb(spec->modedb);
-	else
+	} else {
 		spec = kmalloc(sizeof(*spec), GFP_KERNEL);
+		if (!spec)
+			return;
+	}
 
 	spec->version = spec->revision = 0;
 	if (via_aux_read(drv, 0x00, edid, EDID_LENGTH)) {
