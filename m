From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 23/24] matroxfb: Color setting fixes
Date: Sat, 02 Jun 2007 18:15:29 +0800
Message-ID: <46614341.5040402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQlD-0000X0-9T for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:03 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQlC-0001yO-RD
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:03 -0700
Received: by py-out-1112.google.com with SMTP id u77so1509666pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:23:02 -0700 (PDT)
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

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/matrox/matroxfb_base.c  |    4 ++++
 drivers/video/matrox/matroxfb_base.h  |    2 +-
 drivers/video/matrox/matroxfb_crtc2.h |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

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
