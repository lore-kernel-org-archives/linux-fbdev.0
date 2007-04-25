From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 16/41] skeletonfb: Documentation error
	fixes
Date: Wed, 25 Apr 2007 14:36:09 +0800
Message-ID: <462EF6D9.1060303@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc7W-000146-FK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:40:58 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc7V-0002pB-6G
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:40:58 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:40:56 -0700 (PDT)
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

Documentation error fixes.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/skeletonfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index 9fda5b5..7a7ed7d 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -959,11 +959,11 @@ static int xxxfb_suspend(struct platform
 
 /**
  *	xxxfb_resume - Optional but recommended function. Resume the device.
- *	@dev: PCI device
+ *	@dev: platform device
  *
  *      See Documentation/power/devices.txt for more information
  */
-static int xxxfb_suspend(struct platform_dev *dev)
+static int xxxfb_resume(struct platform_dev *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
 	struct xxxfb_par *par = info->par;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
