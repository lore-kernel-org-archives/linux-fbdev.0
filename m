From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 03/24] cyblafb: Fix pseudo_palette array
	overrun in setcolreg
Date: Sat, 02 Jun 2007 17:56:58 +0800
Message-ID: <46613EEA.2030504@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQiE-00009O-2R for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:19:58 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQiD-00011W-Ol
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:19:58 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:19:57 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Knut Petersen <Knut_Petersen@t-online.de>

The pseudo_palette has only 16 elements. Do not write if regno (the array
index) is more than 15.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/cyblafb.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
index 94a66c2..e23324d 100644
--- a/drivers/video/cyblafb.c
+++ b/drivers/video/cyblafb.c
@@ -1068,15 +1068,18 @@ static int cyblafb_setcolreg(unsigned re
 		out8(0x3C9, green >> 10);
 		out8(0x3C9, blue >> 10);
 
-	} else if (bpp == 16)	// RGB 565
-		((u32 *) info->pseudo_palette)[regno] =
-		    (red & 0xF800) |
-		    ((green & 0xFC00) >> 5) | ((blue & 0xF800) >> 11);
-	else if (bpp == 32)	// ARGB 8888
-		((u32 *) info->pseudo_palette)[regno] =
-		    ((transp & 0xFF00) << 16) |
-		    ((red & 0xFF00) << 8) |
-		    ((green & 0xFF00)) | ((blue & 0xFF00) >> 8);
+	} else if (regno < 16) {
+		if (bpp == 16)	// RGB 565
+			((u32 *) info->pseudo_palette)[regno] =
+				(red & 0xF800) |
+				((green & 0xFC00) >> 5) |
+				((blue & 0xF800) >> 11);
+		else if (bpp == 32)	// ARGB 8888
+			((u32 *) info->pseudo_palette)[regno] =
+				((transp & 0xFF00) << 16) |
+				((red & 0xFF00) << 8) |
+				((green & 0xFF00)) | ((blue & 0xFF00) >> 8);
+	}
 
 	return 0;
 }




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
