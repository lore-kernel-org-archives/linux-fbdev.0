From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] maxinefb: Fix compilation error
Date: Tue, 30 May 2006 05:42:50 +0800
Message-ID: <447B6ADA.9000702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkpWv-00060L-6u
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 14:44:05 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FkpWr-0007lm-Ns
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 May 2006 14:44:02 -0700
Received: by py-out-1112.google.com with SMTP id b29so228815pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 May 2006 14:44:01 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Martin Michlmayr <tbm@cyrius.com>

From: Martin Michlmayr <tbm@cyrius.com>

Fix the following compilation error:

CC      drivers/video/maxinefb.o
drivers/video/maxinefb.c:58: warning: initializer-string for array of chars is too long
drivers/video/maxinefb.c:58: warning: (near initialization for \u2018maxinefb_fix.id\u2019)
drivers/video/maxinefb.c:110: error: unknown field \u2018fb_get_fix\u2019 specified in initializer
drivers/video/maxinefb.c:110: error: \u2018gen_get_fix\u2019 undeclared here (not in a function)
drivers/video/maxinefb.c:111: error: unknown field \u2018fb_get_var\u2019 specified in initializer
drivers/video/maxinefb.c:111: error: \u2018gen_get_var\u2019 undeclared here (not in a function)
make[2]: *** [drivers/video/maxinefb.o] Error 1

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/maxinefb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/maxinefb.c b/drivers/video/maxinefb.c
index 743e7ad..f85421b 100644
--- a/drivers/video/maxinefb.c
+++ b/drivers/video/maxinefb.c
@@ -55,7 +55,7 @@ static struct fb_var_screeninfo maxinefb
 };
 
 static struct fb_fix_screeninfo maxinefb_fix = {
-	.id =		"Maxine onboard graphics 1024x768x8",
+	.id =		"Maxine",
 	.smem_len =	(1024*768),
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -107,8 +107,6 @@ static int maxinefb_setcolreg(unsigned r
 
 static struct fb_ops maxinefb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_get_fix	= gen_get_fix,
-	.fb_get_var	= gen_get_var,
 	.fb_setcolreg	= maxinefb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
