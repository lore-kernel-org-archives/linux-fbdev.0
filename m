From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/24] sunxvr500fb: Fix pseudo_palette
	array size
Date: Sat, 02 Jun 2007 18:06:07 +0800
Message-ID: <4661410F.6030900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuS8R-0000vP-Ef for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 04:51:09 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQj5-00011W-Ls
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:51 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:51 -0700 (PDT)
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

 drivers/video/sunxvr500.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index 08880a6..71bf3f1 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -50,7 +50,7 @@ struct e3d_info {
 	u32			fb8_0_off;
 	u32			fb8_1_off;
 
-	u32			pseudo_palette[256];
+	u32			pseudo_palette[16];
 };
 
 static int __devinit e3d_get_props(struct e3d_info *ep)
@@ -126,7 +126,9 @@ static int e3d_setcolreg(unsigned regno,
 	blue_8 = blue >> 8;
 
 	value = (blue_8 << 24) | (green_8 << 16) | (red_8 << 8);
-	((u32 *)info->pseudo_palette)[regno] = value;
+
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR && regno < 16)
+		((u32 *)info->pseudo_palette)[regno] = value;
 
 
 	red_10 = red >> 6;



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
