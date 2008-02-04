From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH][drivers/video/imsttfb.c] add missing
	curly brackets
Date: Mon, 04 Feb 2008 20:41:09 +0100
Message-ID: <47A76A55.8010609@tiscali.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JM7Bt-0001VN-3m for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Feb 2008 11:41:17 -0800
Received: from smtp-out1.tiscali.nl ([195.241.79.176])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JM7Br-0002Ek-MJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 Feb 2008 11:41:17 -0800
Received: from [82.171.187.43] (helo=[192.168.1.2])
	by smtp-out1.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1JM7Bm-0001mA-Qe for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 04 Feb 2008 20:41:11 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

in #if 0 inactivated function msttfb_load_cursor_image() the call
eieio() occurs after rather than in the loop due to missing curly
brackets.

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 3ab91bf..04696f9 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1151,8 +1151,10 @@ imsttfb_load_cursor_image(struct imstt_par *par, int width, int height, __u8 fgc
 				par->cmap_regs[TVPCRDAT] = 0xff;		eieio();
 			}
 		par->cmap_regs[TVPCADRW] = 0x00;	eieio();
-		for (x = 0; x < 12; x++)
-			par->cmap_regs[TVPCDATA] = fgc;	eieio();
+		for (x = 0; x < 12; x++) {
+			par->cmap_regs[TVPCDATA] = fgc;
+			eieio();
+		}
 	}
 	return 1;
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
