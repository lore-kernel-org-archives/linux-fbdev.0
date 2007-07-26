From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/33] xilinxfb:Remove __initdata from
	xilinx_fb_fix and xilinx_fb_var
Date: Thu, 26 Jul 2007 19:49:09 +0800
Message-ID: <46A88A35.8080901@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2sU-0000la-VE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:39 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2sT-0007HM-Nr
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:38 -0700
Received: by wa-out-1112.google.com with SMTP id k22so613963waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:55:37 -0700 (PDT)
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Andrei Konovalov <akonovalov@ru.mvista.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Grant Likely <grant.likely@secretlab.ca>

xilinxfb_drv_probe refers to both tables, but it cannot be initdata.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
cc: Andrei Konovalov <akonovalov@ru.mvista.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/xilinxfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 1d29a89..44ce955 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -79,7 +79,7 @@ #define PALETTE_ENTRIES_NO	16	/* passed 
 /*
  * Here are the default fb_fix_screeninfo and fb_var_screeninfo structures
  */
-static struct fb_fix_screeninfo xilinx_fb_fix __initdata = {
+static struct fb_fix_screeninfo xilinx_fb_fix = {
 	.id =		"Xilinx",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
@@ -88,7 +88,7 @@ static struct fb_fix_screeninfo xilinx_f
 	.accel =	FB_ACCEL_NONE
 };
 
-static struct fb_var_screeninfo xilinx_fb_var __initdata = {
+static struct fb_var_screeninfo xilinx_fb_var = {
 	.xres =			XRES,
 	.yres =			YRES,
 	.xres_virtual =		XRES_VIRTUAL,


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
