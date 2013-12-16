From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 16 Dec 2013 09:49:23 +0000
Subject: [patch v2] tgafb: potential NULL dereference in init
Message-Id: <20131216094922.GE13831@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Static checkers complain that there are paths where "tga_type_name" can
be NULL.  I've re-arranged the code slightly so that's impossible.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v1: had introduced a "dereferencing uninitialized variable" bug.  Thanks
to Geert Uytterhoeven for catching that.

diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index f28674fea909..afd8887fd656 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -1496,10 +1496,9 @@ tgafb_init_fix(struct fb_info *info)
 		if (tga_bus_tc)
 			tga_type_name = "Digital ZLX-E3";
 		break;
-	default:
-		tga_type_name = "Unknown";
-		break;
 	}
+	if (!tga_type_name)
+		tga_type_name = "Unknown";
 
 	strlcpy(info->fix.id, tga_type_name, sizeof(info->fix.id));
 
