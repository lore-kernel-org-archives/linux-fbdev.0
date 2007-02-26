From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] hecubafb: Fix section mismatch warnings
Date: Tue, 27 Feb 2007 05:48:38 +0800
Message-ID: <45E355B6.50303@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HLnkX-0003vQ-It for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 13:51:13 -0800
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HLnkW-0003Pq-QW
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Feb 2007 13:51:13 -0800
Received: by py-out-1112.google.com with SMTP id a29so781365pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 26 Feb 2007 13:51:12 -0800 (PST)
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
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix the following compile warnings:

WARNING: drivers/video/hecubafb.o - Section mismatch: reference to .init.data:hecubafb_var from .text between 'hecubafb_probe' (at offset 0x17c) and 'hecubafb_dpy_update'
WARNING: drivers/video/hecubafb.o - Section mismatch: reference to .init.data:hecubafb_var from .text between 'hecubafb_probe' (at offset 0x19e) and 'hecubafb_dpy_update'

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/hecubafb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index a32e1b9..396dc27 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -75,7 +75,7 @@ struct hecubafb_par {
 	unsigned int irq;
 };
 
-static struct fb_fix_screeninfo hecubafb_fix __initdata = {
+static struct fb_fix_screeninfo hecubafb_fix __devinitdata = {
 	.id =		"hecubafb",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_MONO01,
@@ -85,7 +85,7 @@ static struct fb_fix_screeninfo hecubafb
 	.accel =	FB_ACCEL_NONE,
 };
 
-static struct fb_var_screeninfo hecubafb_var __initdata = {
+static struct fb_var_screeninfo hecubafb_var __devinitdata = {
 	.xres		= DPY_W,
 	.yres		= DPY_H,
 	.xres_virtual	= DPY_W,


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
