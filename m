From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 14 Mar 2015 15:38:39 +0000
Subject: [PATCH] video: fbdev: sh_mobile_lcdcfb: Fix ROP3 sysfs attribute parsing
Message-Id: <1426347519-2541-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The ROP3 attribute is expressed as an integer in the 0-255 range. Remove
the wrong conversion to boolean when parsing it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index d3013cd9f976..23421ec1c4e4 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1461,7 +1461,7 @@ overlay_rop3_store(struct device *dev, struct device_attribute *attr,
 	unsigned int rop3;
 	char *endp;
 
-	rop3 = !!simple_strtoul(buf, &endp, 10);
+	rop3 = simple_strtoul(buf, &endp, 10);
 	if (isspace(*endp))
 		endp++;
 
-- 
Regards,

Laurent Pinchart

