From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 20/22] uvesafb: use VISUAL_TRUECOLOR as
	the default visual
Date: Mon, 13 Aug 2007 20:42:55 +0800
Message-ID: <46C051CF.7070702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKcJS-0003Wb-PZ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 08:58:38 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZLM-0005O6-C7
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:48:24 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:48:24 -0700 (PDT)
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
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

Set uvesafb's default visual to truecolor.  This prevents fbcon
from being detected as 'mono' when using uvesafb.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/uvesafb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index e480670..2f1e5af 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -37,6 +37,7 @@ static struct fb_fix_screeninfo uvesafb_
 	.id	= "VESA VGA",
 	.type	= FB_TYPE_PACKED_PIXELS,
 	.accel	= FB_ACCEL_NONE,
+	.visual = FB_VISUAL_TRUECOLOR,
 };
 
 static int mtrr		__devinitdata = 3; /* enable mtrr by default */


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
