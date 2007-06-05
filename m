From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/5] [TRY 2] matroxfb: Color setting
	fixes
Date: Tue, 05 Jun 2007 19:16:22 +0800
Message-ID: <46654606.8020900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvXDU-0008Tw-DJ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:28:48 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvXDT-0005wq-Tc
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:28:48 -0700
Received: by py-out-1112.google.com with SMTP id u77so2968809pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 05 Jun 2007 04:28:46 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- the pseudo_palette is only 16 elements long.
- do not write to the pseudo_palette if regno (array index) is more than 15
- remove code that writes to the 17th entry of the pseudo_palette

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
Petr,

Here's another attempt. Let me know if I missed anything.

Tony
 drivers/video/matrox/matroxfb_accel.c |    9 ++-------
 drivers/video/matrox/matroxfb_base.c  |    4 ++++
 drivers/video/matrox/matroxfb_base.h  |    2 +-
 drivers/video/matrox/matroxfb_crtc2.c |    6 ------
 drivers/video/matrox/matroxfb_crtc2.h |    2 +-
 5 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/video/matrox/matroxfb_accel.c b/drivers/video/matrox/matroxfb_accel.c
index c57aaad..209fe69 100644
--- a/drivers/video/matrox/matroxfb_accel.c
+++ b/drivers/video/matrox/matroxfb_accel.c
@@ -145,13 +145,10 @@ void matrox_cfbX_init(WPMINFO2) {
 					ACCESS_FBINFO(fbops).fb_imageblit = matroxfb_imageblit;
 				}
 				break;
-		case 16:	if (ACCESS_FBINFO(fbcon).var.green.length == 5) {
+		case 16:	if (ACCESS_FBINFO(fbcon).var.green.length == 5)
 					maccess = 0xC0000001;
-					ACCESS_FBINFO(cmap[16]) = 0x7FFF7FFF;
-				} else {
+				else
 					maccess = 0x40000001;
-					ACCESS_FBINFO(cmap[16]) = 0xFFFFFFFF;
-				}
 				mopmode = M_OPMODE_16BPP;
 				if (accel) {
 					ACCESS_FBINFO(fbops).fb_copyarea = matroxfb_copyarea;
@@ -161,7 +158,6 @@ void matrox_cfbX_init(WPMINFO2) {
 				break;
 		case 24:	maccess = 0x00000003;
 				mopmode = M_OPMODE_24BPP;
-				ACCESS_FBINFO(cmap[16]) = 0xFFFFFFFF;
 				if (accel) {
 					ACCESS_FBINFO(fbops).fb_copyarea = matroxfb_copyarea;
 					ACCESS_FBINFO(fbops).fb_fillrect = matroxfb_fillrect;
@@ -170,7 +166,6 @@ void matrox_cfbX_init(WPMINFO2) {
 				break;
 		case 32:	maccess = 0x00000002;
 				mopmode = M_OPMODE_32BPP;
-				ACCESS_FBINFO(cmap[16]) = 0xFFFFFFFF;
 				if (accel) {
 					ACCESS_FBINFO(fbops).fb_copyarea = matroxfb_copyarea;
 					ACCESS_FBINFO(fbops).fb_fillrect = matroxfb_fillrect;
diff --git a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
index c8559a7..7ebb562 100644
--- a/drivers/video/matrox/matroxfb_base.c
+++ b/drivers/video/matrox/matroxfb_base.c
@@ -679,6 +679,8 @@ #endif
 		mga_outb(M_DAC_VAL, blue);
 		break;
 	case 16:
+		if (regno >= 16)
+			break;
 		{
 			u_int16_t col =
 				(red << ACCESS_FBINFO(fbcon).var.red.offset)     |
@@ -690,6 +692,8 @@ #endif
 		break;
 	case 24:
 	case 32:
+		if (regno >= 16)
+			break;
 		ACCESS_FBINFO(cmap[regno]) =
 			(red   << ACCESS_FBINFO(fbcon).var.red.offset)   |
 			(green << ACCESS_FBINFO(fbcon).var.green.offset) |
diff --git a/drivers/video/matrox/matroxfb_base.h b/drivers/video/matrox/matroxfb_base.h
index 9c25c2f..d59577c 100644
--- a/drivers/video/matrox/matroxfb_base.h
+++ b/drivers/video/matrox/matroxfb_base.h
@@ -518,7 +518,7 @@ #endif
 					dll:1;
 				      } memory;
 			      } values;
-	u_int32_t cmap[17];
+	u_int32_t cmap[16];
 };
 
 #define info2minfo(info) container_of(info, struct matrox_fb_info, fbcon)
diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
index 03ae55b..4b3344e 100644
--- a/drivers/video/matrox/matroxfb_crtc2.c
+++ b/drivers/video/matrox/matroxfb_crtc2.c
@@ -163,11 +163,6 @@ static void matroxfb_dh_disable(struct m
 	ACCESS_FBINFO(hw).crtc2.ctl = 0x00000004;
 }
 
-static void matroxfb_dh_cfbX_init(struct matroxfb_dh_fb_info* m2info) {
-	/* no acceleration for secondary head... */
-	m2info->cmap[16] = 0xFFFFFFFF;
-}
-
 static void matroxfb_dh_pan_var(struct matroxfb_dh_fb_info* m2info,
 		struct fb_var_screeninfo* var) {
 	unsigned int pos;
@@ -385,7 +380,6 @@ #define m2info (container_of(info, struc
 			}
 		}
 		up_read(&ACCESS_FBINFO(altout).lock);
-		matroxfb_dh_cfbX_init(m2info);
 	}
 	m2info->initialized = 1;
 	return 0;
diff --git a/drivers/video/matrox/matroxfb_crtc2.h b/drivers/video/matrox/matroxfb_crtc2.h
index 608e40b..24450df 100644
--- a/drivers/video/matrox/matroxfb_crtc2.h
+++ b/drivers/video/matrox/matroxfb_crtc2.h
@@ -30,7 +30,7 @@ struct matroxfb_dh_fb_info {
 
 	unsigned int		interlaced:1;
 
-	u_int32_t cmap[17];
+	u_int32_t cmap[16];
 };
 
 #endif /* __MATROXFB_CRTC2_H__ */


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
