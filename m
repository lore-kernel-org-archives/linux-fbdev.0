From: Shailendra Verma <shailendra.v@samung.com>
Date: Mon, 09 Nov 2015 08:16:48 +0000
Subject: [PATCH] video:fbdev:core:Allocate the memory for video mode after the validation of edid.
Message-Id: <1447056288-28543-1-git-send-email-shailendra.v@samung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1446205073-23830-1-git-send-email-shailendra.v@samung.com>
In-Reply-To: <1446205073-23830-1-git-send-email-shailendra.v@samung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, vidushi.koul@samsung.com, shailendra.v@samsung.com

From: Shailendra Verma <shailendra.v@samsung.com>

In this function "fb_create_modedb" the memory for video mode is getting
allocated before the edid validation.If the validation of edid fails
then we are freeing the allocated memory for the video mode and returning.
So moving the memory allocation part after the edid validation.There is no
need to allocate the memory before edid validation check and freeing if
validation gets failed.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/video/fbdev/core/fbmon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 47c3191..476a5fd 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -620,16 +620,16 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize,
 	int num = 0, i, first = 1;
 	int ver, rev;
 
-	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
-	if (mode = NULL)
-		return NULL;
-
 	if (edid = NULL || !edid_checksum(edid) ||
 	    !edid_check_header(edid)) {
-		kfree(mode);
 		return NULL;
 	}
 
+	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
+	if (mode = NULL)
+		return NULL;
+
+
 	ver = edid[EDID_STRUCT_VERSION];
 	rev = edid[EDID_STRUCT_REVISION];
 
-- 
1.9.1

