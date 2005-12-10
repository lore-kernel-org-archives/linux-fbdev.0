From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/18] vesafb: Trim vesafb_pan_display
Date: Sat, 10 Dec 2005 14:10:36 +0800
Message-ID: <439A715C.8070105@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky4O-0002oN-I4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:56 -0800
Received: from zproxy.gmail.com ([64.233.162.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky4N-0004Du-76
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:18:56 -0800
Received: by zproxy.gmail.com with SMTP id o37so1197325nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:18:54 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Remove error checking from vesafb_pan_display.  This is guaranteed to be
done by the core layer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/vesafb.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
index 55e28ba..e6e56b8 100644
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -66,15 +66,6 @@ static int vesafb_pan_display(struct fb_
 #ifdef __i386__
 	int offset;
 
-	if (!ypan)
-		return -EINVAL;
-	if (var->xoffset)
-		return -EINVAL;
-	if (var->yoffset > var->yres_virtual)
-		return -EINVAL;
-	if ((ypan==1) && var->yoffset+var->yres > var->yres_virtual)
-		return -EINVAL;
-
 	offset = (var->yoffset * info->fix.line_length + var->xoffset) / 4;
 
         __asm__ __volatile__(




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
