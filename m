From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/8] pm3fb: switching between X and fb
	fix
Date: Thu, 31 May 2007 20:16:52 +0800
Message-ID: <465EBCB4.5020409@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtkPy-0001Ge-EP for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:21 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtkPv-0001YJ-Q9
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:10:17 -0700
Received: by wx-out-0506.google.com with SMTP id t15so151309wxc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 31 May 2007 06:10:15 -0700 (PDT)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch correctly restores console state after switching from X.
Otherwise, screen is always off after switching from X.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 616a0c0..b52e883 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -498,7 +498,7 @@ static int pm3fb_set_par(struct fb_info 
 	else
 		par->video |= PM3VideoControl_LINE_DOUBLE_OFF;
 
-	if (info->var.activate == FB_ACTIVATE_NOW)
+	if ((info->var.activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW)
 		par->video |= PM3VideoControl_ENABLE;
 	else {
 		par->video |= PM3VideoControl_DISABLE;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
