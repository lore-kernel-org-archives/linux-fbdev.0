From: Stefan Schmidt <stefan@openmoko.org>
Subject: [PATCH] s3c2410_fb: Fix line length calculation
Date: Mon, 14 Jan 2008 15:40:04 +0100
Message-ID: <20080114144004.GA8226@datenfreihafen.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JEQT8-0008QB-PI for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 06:39:19 -0800
Received: from sirius.lasnet.de ([62.75.240.18])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JEQT6-0000dd-De
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 06:39:16 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Harald Welte <laforge@openmoko.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Ben Dooks <ben-linux@fluff.org>

Fix line length calculation. var->width is the size of the display in mm. We
like to use the pixel size.

Without this fix, dynamic (fbset) based resolution changes with s3c2410_fb
don't work at all.

Spotted by john cass <johnpcass@yahoo.com>

Signed-off-by: Stefan Schmidt <stefan@openmoko.org>
Signed-off-by: Harald Welte <laforge@openmoko.org>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Acked-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Index: linux-2.6/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.orig/drivers/video/s3c2410fb.c
+++ linux-2.6/drivers/video/s3c2410fb.c
@@ -488,7 +488,7 @@
 		break;
 	}
 
-	info->fix.line_length = (var->width * var->bits_per_pixel) / 8;
+	info->fix.line_length = (var->xres_virtual * var->bits_per_pixel) / 8;
 
 	/* activate this new configuration */
 

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
