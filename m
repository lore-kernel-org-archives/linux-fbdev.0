From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/24] sunxvr2500fb: Fix pseudo_palette
	array size
Date: Sat, 02 Jun 2007 18:05:49 +0800
Message-ID: <466140FD.60307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuREF-0003Tl-SR for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:53:04 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQj0-00011W-Nn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:47 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:46 -0700 (PDT)
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

- the pseudo_palette is only 16 elements long.
- the pseudo_palette has only 16 elements. Do not write if regno (the array
  index) is more than 15.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/sunxvr2500.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/video/sunxvr2500.c b/drivers/video/sunxvr2500.c
index 4316c7f..c3869a9 100644
--- a/drivers/video/sunxvr2500.c
+++ b/drivers/video/sunxvr2500.c
@@ -28,7 +28,7 @@ struct s3d_info {
 	unsigned int		depth;
 	unsigned int		fb_size;
 
-	u32			pseudo_palette[256];
+	u32			pseudo_palette[16];
 };
 
 static int __devinit s3d_get_props(struct s3d_info *sp)
@@ -52,15 +52,14 @@ static int s3d_setcolreg(unsigned regno,
 {
 	u32 value;
 
-	if (regno >= 256)
-		return 1;
+	if (regno < 16) {
+		red >>= 8;
+		green >>= 8;
+		blue >>= 8;
 
-	red >>= 8;
-	green >>= 8;
-	blue >>= 8;
-
-	value = (blue << 24) | (green << 16) | (red << 8);
-	((u32 *)info->pseudo_palette)[regno] = value;
+		value = (blue << 24) | (green << 16) | (red << 8);
+		((u32 *)info->pseudo_palette)[regno] = value;
+	}
 
 	return 0;
 }



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
