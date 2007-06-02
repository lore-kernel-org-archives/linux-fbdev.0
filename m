From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 13/24] sgivwfb: The pseudo_palette is
	only 16 elements long
Date: Sat, 02 Jun 2007 18:03:24 +0800
Message-ID: <4661406C.3030006@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQrU-0001Cs-R7 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:29:32 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQiv-00011W-DE
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:42 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:41 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jeffrey Newquist <newquist@engr.sgi.com>

The pseudo_palette is only 16 elements long.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/sgivwfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index ebb6756..4fb1624 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -752,7 +752,7 @@ static int __init sgivwfb_probe(struct p
 	struct fb_info *info;
 	char *monitor;
 
-	info = framebuffer_alloc(sizeof(struct sgivw_par) + sizeof(u32) * 256, &dev->dev);
+	info = framebuffer_alloc(sizeof(struct sgivw_par) + sizeof(u32) * 16, &dev->dev);
 	if (!info)
 		return -ENOMEM;
 	par = info->par;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
