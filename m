From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/3] savagefb: Fix black screen on load
	in Savage IX
Date: Sun, 11 Mar 2007 18:21:16 +0800
Message-ID: <45F3D81C.2080306@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HQLBk-0001Xl-Dy for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 03:22:05 -0700
Received: from wx-out-0506.google.com ([66.249.82.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HQLBg-00047E-EZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 03:22:01 -0700
Received: by wx-out-0506.google.com with SMTP id i30so2002488wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 Mar 2007 03:21:57 -0700 (PDT)
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

This is a hack that seems to kick start the 2D engine of the Savage IX in some
Toshiba laptops. Without this, the laptop starts with a black screen and
occasionally crashes X.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/savage/savagefb_driver.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index 4afa305..d952bf3 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -384,6 +384,19 @@ SavageSetup2DEngine(struct savagefb_par 
 	BCI_SEND(0);
 	BCI_SEND(BCI_CMD_SETREG | (1 << 16) | BCI_GBD2);
 	BCI_SEND(GlobalBitmapDescriptor);
+
+	/*
+	 * I don't know why, sending this twice fixes the intial black screen,
+	 * prevents X from crashing at least in Toshiba laptops with SavageIX.
+	 * --Tony
+	 */
+	par->bci_ptr = 0;
+	par->SavageWaitFifo(par, 4);
+
+	BCI_SEND(BCI_CMD_SETREG | (1 << 16) | BCI_GBD1);
+	BCI_SEND(0);
+	BCI_SEND(BCI_CMD_SETREG | (1 << 16) | BCI_GBD2);
+	BCI_SEND(GlobalBitmapDescriptor);
 }
 
 static void savagefb_set_clip(struct fb_info *info)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
