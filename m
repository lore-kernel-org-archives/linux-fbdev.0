From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
Subject: Fix for Radeon Framebuffer in 2.5
Date: Tue, 8 Apr 2003 00:38:54 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030408003854.47614717.hanno@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from imap.gmx.net ([213.165.65.60] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 192fGT-00050l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Apr 2003 15:38:58 -0700
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
To: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net

Below is a fix for the radeonfb.
I own one of those radeon mobility cards reporting 0 megs of ram
instead of 8. However, it must be 8 Megs, not 8 kilobyte.
With this fix, radeonfb works fine with 2.5-kernels on my system.

Please apply this patch to the next updates you send to linus.

cu,

Hanno



--- linux-2.5.66-1/drivers/video/radeonfb.c	2003-04-01 11:16:11.000000000 +0200
+++ linux-2.5.66/drivers/video/radeonfb.c	2003-04-07 14:20:10.000000000 +0200
@@ -2936,7 +2936,7 @@
 		switch (pdev->device) {
 			case PCI_DEVICE_ID_ATI_RADEON_LY:
 			case PCI_DEVICE_ID_ATI_RADEON_LZ:
-				rinfo->video_ram = 8192;
+				rinfo->video_ram = 8192 * 1024;
 				break;
 			default:
 				break;


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
