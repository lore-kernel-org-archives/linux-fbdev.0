From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/7] nvidiafb: Fix return value of
	nvidiafb_open()
Date: Sun, 29 Apr 2007 11:49:03 +0800
Message-ID: <463415AF.4040106@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hi0Tn-0003bx-11 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:47 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hi0Tm-000446-Nn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Apr 2007 20:53:42 -0700
Received: by py-out-1112.google.com with SMTP id a29so1108343pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 28 Apr 2007 20:53:42 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix return value of nvidiafb_open().

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nvidia.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index 6105753..7c36b5f 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1016,7 +1016,7 @@ static int nvidiafb_release(struct fb_in
 	par->open_count--;
 done:
 	mutex_unlock(&par->open_lock);
-	return 0;
+	return err;
 }
 
 static struct fb_ops nvidia_fb_ops = {


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
