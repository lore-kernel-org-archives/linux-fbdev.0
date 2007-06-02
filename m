From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/24] ffb: The pseudo_palette is only
	16 elements long
Date: Sat, 02 Jun 2007 17:57:36 +0800
Message-ID: <46613F10.4050005@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQiN-0000Ef-1a for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:07 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQiM-00011W-OX
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:07 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:06 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "David S. Miller" <davem@davemloft.net>

The pseudo_palette is only 16 elements long.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/ffb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 1d4e835..3f6c98f 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -656,7 +656,7 @@ static int ffb_setcolreg(unsigned regno,
 {
 	u32 value;
 
-	if (regno >= 256)
+	if (regno >= 16)
 		return 1;
 
 	red >>= 8;
@@ -903,7 +903,7 @@ ffb_init_fix(struct fb_info *info)
 struct all_info {
 	struct fb_info info;
 	struct ffb_par par;
-	u32 pseudo_palette[256];
+	u32 pseudo_palette[16];
 };
 
 static int ffb_init_one(struct of_device *op)



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
