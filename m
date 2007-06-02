From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 17/24] tridentfb: Fix pseudo_palette
	array overrun in setcolreg
Date: Sat, 02 Jun 2007 18:10:26 +0800
Message-ID: <46614212.8020906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQyQ-0001uD-6n for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:36:42 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQjF-00011W-Ea
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:21:01 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:21:01 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jani Monoses <jani@iv.ro>

The pseudo_palette has only 16 elements. Do not write if regno (the array
index) is more than 15.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/tridentfb.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index 55e8aa4..c699864 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -976,7 +976,7 @@ static int tridentfb_setcolreg(unsigned 
 		return 1;
 
 
-	if (bpp==8) {
+	if (bpp == 8) {
 		t_outb(0xFF,0x3C6);
 		t_outb(regno,0x3C8);
 
@@ -984,19 +984,21 @@ static int tridentfb_setcolreg(unsigned 
 		t_outb(green>>10,0x3C9);
 		t_outb(blue>>10,0x3C9);
 
-	} else if (bpp == 16) {	/* RGB 565 */
-		u32 col;
-
-		col = (red & 0xF800) | ((green & 0xFC00) >> 5) |
-			((blue & 0xF800) >> 11);
-		col |= col << 16;	
-		((u32 *)(info->pseudo_palette))[regno] = col;
-	} else if (bpp == 32)		/* ARGB 8888 */
-		((u32*)info->pseudo_palette)[regno] =
-			((transp & 0xFF00) <<16) 	|
-			((red & 0xFF00) << 8) 		|
-			((green & 0xFF00))		|
-			((blue & 0xFF00)>>8);
+	} else if (regno < 16) {
+		if (bpp == 16) {	/* RGB 565 */
+			u32 col;
+
+			col = (red & 0xF800) | ((green & 0xFC00) >> 5) |
+				((blue & 0xF800) >> 11);
+			col |= col << 16;
+			((u32 *)(info->pseudo_palette))[regno] = col;
+		} else if (bpp == 32)		/* ARGB 8888 */
+			((u32*)info->pseudo_palette)[regno] =
+				((transp & 0xFF00) <<16) 	|
+				((red & 0xFF00) << 8) 		|
+				((green & 0xFF00))		|
+				((blue & 0xFF00)>>8);
+	}
 
 //	debug("exit\n");
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
