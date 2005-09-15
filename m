From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/3] savagefb: Fix load failure of the Twister chipset
Date: Thu, 15 Sep 2005 20:58:57 +0800
Message-ID: <43297011.7040700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFu67-0005h6-Gb
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Sep 2005 06:48:19 -0700
Received: from zproxy.gmail.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EFu63-00036T-TH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Sep 2005 06:48:19 -0700
Received: by zproxy.gmail.com with SMTP id v1so228865nzb
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Sep 2005 06:48:09 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- The Twister chipsets are actually prosavages.  Reclassify them as
  such and remove the S3_SAVAGE_TWISTER id.
- Fix i2c code if fb_firmware_edid() returns NULL

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 savagefb-i2c.c    |   11 +++++++----
 savagefb.h        |    4 ----
 savagefb_driver.c |   11 +++++------
 3 files changed, 12 insertions(+), 14 deletions(-)


diff --git a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
--- a/drivers/video/savage/savagefb-i2c.c
+++ b/drivers/video/savage/savagefb-i2c.c
@@ -274,10 +274,13 @@ int savagefb_probe_i2c_connector(struct 
 
 	if (!edid) {
 		/* try to get from firmware */
-		edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
-		if (edid)
-			memcpy(edid, fb_firmware_edid(info->device),
-			       EDID_LENGTH);
+		const u8 *e = fb_firmware_edid(info->device);
+
+		if (e) {
+			edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+			if (edid)
+				memcpy(edid, e, EDID_LENGTH);
+		}
 	}
 
 	if (out_edid)
diff --git a/drivers/video/savage/savagefb.h b/drivers/video/savage/savagefb.h
--- a/drivers/video/savage/savagefb.h
+++ b/drivers/video/savage/savagefb.h
@@ -60,8 +60,6 @@
 
 #define S3_SAVAGE_SERIES(chip)    ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE2000))
 
-#define S3_MOBILE_TWISTER_SERIES(chip) ((chip==S3_TWISTER) || (chip == S3_PROSAVAGEDDR))
-
 /* Chip tags.  These are used to group the adapters into
  * related families.
  */
@@ -74,8 +72,6 @@ typedef enum {
   S3_PROSAVAGE,
   S3_SUPERSAVAGE,
   S3_SAVAGE2000,
-  S3_PROSAVAGEDDR,
-  S3_TWISTER,
   S3_LAST
 } savage_chipset;
 
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1773,8 +1773,7 @@ static int __devinit savage_init_hw (str
 		}
 	}
 
-	if (S3_SAVAGE_MOBILE_SERIES(par->chip) ||
-	    (S3_MOBILE_TWISTER_SERIES(par->chip) && !par->crtonly))
+	if (S3_SAVAGE_MOBILE_SERIES(par->chip) && !par->crtonly)
 		par->display_type = DISP_LCD;
 	else if (dvi || (par->chip == S3_SAVAGE4 && par->dvi))
 		par->display_type = DISP_DFP;
@@ -1783,7 +1782,7 @@ static int __devinit savage_init_hw (str
 
 	/* Check LCD panel parrmation */
 
-	if (par->chip == S3_SAVAGE_MX) {
+	if (par->display_type == DISP_LCD) {
 		unsigned char cr6b = VGArCR( 0x6b );
 
 		int panelX = (VGArSEQ (0x61) +
@@ -1922,15 +1921,15 @@ static int __devinit savage_init_fb_info
 		snprintf (info->fix.id, 16, "ProSavageKM");
 		break;
 	case FB_ACCEL_S3TWISTER_P:
-		par->chip = S3_TWISTER;
+		par->chip = S3_PROSAVAGE;
 		snprintf (info->fix.id, 16, "TwisterP");
 		break;
 	case FB_ACCEL_S3TWISTER_K:
-		par->chip = S3_TWISTER;
+		par->chip = S3_PROSAVAGE;
 		snprintf (info->fix.id, 16, "TwisterK");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDR:
-		par->chip = S3_PROSAVAGEDDR;
+		par->chip = S3_PROSAVAGE;
 		snprintf (info->fix.id, 16, "ProSavageDDR");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDRK:



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
