From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] Funny sync calculation correction
Date: 25 Jan 2003 00:17:23 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043450243.10711.41.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailf.telia.com ([194.22.194.25])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cD3s-00078l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 15:16:36 -0800
Received: from h9n1fls20o980.telia.com (h9n1fls20o980.telia.com [213.65.208.9])
	by mailf.telia.com (8.12.5/8.12.5) with ESMTP id h0ONG2TW028074
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 25 Jan 2003 00:16:02 +0100 (CET)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

I've been digging around in the rivafb module to find out why some
modes converted from XFree86 4.2 don't work on some display devices.
Here's a funny part of the riva_load_video_mode function (Linux
2.4.21-pre2):

	hStart = (hDisplaySize + video_mode->right_margin) / 8 + 2;
	hEnd   = (hDisplaySize + video_mode->right_margin +
		 video_mode->hsync_len) / 8 - 1;

Please notice how "hsync_len" does not actually represent the length
of the sync. Rather, it's compensated with 24 pixels. The corresponding
code in the XFree86 4.2 (nv_dac.c) contains no such compensation:

    int horizStart      = (mode->CrtcHSyncStart/8) - 1;
    int horizEnd        = (mode->CrtcHSyncEnd/8)   - 1;

The difference seems to be almost insignificant for modern multisync
screens, but devices such as TV:s get confused by the current version.
Is there a reason for the difference in calculations?

The attached patch corrects the calculations in accordance with XFree86
and works better with the modelines I've tested. 

Please give it a try. Thanks,

	Fredrik

--- linux-2.4.21-pre2/drivers/video/riva/fbdev.c.orig	2003-01-24 23:59:56.000000000 +0100
+++ linux-2.4.21-pre2/drivers/video/riva/fbdev.c	2003-01-25 00:00:24.000000000 +0100
@@ -874,7 +874,7 @@
 	width = video_mode->xres_virtual;
 	hDisplaySize = video_mode->xres;
 	hDisplay = (hDisplaySize / 8) - 1;
-	hStart = (hDisplaySize + video_mode->right_margin) / 8 + 2;
+	hStart = (hDisplaySize + video_mode->right_margin) / 8 - 1;
 	hEnd = (hDisplaySize + video_mode->right_margin +
 		video_mode->hsync_len) / 8 - 1;
 	hTotal = (hDisplaySize + video_mode->right_margin +



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
