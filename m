From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/3] savagefb: Fix compile error if
	debugging is enabled
Date: Sun, 11 Mar 2007 18:22:21 +0800
Message-ID: <45F3D85D.7030002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HQLBk-0001Xo-Dz for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 03:22:05 -0700
Received: from wx-out-0506.google.com ([66.249.82.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HQLBi-00047E-VW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 03:22:03 -0700
Received: by wx-out-0506.google.com with SMTP id i30so2002488wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 Mar 2007 03:22:02 -0700 (PDT)
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

SavagePrintRegs() requires struct savagefb_par.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/savage/savagefb_driver.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index d952bf3..0166ec2 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -509,7 +509,7 @@ static int common_calc_clock(long freq, 
 #ifdef SAVAGEFB_DEBUG
 /* This function is used to debug, it prints out the contents of s3 regs */
 
-static void SavagePrintRegs(void)
+static void SavagePrintRegs(struct savagefb_par *par)
 {
 	unsigned char i;
 	int vgaCRIndex = 0x3d4;
@@ -1538,7 +1538,7 @@ static int savagefb_set_par(struct fb_in
 	savagefb_set_fix(info);
 	savagefb_set_clip(info);
 
-	SavagePrintRegs();
+	SavagePrintRegs(par);
 	return 0;
 }
 
@@ -2168,7 +2168,6 @@ static int __devinit savagefb_probe(stru
 	int video_len;
 
 	DBG("savagefb_probe");
-	SavagePrintRegs();
 
 	info = framebuffer_alloc(sizeof(struct savagefb_par), &dev->dev);
 	if (!info)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
