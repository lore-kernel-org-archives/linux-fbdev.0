From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] s3c2410fb: Minor warning fix
Date: Thu, 29 Sep 2005 05:24:38 +0800
Message-ID: <433B0A16.6060206@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKlS9-0001ZY-Bz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 16:35:09 -0700
Received: from xproxy.gmail.com ([66.249.82.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EKlS5-0002Yw-EJ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 16:35:09 -0700
Received: by xproxy.gmail.com with SMTP id s7so145347wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 28 Sep 2005 16:34:59 -0700 (PDT)
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
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux@fluff.org>

From: Ben Dooks <ben-linux@fluff.org>

The function s3c2410fb_activate_var does not return
a value, therefore it should be declared void.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 s3c2410fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -228,8 +228,8 @@ static int s3c2410fb_check_var(struct fb
  * information
 */
 
-static int s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
-				  struct fb_var_screeninfo *var)
+static void s3c2410fb_activate_var(struct s3c2410fb_info *fbi,
+				   struct fb_var_screeninfo *var)
 {
 	fbi->regs.lcdcon1 &= ~S3C2410_LCDCON1_MODEMASK;
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
