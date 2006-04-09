From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Use logo with depth of 4 or less for static pseudocolor
Date: Sun, 09 Apr 2006 22:02:45 +0800
Message-ID: <44391405.5050900@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FSaVt-0000d5-8o
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Apr 2006 07:03:37 -0700
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FSaVt-00032O-46
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Apr 2006 07:03:37 -0700
Received: by pproxy.gmail.com with SMTP id i49so881641pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Apr 2006 07:03:36 -0700 (PDT)
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

Since the visual STATIC_PSEUDOCOLOR has a read-only colormap, use logos
with 16 colors only since these logos use the console palette.  This has
a higher likelihood that the logo will display correctly.

Signed-of-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 944855b..8d8eadb 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -435,6 +435,11 @@ int fb_prepare_logo(struct fb_info *info
 			depth = info->var.green.length;
 	}
 
+	if (info->fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR) {
+		/* assume console colormap */
+		depth = 4;
+	}
+
 	if (depth >= 8) {
 		switch (info->fix.visual) {
 		case FB_VISUAL_TRUECOLOR:



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
