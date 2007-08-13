From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/22] fbdev: fb_create_modedb()
	non-static `int first = 1; '
Date: Mon, 13 Aug 2007 20:25:10 +0800
Message-ID: <46C04DA6.9070506@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKZJ0-0004IU-J1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:45:58 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZIy-0005O6-NB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:45:58 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:45:56 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

From looking at the code flow, `int first' in fb_create_modedb() should be
static.

[adaplas]
Better for 'int first' to be moved outside the loop.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fbmon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 438b941..af8c37c 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -591,7 +591,9 @@ static struct fb_videomode *fb_create_mo
 {
 	struct fb_videomode *mode, *m;
 	unsigned char *block;
-	int num = 0, i;
+	int num = 0, i, first = 1;
+
+;
 
 	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
 	if (mode == NULL)
@@ -608,8 +610,6 @@ static struct fb_videomode *fb_create_mo
 	DPRINTK("   Detailed Timings\n");
 	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
-	        int first = 1;
-
 		if (!(block[0] == 0x00 && block[1] == 0x00)) {
 			get_detailed_timing(block, &mode[num]);
 			if (first) {



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
