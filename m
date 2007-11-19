From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] FB: Check default_display parameter
	passed in platform data
Date: Mon, 19 Nov 2007 18:06:55 +0000
Message-ID: <20071119180726.109170735@fluff.org>
References: <20071119180650.568288237@fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IuB23-0006hr-D6 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Nov 2007 10:07:40 -0800
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IuB22-00021C-AY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Nov 2007 10:07:38 -0800
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-s3c2410-check-default-display.patch
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
Cc: vince@simtec.co.uk, Ben Dooks <ben-linux@fluff.org>

Ensure that the default display parameter passed in via the
device's platform data is valid. It turns out when mach-bast.c
was updated, the default_display was set outside of the display
array bounds, causing a panic on startup.

If the default_display is bigger than num_displays, then generate
an error and refuse to initialise the driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.24-rc3-fb1/drivers/video/s3c2410fb.c
===================================================================
--- linux-2.6.24-rc3-fb1.orig/drivers/video/s3c2410fb.c
+++ linux-2.6.24-rc3-fb1/drivers/video/s3c2410fb.c
@@ -799,6 +799,12 @@ static int __init s3c2410fb_probe(struct
 		return -EINVAL;
 	}
 
+	if (mach_info->default_display >= mach_info->num_displays) {
+		dev_err(&pdev->dev, "default is %d but only %d displays\n",
+			mach_info->default_display, mach_info->num_displays);
+		return -EINVAL;
+	}
+
 	display = mach_info->displays + mach_info->default_display;
 
 	irq = platform_get_irq(pdev, 0);

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
