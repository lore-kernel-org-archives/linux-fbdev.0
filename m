From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH RESEND 5/9] fbdev: Fix obvious bug in
	show_pan()
Date: Sun, 25 Feb 2007 18:18:06 +0800
Message-ID: <45E1625E.7060602@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLGb3-0006C2-1c for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:13 -0800
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLGb1-00021L-In
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Feb 2007 02:27:12 -0800
Received: by py-out-1112.google.com with SMTP id a29so536398pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Feb 2007 02:27:11 -0800 (PST)
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

show_pan will display the value of the xoffset twice, instead of the xoffset
and yoffset. Fix.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbsysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
index 40c80c8..d4a2c11 100644
--- a/drivers/video/fbsysfs.c
+++ b/drivers/video/fbsysfs.c
@@ -376,7 +376,7 @@ static ssize_t show_pan(struct device *d
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
 	return snprintf(buf, PAGE_SIZE, "%d,%d\n", fb_info->var.xoffset,
-			fb_info->var.xoffset);
+			fb_info->var.yoffset);
 }
 
 static ssize_t show_name(struct device *device,


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
