From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 29/33] stifb: detect cards in double
	buffer mode more reliably
Date: Thu, 26 Jul 2007 20:49:27 +0800
Message-ID: <46A89857.1030402@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2wM-0001Ho-Tu for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:59:39 -0700
Received: from nz-out-0506.google.com ([64.233.162.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2wK-0000Ru-VY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:59:38 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1353242nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:59:36 -0700 (PDT)
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
Cc: Helge Deller <deller@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Helge Deller <deller@gmx.de>

Visualize-EG, Graffiti and A4450A graphics cards on PARISC can
be configured in double-buffer and standard mode, but the stifb
driver supports standard mode only.
This patch detects double-buffered cards more reliable.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/stifb.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/stifb.c b/drivers/video/stifb.c
index c97709e..e7c8db2 100644
--- a/drivers/video/stifb.c
+++ b/drivers/video/stifb.c
@@ -1100,13 +1100,18 @@ stifb_init_fb(struct sti_struct *sti, in
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
