From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 26 Aug 2013 14:56:10 +0000
Subject: [patch] tgafb: potential NULL dereference in init
Message-Id: <20130826145610.GA12428@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Static checkers complain that there are paths where "tga_type_name" can
be NULL.  I've re-arranged the code slightly so that's impossible.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index c9c8e5a..2dcaf2e 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -1475,7 +1475,7 @@ tgafb_init_fix(struct fb_info *info)
 	int tga_bus_pci = TGA_BUS_PCI(par->dev);
 	int tga_bus_tc = TGA_BUS_TC(par->dev);
 	u8 tga_type = par->tga_type;
-	const char *tga_type_name = NULL;
+	const char *tga_type_name;
 
 	switch (tga_type) {
 	case TGA_TYPE_8PLANE:
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
 
