From: Helge Deller <deller@gmx.de>
Subject: [PATCH] stifb: detect cards in double buffer
	mode more reliable
Date: Mon, 23 Jul 2007 22:09:15 +0200
Message-ID: <200707232209.15432.deller@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ID4Es-0001R3-7t for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jul 2007 13:10:42 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1ID4Ep-0003Yn-KG
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jul 2007 13:10:42 -0700
Content-Disposition: inline
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
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Kyle McMartin <kyle@parisc-linux.org>

stifb: detect cards in double buffer mode more reliable

Visualize-EG, Graffiti and A4450A graphics cards on PARISC can
be configured in double-buffer and standard mode, but the stifb
driver supports standard mode only.
This patch detects double-buffered cards more reliable.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/stifb.c b/drivers/video/stifb.c
index c97709e..3fe3be5 100644
--- a/drivers/video/stifb.c
+++ b/drivers/video/stifb.c
@@ -1100,13 +1100,18 @@ stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	/* only supported cards are allowed */
 	switch (fb->id) {
 	case CRT_ID_VISUALIZE_EG:
-		/* look for a double buffering device like e.g. the 
-		   "INTERNAL_EG_DX1024" in the RDI precisionbook laptop
-		   which won't work. The same device in non-double 
-		   buffering mode returns "INTERNAL_EG_X1024". */
-		if (strstr(sti->outptr.dev_name, "EG_DX")) {
-		   printk(KERN_WARNING 
-			"stifb: ignoring '%s'. Disable double buffering in IPL menu.\n",
+		/* Visualize cards can run either in "double buffer" or 
+ 		  "standard" mode. Depending on the mode, the card reports
+		  a different device name, e.g. "INTERNAL_EG_DX1024" in double
+		  buffer mode and "INTERNAL_EG_X1024" in standard mode.
+		  Since this driver only supports standard mode, we check
+		  if the device name contains the string "DX" and tell the
+		  user how to reconfigure the card. */
+		if (strstr(sti->outptr.dev_name, "DX")) {
+		   printk(KERN_WARNING "WARNING: stifb framebuffer driver does not "
+			"support '%s' in double-buffer mode.\n"
+			KERN_WARNING "WARNING: Please disable the double-buffer mode "
+			"in IPL menu (the PARISC-BIOS).\n",
 			sti->outptr.dev_name);
 		   goto out_err0;
 		}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
